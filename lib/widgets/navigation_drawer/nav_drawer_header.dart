import 'package:chapa_admin/utils/__utils.dart';
import 'package:flutter/material.dart';

class NavDrawerHeader extends StatelessWidget {
  const NavDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      alignment: Alignment.center,
      color: AppColors.primary,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "SKILL UP NOW",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            "Tap here",
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
