import 'package:chapa_admin/generated/assets.gen.dart';
import 'package:chapa_admin/handlers/alert_dialog_handler.dart';
import 'package:chapa_admin/locator.dart';
import 'package:chapa_admin/modules/categories/models/categories.dart';
import 'package:chapa_admin/modules/categories/screens/edit_category.dart';
import 'package:chapa_admin/modules/categories/screens/sub_categories.dart';
import 'package:chapa_admin/modules/categories/service/category_service.dart';
import 'package:chapa_admin/navigation_service.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/widgets/cached_image_widget.dart';
import 'package:chapa_admin/widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nb_utils/nb_utils.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {super.key, required this.data, required this.categoryService});
  final CategoriesModel data;
  final CategoryService categoryService;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        width: context.getWidth(.4),
        // constraints: BoxConstraints(maxWidth: context.getWidth(.4)),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: Shadows.universal,
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            locator<NavigationService>().chapaNavigatorKey.currentState?.push(
                  MaterialPageRoute(
                      builder: (context) =>
                          SubCategoriesScreen(categoriesModel: data)),
                );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CachedImageWidget(
                imageUrl: data.url,
                height: 40,
                borderRadius: 1,
              ),
              Gap(context.getWidth(.1)),
              Expanded(child: Text(data.name, style: AppStyles.urbanist14Md)),
              30.width,
              Expanded(
                  child: Text(Utils.formatAmount(data.design_price),
                      style: AppStyles.urbanist14Md)),
              // 30.width,
              // Expanded(
              //     child: ListView.builder(
              //         shrinkWrap: true,
              //         physics: NeverScrollableScrollPhysics(),
              //         padding: EdgeInsets.zero,
              //         itemCount: categoryService
              //             .getPrintServices(data.printing_services)
              //             .length,
              //         itemBuilder: (_, index) {
              //           final service = categoryService
              //               .getPrintServices(data.printing_services)[index];
              //           return Text(
              //               "${service.name} - ${Utils.formatAmount(service.price)}",
              //               style: AppStyles.urbanist14Md);
              //         })),
              30.width,
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
                            child: EditCategory(categoriesModel: data),
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
                            await categoryService.deleteCategory(id: data.id);
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
      ),
    );
  }
}
