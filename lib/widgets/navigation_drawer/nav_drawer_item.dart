import 'package:chapa_admin/locator.dart';
import 'package:chapa_admin/navigation_service.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/utils/hover_extensions.dart';
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final String icon;
  final String navigationPath;
  const DrawerItem({
    super.key,
    required this.title,
    required this.icon,
    required this.navigationPath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Insets.md),
      child: InkWell(
        onTap: () {
          locator<NavigationService>().navigateTo(navigationPath);
        },
        child: Text(
          title,
          style: TextStyle(
            color: AppColors.black,
            fontSize: FontSizes.md,
            fontWeight: FontWeight.w600,
          ),
        ),
      ).showCursorOnHover.moveUpOnHover,
    );
  }
}
