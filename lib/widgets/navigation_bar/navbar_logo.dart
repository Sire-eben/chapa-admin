import 'package:chapa_admin/generated/assets.gen.dart';
import 'package:chapa_admin/locator.dart';
import 'package:chapa_admin/navigation_service.dart';
import 'package:chapa_admin/routing/route_names.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/utils/hover_extensions.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NavbarLogo extends StatelessWidget {
  const NavbarLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: InkWell(
        onTap: () {
          locator<NavigationService>().navigateTo(dashboard);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  height: 32,
                  image: AssetImage(
                    Assets.images.chapa.path,
                  )),
              const Gap(Insets.md),
              Text(
                'Chapa',
                style: GoogleFonts.greatVibes(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
      desktop: InkWell(
        onTap: () {
          locator<NavigationService>().navigateTo(dashboard);
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
                height: 32,
                image: AssetImage(
                  Assets.images.chapa.path,
                )),
            Text(
              'Chapa',
              style: GoogleFonts.greatVibes(fontWeight: FontWeight.bold),
            )
          ],
        ).showCursorOnHover,
      ),
    );
  }
}
