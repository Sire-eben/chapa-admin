import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../generated/assets.gen.dart';

class CallToActionMobile extends StatelessWidget {
  final String text;
  final VoidCallback action;

  const CallToActionMobile({
    Key? key,
    required this.text,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(Insets.md),
              backgroundColor: AppColors.primary,
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          onPressed: action,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text, style: AppStyles.urbanist16Md),
              const Gap(Insets.lg),
              LocalSvgIcon(
                Assets.icons.bulk.arrowCircleRight,
                color: Colors.white,
              ),
            ],
          )),
    );
  }
}
