import 'package:chapa_admin/handlers/snackbar.dart';
import 'package:chapa_admin/locator.dart';
import 'package:chapa_admin/modules/categories/models/categories.dart';
import 'package:chapa_admin/modules/categories/models/sub_categories.dart';
import 'package:chapa_admin/modules/categories/service/category_service.dart';
import 'package:chapa_admin/modules/categories/widgets/shopping_list_item.dart';
import 'package:chapa_admin/navigation_service.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/widgets/input_fields/text_field.dart';
import 'package:chapa_admin/widgets/page_loader.dart';
import 'package:chapa_admin/widgets/primary_btn.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class EditSubCategoryScreen extends StatefulWidget {
  const EditSubCategoryScreen({
    super.key,
    required this.categoriesModel,
    this.isEdit = false,
    required this.subCategoriesModel,
  });
  final CategoriesModel categoriesModel;
  final SubCategoriesModel subCategoriesModel;
  final bool isEdit;

  @override
  _EditSubCategoryScreenState createState() => _EditSubCategoryScreenState();
}

class _EditSubCategoryScreenState extends State<EditSubCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _categoryNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _specController = TextEditingController();
  final service = locator<CategoryService>();

  List<Uint8List> images = [];
  List<String> selectedFiles = [];

  void _selectFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      setState(() {
        selectedFiles = result.files.map((file) => file.name).toList();
        images = result.files.map((file) => file.bytes!).toList();
      });
    }
  }

  Future<void> _editCategory(
      BuildContext context, CategoryService categoryService) async {
    if (!_formKey.currentState!.validate()) return;
    if (images.isNotEmpty) {
      setState(() {});

      try {
        List<String> imageUrls = [];
        for (int i = 0; i < images.length; i++) {
          String imageUrl =
              await categoryService.uploadImage(images[i], selectedFiles[i]);
          imageUrls.add(imageUrl);
        }

        await categoryService.editSubcategory(
          name: _categoryNameController.text,
          description: _descriptionController.text,
          specifications: _specController.text,
          catId: widget.categoriesModel.id,
          subcatId: widget.subCategoriesModel.id,
          colors: selectedColors,
          sizes: selectedSizes,
          designPrice: widget.categoriesModel.design_price,
          images: imageUrls,
        );

        Future.delayed(Duration.zero, () {
          SnackbarHandler.showSuccessSnackbar(
              context: context, message: 'Changes saved successfully!');
          categoryService.getSubcategories(widget.categoriesModel.id);
          locator<NavigationService>().goBack();
        });
      } catch (e) {
        setState(() {});
        Future.delayed(Duration.zero, () {
          SnackbarHandler.showErrorSnackbar(
              context: context, message: 'Failed to add subcategory: $e');
        });
      }
    } else {
      SnackbarHandler.showErrorSnackbar(
          context: context, message: 'Please pick at least one image');
    }
  }

  List<String> selectedColors = [];
  List<String> selectedSizes = [];
  bool _isAssigning = false;
  fetchDetails() async {
    setState(() {
      _isAssigning = true;
    });
    await service.getColors();
    await service.getSizes();
    service.itemQualities.clear();
    service.addMoreQualities(fill: 1);
    setState(() {
      _categoryNameController.text = widget.subCategoriesModel.name;
      _descriptionController.text = widget.subCategoriesModel.description;
      _specController.text = widget.subCategoriesModel.specifications;
      selectedColors.addAll(widget.subCategoriesModel.color);
      selectedSizes.addAll(widget.subCategoriesModel.size);
      _isAssigning = false;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => fetchDetails());
  }

  @override
  Widget build(BuildContext context) {
    // final categoryService = Provider.of<CategoryService>(context);

    return Consumer<CategoryService>(builder: (context, categoryService, __) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        constraints: BoxConstraints(
          maxWidth: context.getWidth(.7),
        ),
        child: Center(
          child: categoryService.isLoading || _isAssigning
              ? const PageLoader()
              : Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomTextField(
                                  controller: _categoryNameController,
                                  labelText: 'Category Name',
                                  hintText: 'Enter Category Name',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a category name';
                                    }
                                    return null;
                                  },
                                ),
                                20.height,
                                CustomTextField(
                                  controller: _descriptionController,
                                  maxLines: 5,
                                  labelText: 'Description',
                                  hintText: 'Enter Description',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a category name';
                                    }
                                    return null;
                                  },
                                ),
                                20.height,
                                IntrinsicHeight(
                                  child: Container(
                                    height: 400,
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
                                            "Add Qualities for this item",
                                            style: AppStyles.urbanist16SmBd,
                                          ),
                                          10.height,
                                          ListView.builder(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: categoryService
                                                .itemQualities.length,
                                            itemBuilder: (context, index) {
                                              return ShoppingListItem(
                                                index: index,
                                              );
                                            },
                                          ),
                                          10.height,
                                          TextButton.icon(
                                            style: TextButton.styleFrom(
                                              foregroundColor:
                                                  AppColors.primary,
                                            ),
                                            onPressed: () {
                                              categoryService.addMoreQualities(
                                                  fill: 1);
                                            },
                                            label: Text("Add more"),
                                            icon: Icon(Icons.add),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
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
                                if (images.isNotEmpty)
                                  SizedBox(
                                    height: 120,
                                    width: context.getWidth(.4),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: images.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.memory(
                                                images[index],
                                                height: 100,
                                                width: 100,
                                                fit: BoxFit.cover,
                                              ),
                                              // Text(selectedFiles[index])
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                20.height,
                                ElevatedButton(
                                  onPressed: () => _selectFile(),
                                  child: const Text('Select Images'),
                                ),
                                20.height,
                                CustomTextField(
                                  controller: _specController,
                                  labelText: 'Specifications',
                                  hintText: 'Enter Specifications',
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
                                    children: List.generate(
                                        categoryService.colors.length, (index) {
                                      final color =
                                          categoryService.colors[index];
                                      bool isSelected =
                                          selectedColors.contains(color.name);
                                      return GestureDetector(
                                        onTap: () => setState(() {
                                          if (!isSelected) {
                                            selectedColors.add(color.name);
                                          } else {
                                            selectedColors.remove(color.name);
                                          }
                                        }),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 12),
                                          decoration: BoxDecoration(
                                              color: isSelected
                                                  ? AppColors.primary
                                                  : AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: AppColors.secondary)),
                                          child: Text(
                                            color.name,
                                            style: AppStyles.urbanistGeneral(
                                              13,
                                              FontWeight.w700,
                                              color: isSelected
                                                  ? AppColors.white
                                                  : AppColors.primary,
                                            ),
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
                                    children: List.generate(
                                        categoryService.sizes.length, (index) {
                                      final size = categoryService.sizes[index];
                                      bool isSelected =
                                          selectedSizes.contains(size.name);
                                      return GestureDetector(
                                        onTap: () => setState(() {
                                          if (!isSelected) {
                                            selectedSizes.add(size.name);
                                          } else {
                                            selectedSizes.remove(size.name);
                                          }
                                        }),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 12),
                                          decoration: BoxDecoration(
                                              color: isSelected
                                                  ? AppColors.primary
                                                  : AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: AppColors.secondary)),
                                          child: Text(
                                            size.name,
                                            style: AppStyles.urbanistGeneral(
                                              13,
                                              FontWeight.w700,
                                              color: isSelected
                                                  ? AppColors.white
                                                  : AppColors.primary,
                                            ),
                                          ),
                                        ),
                                      );
                                    })),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    40.height,
                    PrimaryButton(
                      width: context.getWidth(.4),
                      onPressed: () => _editCategory(context, categoryService),
                      label: 'Save changes',
                    ),
                  ],
                ),
        ),
      );
    });
  }
}
