import 'package:chapa_admin/modules/categories/models/quality.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/widgets/input_fields/amount_text_field.dart';
import 'package:chapa_admin/widgets/input_fields/text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ShoppingListItemForView extends StatelessWidget {
  final ItemQualityModel item;

  const ShoppingListItemForView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: CustomTextField(
            enabled: false,
            labelText: "Quality",
            hintText: item.name.capitalize,
            hintStyle: item.name.isNotEmpty ? AppStyles.urbanist14Md : null,
            validator: Validators.validateString(),
          ),
        ),
        const Gap(10),
        Expanded(
          child: AmountTextField(
            enabled: false,
            labelText: "Amount",
            prefixText: "${AppStrings.naira}  ",
            hintText: "${AppStrings.naira}  ${item.price}",
            hintStyle: item.price != 0.0 ? AppStyles.urbanist14Md : null,
          ),
        ),
      ],
    );
  }
}
