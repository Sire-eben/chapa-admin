import 'package:chapa_admin/handlers/snackbar.dart';
import 'package:chapa_admin/locator.dart';
import 'package:chapa_admin/modules/categories/models/categories.dart';
import 'package:chapa_admin/modules/categories/service/category_service.dart';
import 'package:chapa_admin/navigation_service.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/widgets/input_fields/amount_text_field.dart';
import 'package:chapa_admin/widgets/input_fields/text_field.dart';
import 'package:chapa_admin/widgets/page_loader.dart';
import 'package:chapa_admin/widgets/primary_btn.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class EditCategory extends StatefulWidget {
  const EditCategory({super.key, required this.categoriesModel});
  final CategoriesModel categoriesModel;

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  final _formKey = GlobalKey<FormState>();
  final _categoryNameController = TextEditingController();
  final _categoryPriceController = TextEditingController();

  String selectedFile = '';

  Uint8List? image;

  void _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpeg'],
    );

    if (result != null) {
      setState(() {
        selectedFile = result.files.first.name;
        image = result.files.first.bytes;
      });
      setState(() {});
    }
  }

  Future<void> _editCategory(
      BuildContext context, CategoryService categoryService) async {
    if (_formKey.currentState!.validate() && image != null) {
      setState(() {});

      try {
        String imageUrl =
            await categoryService.uploadImage(image!, selectedFile);
        await categoryService.editCategory(
            catId: widget.categoriesModel.id,
            name: _categoryNameController.text,
            designPrice:
                _categoryPriceController.text.removeTheCommas.toString(),
            imageUrl: imageUrl);

        Future.delayed(Duration.zero, () {
          setState(() {
            _categoryNameController.clear();
            _categoryPriceController.clear();
            image = null;
            // selectedPrints.clear();
          });
          SnackbarHandler.showSuccessSnackbar(
              context: context, message: 'Changes saved!');
          locator<NavigationService>().goBack();
        });
      } catch (e) {
        setState(() {});
        Future.delayed(Duration.zero, () {
          SnackbarHandler.showErrorSnackbar(
              context: context, message: 'Failed to add category: $e');
        });
      }
    } else if (image == null) {
      SnackbarHandler.showErrorSnackbar(
          context: context, message: 'pick an image');
    } else {
      SnackbarHandler.showErrorSnackbar(
          context: context, message: 'Please enter a name and pick an image');
    }
  }

  bool _isAssigning = false;
  fetchDetails() async {
    setState(() {
      _isAssigning = true;
    });
    setState(() {
      _categoryNameController.text = widget.categoriesModel.name;
      _categoryPriceController.text = widget.categoriesModel.design_price;
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
      return Center(
        child: categoryService.isLoading || _isAssigning
            ? const PageLoader()
            : IntrinsicHeight(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .4,
                    // maxHeight: MediaQuery.of(context).size.width * .3,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: Shadows.universal,
                      borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.all(22.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        AmountTextField(
                          controller: _categoryPriceController,
                          labelText: 'Category Design Price',
                          hintText: 'Enter Design Price',
                          prefixText: "${AppStrings.naira}  ",
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: false),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a price';
                            }
                            return null;
                          },
                        ),
                        20.height,
                        if (image != null)
                          SizedBox(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.memory(
                                  image!,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                                Text(selectedFile)
                              ],
                            ),
                          ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => _selectFile(),
                          child: const Text('Select Icon'),
                        ),
                        20.height,
                        PrimaryButton(
                          onPressed: () =>
                              _editCategory(context, categoryService),
                          label: 'Save changes',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      );
    });
  }
}
