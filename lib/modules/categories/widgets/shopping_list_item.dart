import 'package:chapa_admin/generated/assets.gen.dart';
import 'package:chapa_admin/modules/categories/models/quality.dart';
import 'package:chapa_admin/modules/categories/service/category_service.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/widgets/image.dart';
import 'package:chapa_admin/widgets/input_fields/amount_text_field.dart';
import 'package:chapa_admin/widgets/input_fields/text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ShoppingListItem extends StatefulWidget {
  final int index;

  const ShoppingListItem({super.key, required this.index});

  @override
  State<ShoppingListItem> createState() => _ShoppingListItemState();
}

class _ShoppingListItemState extends State<ShoppingListItem> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryService>(builder: (context, notifier, __) {
      final item = notifier.itemQualities[widget.index];
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CustomTextField(
              hintText: item.name.isNotEmpty ? item.name.capitalize : "Quality",
              hintStyle: item.name.isNotEmpty ? AppStyles.urbanist14Md : null,
              validator: Validators.validateString(),
              onChanged: (value) {
                final receivedValue = value;
                if (receivedValue != null) {
                  notifier.updateItem(
                    widget.index,
                    ItemQuality(name: receivedValue, price: item.price),
                  );
                }
              },
            ),
          ),
          const Gap(10),
          Expanded(
            child: AmountTextField(
              prefixText: AppStrings.naira + "  ",
              hintText:
                  item.price != 0.0 ? item.price.toString() : "Enter Price",
              hintStyle: item.price != 0.0 ? AppStyles.urbanist14Md : null,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: false),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a price';
                }
                return null;
              },
              onChanged: (value) {
                final receivedValue = value;
                if (receivedValue != null) {
                  notifier.updateItem(
                    widget.index,
                    ItemQuality(
                      name: item.name,
                      price: receivedValue.isEmpty
                          ? 0.0
                          : double.parse(receivedValue),
                    ),
                  );
                }
              },
            ),
          ),
          const Gap(10),
          InkWell(
              onTap: () => notifier.removeItem(widget.index),
              child: LocalSvgIcon(
                Assets.icons.linear.trash,
                color: Colors.red,
              ))
        ],
      );
    });
  }
}
