import 'package:chapa_admin/utils/__utils.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'loading.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    this.child,
    required this.onPressed,
    this.backgroundColor,
    this.width,
    this.height,
    this.isLoading,
    this.isFilled,
    this.borderRadius,
    this.borderColor,
    this.label,
    this.style,
    this.shadow,
    this.elevation,
    this.textColor,
    super.key,
  });

  final Function()? onPressed;
  final Widget? child;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? backgroundColor;
  final bool? isLoading;
  final bool? isFilled;
  final Color? borderColor, textColor;
  final String? label;
  final TextStyle? style;
  final BoxShadow? shadow;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          disabledBackgroundColor: AppColors.idleState,
          backgroundColor: backgroundColor ?? AppColors.primary,
          fixedSize: Size(width ?? double.maxFinite, height ?? 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
          ),
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
          ),
          elevation: elevation ?? 0),
      child: isLoading == true
          ? const Center(
              child: LoadingWidget(
                color: Colors.white,
              ),
            )
          : child ??
              Text(
                label ?? "Sign in",
                textAlign: TextAlign.center,
                style: style ??
                    GoogleFonts.urbanist(
                        color: textColor ?? AppColors.white, fontSize: 16),
              ),
    );
  }
}
