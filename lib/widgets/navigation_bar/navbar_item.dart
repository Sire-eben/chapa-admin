import 'package:chapa_admin/locator.dart';
import 'package:chapa_admin/navigation_service.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/utils/hover_extensions.dart';
import 'package:chapa_admin/widgets/image.dart';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

class NavBarItem extends StatelessWidget {
  final String label;
  final String navigationPath;
  final String icon;

  const NavBarItem({
    super.key,
    required this.label,
    required this.navigationPath,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
      child: InkWell(
        onTap: () {
          locator<NavigationService>().navigateTo(navigationPath);
        },
        child: Row(
          children: [
            LocalSvgIcon(icon),
            const Gap(Insets.sm),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ).showCursorOnHover,
    );
  }
}
