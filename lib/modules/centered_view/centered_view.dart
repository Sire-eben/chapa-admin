import 'package:chapa_admin/generated/assets.gen.dart';
import 'package:chapa_admin/modules/authentication/screens/login_screen.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/widgets/image.dart';
import 'package:chapa_admin/widgets/navigation_bar/navbar_logo.dart';
import 'package:chapa_admin/widgets/navigation_bar/navbar_tablet_desktop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CenteredView extends StatefulWidget {
  final Widget child;

  const CenteredView({super.key, required this.child});

  @override
  State<CenteredView> createState() => _CenteredViewState();
}

class _CenteredViewState extends State<CenteredView> {
  bool showDrawer = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizing) {
      return Center(
        child: Container(
          width: context.getWidth(),
          alignment: Alignment.bottomCenter,
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Row(
            children: [
              if (_auth.currentUser == null)
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(Assets.images.chapa.path),
                    )),
                  ),
                )
              else
                Expanded(
                  child: ScreenTypeLayout(
                    mobile: Container(
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
                                showDrawer = !showDrawer;
                              });
                            },
                            icon: LocalSvgIcon(
                              showDrawer == true
                                  ? Assets.icons.linear.closeSquare
                                  : Assets.icons.bulk.menu,
                              color: showDrawer == true
                                  ? AppColors.error
                                  : AppColors.primary,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                    desktop: NavBarTabletDesktop(),
                  ),
                ),
              Expanded(
                  child:
                      _auth.currentUser == null ? LoginScreen() : widget.child),
            ],
          ),
        ),
      );
    });
  }
}
