import 'package:chapa_admin/handlers/snackbar.dart';
import 'package:chapa_admin/locator.dart';
import 'package:chapa_admin/modules/printing_services/models/prints.dart';
import 'package:chapa_admin/modules/printing_services/service/print_service.dart';
import 'package:chapa_admin/navigation_service.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/widgets/input_fields/amount_text_field.dart';
import 'package:chapa_admin/widgets/input_fields/text_field.dart';
import 'package:chapa_admin/widgets/page_loader.dart';
import 'package:chapa_admin/widgets/primary_btn.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class AddPrintingServiceDialog extends StatefulWidget {
  const AddPrintingServiceDialog({
    super.key,
    this.isEditing = false,
    this.printingServicesModel,
  });
  final bool isEditing;
  final PrintingServicesModel? printingServicesModel;

  @override
  State<AddPrintingServiceDialog> createState() => _AddColorDialogState();
}

class _AddColorDialogState extends State<AddPrintingServiceDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _unitController = TextEditingController();

  PrintingServicesModel? get model => widget.printingServicesModel;

  initializeData() {
    if (widget.isEditing) {
      setState(() {
        _nameController.text = model?.name ?? "";
        _priceController.text = model?.price ?? "";
        _unitController.text = model?.unit ?? "";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => initializeData());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PrintingService>(builder: (context, utilitiesService, __) {
      return Center(
        child: utilitiesService.isLoading
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
                          controller: _nameController,
                          labelText: 'Service Name',
                          hintText: 'Enter  Name',
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
                          labelText: 'Printing Service Price',
                          hintText: 'Enter Service Price',
                          prefixText: AppStrings.naira + "  ",
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
                        CustomTextField(
                          controller: _unitController,
                          labelText: 'Unit (E.g; Yard, Meter, etc)',
                          hintText: 'Enter  unit',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a unit';
                            }
                            return null;
                          },
                        ),
                        20.height,
                        PrimaryButton(
                          onPressed: () async {
                            if (!_formKey.currentState!.validate()) return;
                            if (!widget.isEditing) {
                              await utilitiesService
                                  .addPrintService(
                                      name: _nameController.text.trim(),
                                      price: _priceController
                                          .text.removeTheCommas
                                          .toString(),
                                      unit: _unitController.text)
                                  .then((res) {
                                if (res) {
                                  _nameController.clear();
                                  _priceController.clear();
                                  _unitController.clear();
                                  SnackbarHandler.showSuccessSnackbar(
                                      context: context,
                                      message: utilitiesService.message);
                                } else {
                                  SnackbarHandler.showHuzzDialog(
                                      context: context,
                                      message: utilitiesService.message);
                                  return;
                                }
                              });
                            } else {
                              await utilitiesService
                                  .editPrintService(
                                      id: widget.printingServicesModel?.id ??
                                          "",
                                      name: _nameController.text.trim(),
                                      price: _priceController
                                          .text.removeTheCommas
                                          .toString(),
                                      unit: _unitController.text)
                                  .then((res) {
                                if (res) {
                                  _nameController.clear();
                                  _priceController.clear();
                                  _unitController.clear();
                                  SnackbarHandler.showSuccessSnackbar(
                                      context: context,
                                      message: utilitiesService.message);
                                  locator<NavigationService>().goBack();
                                } else {
                                  SnackbarHandler.showHuzzDialog(
                                      context: context,
                                      message: utilitiesService.message);
                                  return;
                                }
                              });
                            }
                          },
                          label: widget.isEditing ? 'Save' : 'Add Service',
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
