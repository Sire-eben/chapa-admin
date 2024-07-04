import 'package:chapa_admin/generated/assets.gen.dart';
import 'package:chapa_admin/routing/route_names.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import 'nav_drawer_item.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(),
      margin: EdgeInsets.all(Insets.sm),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DrawerItem(
            title: "Home",
            icon: Assets.icons.twotone.home1,
            navigationPath: dashboard,
          ),
          DrawerItem(
            title: "Shop",
            icon: Assets.icons.twotone.user,
            navigationPath: categories,
          ),
          DrawerItem(
            title: "About",
            icon: Assets.icons.twotone.statusUp,
            navigationPath: categories,
          ),
          DrawerItem(
            title: "Contact",
            icon: Assets.icons.twotone.judge,
            navigationPath: categories,
          ),

          const Gap(Insets.md),
          // const SocialLinks(
          //   alignment: MainAxisAlignment.spaceEvenly,
          // ),
        ],
      ),
    );
  }
}
