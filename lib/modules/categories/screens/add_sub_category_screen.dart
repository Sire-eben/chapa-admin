import 'package:chapa_admin/handlers/snackbar.dart';
import 'package:chapa_admin/locator.dart';
import 'package:chapa_admin/modules/categories/models/categories.dart';
import 'package:chapa_admin/modules/categories/service/category_service.dart';
import 'package:chapa_admin/navigation_service.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/utils/app_themes.dart';
import 'package:chapa_admin/widgets/input_fields/amount_text_field.dart';
import 'package:chapa_admin/widgets/input_fields/text_field.dart';
import 'package:chapa_admin/widgets/page_loader.dart';
import 'package:chapa_admin/widgets/primary_btn.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class AddSubCategoryScreen extends StatefulWidget {
  const AddSubCategoryScreen({super.key, required this.categoriesModel});
  final CategoriesModel categoriesModel;

  @override
  _AddSubCategoryScreenState createState() => _AddSubCategoryScreenState();
}

class _AddSubCategoryScreenState extends State<AddSubCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _categoryNameController = TextEditingController();
  final _lowPriceController = TextEditingController();
  final _highPriceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _specController = TextEditingController();
  bool _isLoading = false;
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

  Future<void> _addCategory(
      BuildContext context, CategoryService categoryService) async {
    if (_formKey.currentState!.validate() && images.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      try {
        List<String> imageUrls = [];
        for (int i = 0; i < images.length; i++) {
          String imageUrl =
              await categoryService.uploadImage(images[i], selectedFiles[i]);
          imageUrls.add(imageUrl);
        }

        await categoryService.addSubcategory(
          name: _categoryNameController.text,
          description: _descriptionController.text,
          specifications: _specController.text,
          catId: widget.categoriesModel.id,
          colors: selectedColors,
          sizes: selectedSizes,
          designPrice: widget.categoriesModel.design_price,
          lowPrice: _lowPriceController.text.removeTheCommas.toString(),
          highPrice: _highPriceController.text.removeTheCommas.toString(),
          images: imageUrls,
        );

        setState(() => _isLoading = false);
        Future.delayed(Duration.zero, () {
          SnackbarHandler.showSuccessSnackbar(
              context: context, message: 'Subcategory added successfully!');
          locator<NavigationService>().goBack();
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        Future.delayed(Duration.zero, () {
          SnackbarHandler.showErrorSnackbar(
              context: context, message: 'Failed to add subcategory: $e');
        });
      }
    } else {
      SnackbarHandler.showErrorSnackbar(
          context: context,
          message: 'Please enter a name and pick at least one image');
    }
  }

  List<String> selectedColors = [];
  List<String> selectedSizes = [];

  fetchDetails() async {
    await service.getColors();
    await service.getSizes();
  }

  @override
  void initState() {
    // TODO: implement initState
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
          child: categoryService.isLoading
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
                                AmountTextField(
                                  controller: _lowPriceController,
                                  labelText: 'Low quality price',
                                  hintText: 'Enter Price',
                                  prefixText: AppStrings.naira,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: false),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a price';
                                    }
                                    return null;
                                  },
                                ),
                                20.height,
                                AmountTextField(
                                  controller: _highPriceController,
                                  labelText: 'High quality price',
                                  hintText: 'Enter Price',
                                  prefixText: AppStrings.naira,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: false),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a price';
                                    }
                                    return null;
                                  },
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
                    PrimaryButton(
                      width: context.getWidth(.4),
                      onPressed: () => _addCategory(context, categoryService),
                      label: 'Add sub category',
                    ),
                  ],
                ),
        ),
      );
    });
  }
}
