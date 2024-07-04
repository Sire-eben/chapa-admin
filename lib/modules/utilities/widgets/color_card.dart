import 'package:chapa_admin/generated/assets.gen.dart';
import 'package:chapa_admin/handlers/alert_dialog_handler.dart';
import 'package:chapa_admin/locator.dart';
import 'package:chapa_admin/modules/utilities/models/color_model.dart';
import 'package:chapa_admin/modules/utilities/service/utils_service.dart';
import 'package:chapa_admin/navigation_service.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ColorCard extends StatelessWidget {
  const ColorCard(
      {super.key,
      required this.data,
      required this.utilitiesService,
      required this.index});
  final ColorModel data;
  final UtilitiesService utilitiesService;
  final int index;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        width: context.getWidth(.4),
        // constraints: BoxConstraints(maxWidth: context.getWidth(.4)),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
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
            Expanded(child: Text(Utils().formatDate(data.added))),
            20.width,
            Expanded(
                child: Row(
              children: [
                LocalSvgIcon(Assets.icons.linear.eye),
                10.width,
                LocalSvgIcon(Assets.icons.linear.edit),
                10.width,
                InkWell(
                    onTap: () {
                      AlertDialogHandler.showDeleteDialog(
                        context: context,
                        isLoading: utilitiesService.isLoading,
                        onpressed: () async {
                          await utilitiesService.deleteColor(id: data.id);
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
