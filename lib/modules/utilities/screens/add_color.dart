import 'package:chapa_admin/handlers/snackbar.dart';
import 'package:chapa_admin/modules/utilities/service/utils_service.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/widgets/input_fields/text_field.dart';
import 'package:chapa_admin/widgets/page_loader.dart';
import 'package:chapa_admin/widgets/primary_btn.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class AddColorDialog extends StatefulWidget {
  const AddColorDialog({super.key});

  @override
  State<AddColorDialog> createState() => _AddColorDialogState();
}

class _AddColorDialogState extends State<AddColorDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<UtilitiesService>(builder: (context, utilitiesService, __) {
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
                          labelText: 'Color Name',
                          hintText: 'Enter  Name',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name';
                            }
                            return null;
                          },
                        ),
                        20.height,
                        PrimaryButton(
                          onPressed: () async {
                            if (!_formKey.currentState!.validate()) return;
                            await utilitiesService
                                .addColor(name: _nameController.text.trim())
                                .then((res) {
                              if (res) {
                                _nameController.clear();
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
                          },
                          label: 'Add Color',
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
