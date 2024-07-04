import 'package:chapa_admin/routing/route_names.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';

import 'navbar_item.dart';
import 'navbar_logo.dart';

class NavBarTabletDesktop extends StatelessWidget {
  const NavBarTabletDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NavbarLogo(),
          // const Expanded(
          //   child: SizedBox(),
          // ),
          NavBarItem(
            label: 'Home',
            navigationPath: dashboard,
            icon: '',
          ),
          NavBarItem(
            label: 'Categories',
            navigationPath: categories,
            icon: '',
          ),
          NavBarItem(
            label: 'Categories',
            navigationPath: categories,
            icon: '',
          ),
          // const NavBarItem(
          //   label: 'Contact',
          //   navigationPath: contactRoute,
          //   icon: '',
          // ),
          // const NavButton(),
          // Gap(context.getHeight(.1)),
        ],
      ),
    );
  }
}
