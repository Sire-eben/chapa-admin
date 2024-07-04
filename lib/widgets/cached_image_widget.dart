import 'package:cached_network_image/cached_network_image.dart';
import 'package:chapa_admin/generated/assets.gen.dart';
import 'package:chapa_admin/utils/app_themes.dart';
import 'package:chapa_admin/widgets/image.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class CachedImageWidget extends StatelessWidget {
  const CachedImageWidget({
    super.key,
    required this.imageUrl,
    this.errorText,
    this.height = 40,
    this.width = 40,
    // this.shape = BoxShape.circle,
    this.borderColor = Colors.white,
    this.borderRadius,
    this.fontSize,
  });

  final String imageUrl;
  final String? errorText;
  final double height, width;
  final Color borderColor;
  // final BoxShape shape;
  final double? borderRadius, fontSize;

  @override
  Widget build(BuildContext context) {
    String secureUrl = imageUrl;
    if (imageUrl.contains("http://")) {
      secureUrl = secureUrl.replaceAll("http://", "https://");
    }
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      imageBuilder: (context, imageProvider) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: AppColors.idleState,
            border: Border.all(width: 2, color: borderColor),
            borderRadius: BorderRadius.circular(borderRadius ?? 100),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) => Container(
          alignment: Alignment.center,
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 100),
            color: AppColors.backgroundColor,
          ),
          child: Icon(
            Icons.error,
            color: AppColors.primary,
          )),
      placeholder: (context, url) => Container(
          alignment: Alignment.center,
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(borderRadius ?? 100),
          ),
          child: const CupertinoActivityIndicator()),
    );
  }
}
