import 'package:chapa_admin/generated/assets.gen.dart';
import 'package:chapa_admin/locator.dart';
import 'package:chapa_admin/navigation_service.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/widgets/image.dart';
import 'package:chapa_admin/widgets/page_loader.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class AlertDialogHandler {
  static void showAlertDialog(
      {required BuildContext context,
      required Widget child,
      required bool isLoading,
      Color? color,
      String? heading}) {
    showDialog(
        context: context,
        barrierDismissible: isLoading ? false : true,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: color ?? Colors.white,
              surfaceTintColor: color ?? Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              content: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 26),
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        30.height,
                        if (heading != null) ...[
                          Text(
                            heading,
                            style: AppStyles.urbanist24Xbd,
                          ),
                        ],
                        20.height,
                        child,
                      ],
                    )),
                  ),
                  Positioned(
                    right: 22,
                    top: 22,
                    child: InkWell(
                      onTap: () => locator<NavigationService>().goBack(),
                      child: Row(
                        children: [
                          isLoading
                              ? const PageLoader()
                              : LocalSvgIcon(
                                  Assets.icons.linear.closeCircle,
                                  color: Colors.black,
                                ),
                          10.width,
                          Text("Close"),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          });
        });
  }

  static void showDeleteDialog(
      {required BuildContext context,
      required bool isLoading,
      required VoidCallback onpressed,
      Color? color,
      String? heading,
      String? subheading}) {
    showDialog(
        context: context,
        barrierDismissible: isLoading ? false : true,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: color ?? Colors.white,
              surfaceTintColor: color ?? Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              content: Stack(
                children: [
                  IntrinsicHeight(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 26),
                      constraints: BoxConstraints(
                        maxWidth: context.getWidth(.4),
                      ),
                      child: Column(
                        children: [
                          30.height,
                          Text(
                            heading ?? "Delete Item?",
                            style: AppStyles.urbanist24Xbd,
                          ),
                          20.height,
                          Text(
                            subheading ??
                                "You are about to delete this item. Are you sure?",
                            style: AppStyles.urbanist16Md,
                          ),
                          20.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton.icon(
                                  style: TextButton.styleFrom(
                                    backgroundColor: AppColors.red,
                                    surfaceTintColor: AppColors.red,
                                  ),
                                  onPressed: () =>
                                      locator<NavigationService>().goBack(),
                                  icon: LocalSvgIcon(
                                    Assets.icons.linear.closeCircle,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    "Cancel",
                                    style: AppStyles.urbanist14Smbd.copyWith(
                                      color: Colors.white,
                                    ),
                                  )),
                              20.width,
                              TextButton.icon(
                                  style: TextButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    surfaceTintColor: AppColors.primary,
                                  ),
                                  onPressed: onpressed,
                                  icon: LocalSvgIcon(
                                    Assets.icons.linear.check,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    "Continue",
                                    style: AppStyles.urbanist14Smbd.copyWith(
                                      color: Colors.white,
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 22,
                    top: 22,
                    child: InkWell(
                      onTap: () => locator<NavigationService>().goBack(),
                      child: Row(
                        children: [
                          isLoading
                              ? const PageLoader()
                              : LocalSvgIcon(
                                  Assets.icons.linear.closeCircle,
                                  color: Colors.black,
                                ),
                          10.width,
                          Text("Close"),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          });
        });
  }
}
