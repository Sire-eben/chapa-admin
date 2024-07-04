import 'package:chapa_admin/modules/utilities/screens/colors.dart';
import 'package:chapa_admin/modules/utilities/screens/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class UtilitiesScreen extends StatefulWidget {
  const UtilitiesScreen({super.key});

  @override
  State<UtilitiesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<UtilitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: ColorsScreen()),
        30.width,
        const Expanded(child: SizesScreen())
      ],
    );
  }
}
