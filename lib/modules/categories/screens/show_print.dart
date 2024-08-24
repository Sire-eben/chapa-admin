import 'package:chapa_admin/generated/assets.gen.dart';
import 'package:chapa_admin/handlers/alert_dialog_handler.dart';
import 'package:chapa_admin/locator.dart';
import 'package:chapa_admin/modules/categories/models/categories.dart';
import 'package:chapa_admin/modules/categories/models/print_service.dart';
import 'package:chapa_admin/modules/categories/models/sub_categories.dart';
import 'package:chapa_admin/modules/categories/service/category_service.dart';
import 'package:chapa_admin/navigation_service.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/widgets/cached_image_widget.dart';
import 'package:chapa_admin/widgets/image.dart';
import 'package:chapa_admin/widgets/page_loader.dart';
import 'package:chapa_admin/widgets/primary_btn.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import 'add_print.dart';

class ShowPrintService extends StatelessWidget {
  const ShowPrintService(
      {super.key,
      required this.printServiceModel,
      required this.categoriesModel,
      required this.subCategoriesModel});

  final List<PrintServiceModel> printServiceModel;
  final CategoriesModel categoriesModel;
  final SubCategoriesModel subCategoriesModel;

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryService>(builder: (context, categoryService, __) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        constraints: BoxConstraints(
          maxWidth: context.getWidth(.7),
        ),
        child: Center(
          child: categoryService.isLoading
              ? const PageLoader()
              : Column(
                  children: [
                    Container(
                      height: context.getHeight(.4),
                      width: context.getWidth(.45),
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: ListView.builder(
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          itemCount: printServiceModel.length,
                          itemBuilder: (context, index) {
                            final print = printServiceModel[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${index + 1})",
                                      style: AppStyles.urbanist16SmBd),
                                  20.width,
                                  Text(print.name,
                                      style: AppStyles.urbanist16SmBd),
                                  20.width,
                                  Text(
                                      Utils.formatAmount(
                                          print.price.toString()),
                                      style: AppStyles.urbanist16SmBd),
                                  20.width,
                                  SizedBox(
                                    height: 65,
                                    width: context.getWidth(.2),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: print.images.length,
                                      itemBuilder: (context, index) {
                                        final image = print.images[index];
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: CachedImageWidget(
                                            imageUrl: image,
                                            height: 65,
                                            width: 65,
                                            borderRadius: 1,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  20.width,
                                  Expanded(
                                      child: InkWell(
                                    onTap: () {
                                      AlertDialogHandler.showDeleteDialog(
                                          context: context,
                                          isLoading: categoryService.isLoading,
                                          onpressed: () async {
                                            await categoryService
                                                .deletePrintingService(
                                                    catId: categoriesModel.id,
                                                    subcatId:
                                                        subCategoriesModel.id,
                                                    printModel: print)
                                                .whenComplete(
                                              () {
                                                categoryService
                                                    .getSubcategories(
                                                        categoriesModel.id);
                                                printServiceModel.remove(print);
                                                locator<NavigationService>()
                                                    .goBack();
                                              },
                                            );
                                          });
                                    },
                                    child: Row(
                                      children: [
                                        Text("Delete item ",
                                            style: AppStyles.urbanist16SmBd
                                                .copyWith(color: Colors.red)),
                                        LocalSvgIcon(
                                          Assets.icons.linear.trash,
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            );
                          }),
                    ),
                    24.height,
                    PrimaryButton(
                      width: context.getWidth(.4),
                      onPressed: () {
                        locator<NavigationService>().goBack();
                        AlertDialogHandler.showAlertDialog(
                            context: context,
                            child: AddPrintService(
                                categoriesModel: categoriesModel,
                                subCategoriesModel: subCategoriesModel),
                            isLoading: categoryService.isLoading,
                            heading: "Add Print");
                      },
                      label: 'Add More Print Services',
                    ),
                  ],
                ),
        ),
      );
    });
  }
}
