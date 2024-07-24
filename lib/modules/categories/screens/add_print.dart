import 'dart:typed_data';

import 'package:chapa_admin/handlers/snackbar.dart';
import 'package:chapa_admin/locator.dart';
import 'package:chapa_admin/modules/categories/models/categories.dart';
import 'package:chapa_admin/modules/categories/models/print_service.dart';
import 'package:chapa_admin/modules/categories/models/sub_categories.dart';
import 'package:chapa_admin/modules/categories/service/category_service.dart';
import 'package:chapa_admin/navigation_service.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/widgets/input_fields/amount_text_field.dart';
import 'package:chapa_admin/widgets/input_fields/text_field.dart';
import 'package:chapa_admin/widgets/page_loader.dart';
import 'package:chapa_admin/widgets/primary_btn.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class AddPrintService extends StatefulWidget {
  const AddPrintService(
      {super.key,
      required this.categoriesModel,
      required this.subCategoriesModel});
  final CategoriesModel categoriesModel;
  final SubCategoriesModel subCategoriesModel;

  @override
  State<AddPrintService> createState() => _AddPrintServiceState();
}

class _AddPrintServiceState extends State<AddPrintService> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

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
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextField(
                            controller: _nameController,
                            labelText: 'Name',
                            hintText: 'Enter Name',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a name';
                              }
                              return null;
                            },
                          ),
                          20.height,
                          AmountTextField(
                            controller: _priceController,
                            labelText: 'Price',
                            hintText: 'Enter Amount',
                            prefixText: "${AppStrings.naira}  ",
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: false),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an amount';
                              }
                              return null;
                            },
                          ),
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
                        ],
                      ),
                    ),
                    24.height,
                    PrimaryButton(
                      width: context.getWidth(.4),
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) return;
                        if (selectedFiles.isEmpty) {
                          SnackbarHandler.showErrorSnackbar(
                              context: context, message: "Select images");
                        } else {
                          List<String> imageUrls = [];
                          try {
                            for (int i = 0; i < images.length; i++) {
                              String imageUrl = await categoryService
                                  .uploadImage(images[i], selectedFiles[i]);
                              imageUrls.add(imageUrl);
                            }

                            PrintServiceModel printModel = PrintServiceModel(
                              name: _nameController.text.trim(),
                              price: _priceController.text.removeTheCommas,
                              images: imageUrls,
                            );
                            await categoryService
                                .addPrintServiceToItem(
                              catId: widget.categoriesModel.id,
                              subcatId: widget.subCategoriesModel.id,
                              printModel: printModel,
                            )
                                .whenComplete(() {
                              _nameController.clear();
                              _priceController.clear();
                              selectedFiles.clear();
                              images.clear();
                              locator<NavigationService>().goBack();
                            });
                          } catch (e) {
                            setState(() {});
                            Future.delayed(Duration.zero, () {
                              SnackbarHandler.showErrorSnackbar(
                                context: context,
                                message: e.toString(),
                              );
                            });
                          }
                        }
                      },
                      label: 'Add Print Service',
                    ),
                  ],
                ),
        ),
      );
    });
  }
}
