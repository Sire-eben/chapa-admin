import 'package:chapa_admin/generated/assets.gen.dart';
import 'package:chapa_admin/handlers/snackbar.dart';
import 'package:chapa_admin/modules/categories/service/category_service.dart';
import 'package:chapa_admin/modules/categories/widgets/percentage_items.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/widgets/image.dart';
import 'package:chapa_admin/widgets/input_fields/amount_text_field.dart';
import 'package:chapa_admin/widgets/input_fields/text_field.dart';
import 'package:chapa_admin/widgets/page_loader.dart';
import 'package:chapa_admin/widgets/primary_btn.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
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

  Future<void> _addCategory(
      BuildContext context, CategoryService categoryService) async {
    if (_formKey.currentState!.validate() && image != null) {
      setState(() {});

      try {
        String imageUrl =
            await categoryService.uploadImage(image!, selectedFile);
        await categoryService.addCategory(
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
              context: context, message: 'Category added successfully!');
          // Navigator.pop(context);
        });
      } catch (e) {
        setState(() {});
        Future.delayed(Duration.zero, () {
          SnackbarHandler.showErrorSnackbar(
              context: context, message: 'Failed to add category: $e');
        });
      }
    } else {
      SnackbarHandler.showErrorSnackbar(
          context: context, message: 'Please enter a name and pick an image');
    }
  }

  // List<String> selectedPrints = [];

  // final service = locator<CategoryService>();
  // fetchDetails() async => await service.getPrintingServices();

  // @override
  // void initState() {
  //   super.initState();
  //   Future.microtask(() => fetchDetails());
  // }

  @override
  Widget build(BuildContext context) {
    // final categoryService = Provider.of<CategoryService>(context);

    return Consumer<CategoryService>(builder: (context, categoryService, __) {
      return Center(
        child: categoryService.isLoading
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
                        20.height,
                        if (image == null)
                          SizedBox(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                LocalSvgIcon(
                                  Assets.icons.bulk.image,
                                  size: 80,
                                  color: AppColors.primary,
                                ),
                                Text(selectedFile)
                              ],
                            ),
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
                        12.height,
                        const Text("Set percentage offers"),
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
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              // physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  categoryService.percentageIncrease.length,
                              itemBuilder: (context, index) {
                                return PercentageItems(
                                  index: index,
                                );
                              },
                            ),
                          ),
                        ),
                        20.height,
                        PrimaryButton(
                          onPressed: () =>
                              _addCategory(context, categoryService),
                          label: 'Add Category',
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
