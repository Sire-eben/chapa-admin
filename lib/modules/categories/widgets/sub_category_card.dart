import 'package:chapa_admin/generated/assets.gen.dart';
import 'package:chapa_admin/handlers/alert_dialog_handler.dart';
import 'package:chapa_admin/locator.dart';
import 'package:chapa_admin/modules/categories/models/categories.dart';
import 'package:chapa_admin/modules/categories/models/sub_categories.dart';
import 'package:chapa_admin/modules/categories/screens/add_sub_category_screen.dart';
import 'package:chapa_admin/modules/categories/screens/edit_sub_category_screen.dart';
import 'package:chapa_admin/modules/categories/screens/view_sub_category_screen.dart';
import 'package:chapa_admin/modules/categories/service/category_service.dart';
import 'package:chapa_admin/navigation_service.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/widgets/cached_image_widget.dart';
import 'package:chapa_admin/widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nb_utils/nb_utils.dart';

class SubCategoryCard extends StatelessWidget {
  const SubCategoryCard(
      {super.key,
      required this.data,
      required this.index,
      required this.categoryService,
      required this.categoriesModel});
  final SubCategoriesModel data;
  final CategoriesModel categoriesModel;
  final int index;
  final CategoryService categoryService;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: context.getWidth(.6)),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: Shadows.universal,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          AlertDialogHandler.showAlertDialog(
              context: context,
              child: ViewSubCategoryScreen(subCategoriesModel: data),
              isLoading: false,
              heading: data.name);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
                radius: 12,
                backgroundColor: AppColors.idleState,
                child: Text("${index + 1}.")),
            Gap(context.getWidth(.015)),
            CachedImageWidget(
              imageUrl: data.images.first,
              height: 40,
              borderRadius: 1,
            ),
            Gap(context.getWidth(.015)),
            Expanded(child: Text(data.name, style: AppStyles.urbanist14Md)),
            if (data.size.isNotEmpty) ...[
              20.width,
              Expanded(
                  child: Center(
                child: Text(
                  data.size.map((size) => size.capitalize).join(', '),
                  textAlign: TextAlign.center,
                ),
              )),
            ] else ...[
              20.width,
              Expanded(child: Text("")),
            ],
            if (data.color.isNotEmpty) ...[
              20.width,
              Expanded(
                  child: Center(
                child: Text(
                  data.color.map((color) => color.capitalize).join(', '),
                  textAlign: TextAlign.center,
                ),
              )),
            ] else ...[
              20.width,
              Expanded(child: Text("")),
            ],
            20.width,
            Expanded(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        "Fair Quality - ${Utils.formatAmount(data.lower_price)}"),
                    Text(
                        "High Quality - ${Utils.formatAmount(data.higher_price)}"),
                  ],
                ),
              ),
            ),
            20.width,
            Expanded(
                child: Center(
                    child: Center(
                        child: Text(Utils.formatAmount(data.design_price))))),
            20.width,
            Expanded(
                child: Center(
                    child: Text(
              data.specifications,
              textAlign: TextAlign.center,
            ))),
            20.width,
            Expanded(
                child: Center(child: Text(Utils().formatDate(data.added)))),
            20.width,
            Expanded(
                child: Row(
              children: [
                InkWell(
                    onTap: () {
                      AlertDialogHandler.showAlertDialog(
                          context: context,
                          child:
                              ViewSubCategoryScreen(subCategoriesModel: data),
                          isLoading: false,
                          heading: data.name);
                    },
                    child: LocalSvgIcon(Assets.icons.linear.eye)),
                10.width,
                InkWell(
                    onTap: () {
                      AlertDialogHandler.showAlertDialog(
                          context: context,
                          child: EditSubCategoryScreen(
                            isEdit: true,
                            categoriesModel: categoriesModel,
                            subCategoriesModel: data,
                          ),
                          isLoading: categoryService.isLoading,
                          heading: "Edit ${data.name}");
                    },
                    child: LocalSvgIcon(Assets.icons.linear.edit)),
                10.width,
                InkWell(
                    onTap: () {
                      AlertDialogHandler.showDeleteDialog(
                          context: context,
                          isLoading: categoryService.isLoading,
                          onpressed: () async {
                            await categoryService
                                .deleteSubcategory(
                                    id: data.id, catId: data.cat_id)
                                .whenComplete(
                              () {
                                categoryService.getSubcategories(data.cat_id);
                                locator<NavigationService>().goBack();
                              },
                            );
                          });
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
