import 'package:chapa_admin/generated/assets.gen.dart';
import 'package:chapa_admin/handlers/alert_dialog_handler.dart';
import 'package:chapa_admin/locator.dart';
import 'package:chapa_admin/modules/printing_qualities/models/prints.dart';
import 'package:chapa_admin/modules/printing_qualities/screens/add_quality.dart';
import 'package:chapa_admin/modules/printing_qualities/service/print_service.dart';
import 'package:chapa_admin/navigation_service.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class PrintCard extends StatelessWidget {
  const PrintCard(
      {super.key,
      required this.data,
      required this.printingService,
      required this.index});
  final PrintingServicesModel data;
  final PrintingService printingService;
  final int index;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        width: context.getWidth(.4),
        // constraints: BoxConstraints(maxWidth: context.getWidth(.4)),
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.white,
          // boxShadow: Shadows.universal,
          // borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text("${index + 1}.", style: AppStyles.urbanist14Md)),
            20.width,
            Expanded(child: Text(data.name, style: AppStyles.urbanist14Md)),
            20.width,
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(children: [
                      TextSpan(
                        text: Utils.formatAmount(data.price),
                        style: AppStyles.urbanist14Md,
                      ),
                      TextSpan(
                        text: " per ${data.unit}",
                        style: AppStyles.urbanist14Smbd.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ])),
              ],
            )),
            20.width,
            Expanded(child: Text(Utils().formatDate(data.added))),
            20.width,
            Expanded(
                child: Row(
              children: [
                LocalSvgIcon(Assets.icons.linear.eye),
                10.width,
                InkWell(
                    onTap: () {
                      AlertDialogHandler.showAlertDialog(
                        context: context,
                        child: AddPrintingServiceDialog(
                          isEditing: true,
                          printingServicesModel: data,
                        ),
                        isLoading: false,
                        heading: "Edit service",
                      );
                    },
                    child: LocalSvgIcon(Assets.icons.linear.edit)),
                10.width,
                InkWell(
                    onTap: () {
                      AlertDialogHandler.showDeleteDialog(
                        context: context,
                        isLoading: printingService.isLoading,
                        onpressed: () async {
                          await printingService.deletePrintService(id: data.id);
                          locator<NavigationService>().goBack();
                        },
                      );
                    },
                    child: LocalSvgIcon(Assets.icons.linear.trash)),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
