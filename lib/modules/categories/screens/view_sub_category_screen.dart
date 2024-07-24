import 'package:chapa_admin/locator.dart';
import 'package:chapa_admin/modules/categories/models/sub_categories.dart';
import 'package:chapa_admin/modules/categories/service/category_service.dart';
import 'package:chapa_admin/modules/categories/widgets/shopping_list_item.dart';
import 'package:chapa_admin/modules/categories/widgets/shopping_list_item_for_view.dart';
import 'package:chapa_admin/navigation_service.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/utils/app_themes.dart';
import 'package:chapa_admin/widgets/cached_image_widget.dart';
import 'package:chapa_admin/widgets/input_fields/amount_text_field.dart';
import 'package:chapa_admin/widgets/input_fields/text_field.dart';
import 'package:chapa_admin/widgets/page_loader.dart';
import 'package:chapa_admin/widgets/primary_btn.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class ViewSubCategoryScreen extends StatefulWidget {
  const ViewSubCategoryScreen({super.key, required this.subCategoriesModel});
  final SubCategoriesModel subCategoriesModel;

  @override
  State<ViewSubCategoryScreen> createState() => _ViewSubCategoryScreenState();
}

class _ViewSubCategoryScreenState extends State<ViewSubCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final data = widget.subCategoriesModel;

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
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomTextField(
                                enabled: false,
                                labelText: 'Category Name',
                                hintText: data.name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a category name';
                                  }
                                  return null;
                                },
                              ),
                              20.height,
                              CustomTextField(
                                enabled: false,
                                maxLines: 5,
                                labelText: 'Description',
                                hintText: data.description,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a category name';
                                  }
                                  return null;
                                },
                              ),
                              20.height,
                              Container(
                                height: 300,
                                width: 500,
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22),
                                    border: Border.all(
                                      color: AppColors.primary,
                                    )),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Qualities for this item",
                                        style: AppStyles.urbanist16SmBd,
                                      ),
                                      10.height,
                                      ListView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: data.qualities.length,
                                        itemBuilder: (context, index) {
                                          final item = data.qualities[index];
                                          return ShoppingListItemForView(
                                            item: item,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        50.width,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              20.height,
                              if (data.images.isNotEmpty)
                                SizedBox(
                                  height: 120,
                                  width: context.getWidth(.4),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.images.length,
                                    itemBuilder: (context, index) {
                                      final image = data.images[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CachedImageWidget(
                                          imageUrl: image,
                                          height: 100,
                                          width: 100,
                                          borderRadius: 2,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              20.height,
                              CustomTextField(
                                enabled: false,
                                labelText: 'Specifications',
                                hintText: data.specifications,
                                textInputAction: TextInputAction.newline,
                                maxLines: 5,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a category name';
                                  }
                                  return null;
                                },
                              ),
                              12.height,
                              const Text("Select Colors"),
                              12.height,
                              Wrap(
                                  alignment: WrapAlignment.start,
                                  spacing: 12,
                                  runSpacing:
                                      12, // Vertical spacing between rows
                                  children:
                                      List.generate(data.color.length, (index) {
                                    final color = data.color[index];

                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 12),
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: AppColors.secondary)),
                                      child: Text(
                                        color,
                                        style: AppStyles.urbanistGeneral(
                                          13,
                                          FontWeight.w700,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    );
                                  })),
                              20.height,
                              const Text("Select Sizes"),
                              12.height,
                              Wrap(
                                  alignment: WrapAlignment.start,
                                  spacing: 12,
                                  runSpacing:
                                      12, // Vertical spacing between rows
                                  children:
                                      List.generate(data.size.length, (index) {
                                    final size = data.size[index];

                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 12),
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: AppColors.secondary)),
                                      child: Text(
                                        size,
                                        style: AppStyles.urbanistGeneral(
                                          13,
                                          FontWeight.w700,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    );
                                  })),
                            ],
                          ),
                        )
                      ],
                    ),
                    24.height,
                    PrimaryButton(
                      width: context.getWidth(.4),
                      onPressed: () => locator<NavigationService>().goBack(),
                      label: 'close',
                    ),
                  ],
                ),
        ),
      );
    });
  }
}
