import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/widgets/general_info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SnackbarHandler {
  static void showErrorSnackbar({
    required BuildContext context,
    String? message,
    Widget? icon,
  }) {
    return showTopSnackBar(
      Overlay.of(context),
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
      Material(
        type: MaterialType.transparency,
        child: Container(
          // width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          decoration: BoxDecoration(
              color: AppColors.red,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.white)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              icon ?? const Icon(Icons.error, color: Colors.white),
              Gap(12),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * .75,
                ),
                child: ClipRRect(
                  child: Text(
                    message ?? "An error occurred",
                    style: AppStyles.urbanistGeneral(12, FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static void showSuccessSnackbar({
    required BuildContext context,
    String? message,
    Widget? icon,
  }) {
    return showTopSnackBar(
      Overlay.of(context),
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
      Material(
        type: MaterialType.transparency,
        child: Container(
          // width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.green)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              icon ?? const Icon(Icons.check_circle, color: Colors.white),
              Gap(12),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * .75,
                ),
                child: ClipRRect(
                  child: Text(
                    message ?? "Successful",
                    style: AppStyles.urbanistGeneral(12, FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static void showHuzzDialog({
    required BuildContext context,
    String? message,
    Widget? child,
    VoidCallback? onPressed,
    bool oneButton = true,
  }) {
    huzzInfoDialog(
        oneButton: oneButton,
        context: context,
        dialog: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.info_outline_rounded,
              size: 27,
              color: Colors.red,
            ),
            const SizedBox(height: 7),
            if (child == null)
              Text(message ?? "Error",
                  textAlign: TextAlign.center, style: AppStyles.urbanist12Md)
            else
              child
          ],
        ),
        onPressed: onPressed ?? () => context.pop());
  }
}
