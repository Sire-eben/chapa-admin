import 'package:chapa_admin/generated/assets.gen.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/widgets/image.dart';
import 'package:flutter/material.dart';

import 'navbar_logo.dart';

class NavBarMobile extends StatefulWidget {
  const NavBarMobile({
    super.key,
  });

  @override
  State<NavBarMobile> createState() => _NavBarMobileState();
}

class _NavBarMobileState extends State<NavBarMobile> {
  bool showDrawer = false;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context2) {
      return Container(
        height: 60,
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const NavbarLogo(),
            IconButton(
              padding: const EdgeInsets.all(2),
              onPressed: () {
                setState(() {
                  showDrawer = true;
                });
              },
              icon: LocalSvgIcon(
                showDrawer == true
                    ? Assets.icons.linear.closeSquare
                    : Assets.icons.bulk.menu,
                color: showDrawer == true ? AppColors.error : AppColors.primary,
                size: 40,
              ),
            ),
          ],
        ),
      );
    });
  }
}
