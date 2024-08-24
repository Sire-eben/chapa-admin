import 'package:chapa_admin/modules/categories/models/percentage_inc.dart';
import 'package:chapa_admin/modules/categories/service/category_service.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/widgets/input_fields/amount_text_field.dart';
import 'package:chapa_admin/widgets/input_fields/text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class PercentageItems extends StatefulWidget {
  final int index;

  const PercentageItems({super.key, required this.index});

  @override
  State<PercentageItems> createState() => _ShoppingListItemState();
}

class _ShoppingListItemState extends State<PercentageItems> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryService>(builder: (context, notifier, __) {
      final item = notifier.percentageIncrease[widget.index];
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CustomTextField(
              enabled: false,
              hintText: item.name.isNotEmpty ? item.name.capitalize : "Range",
              hintStyle: item.name.isNotEmpty ? AppStyles.urbanist14Md : null,
            ),
          ),
          const Gap(10),
          Expanded(
            child: AmountTextField(
              prefixText: "%  ",
              hintText:
                  item.price != 0.0 ? item.price.toString() : "Percentage",
              hintStyle: item.price != 0.0 ? AppStyles.urbanist14Md : null,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a Percentage';
                }
                return null;
              },
              onChanged: (value) {
                final receivedValue = value;
                if (receivedValue != null) {
                  // print(receivedValue.removeCommas);
                  notifier.updatePercentageIncrease(
                    widget.index,
                    PercentageIncrease(
                      name: item.name,
                      price: receivedValue.isEmpty
                          ? 0.0
                          : double.parse(receivedValue.removeCommas),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      );
    });
  }
}
