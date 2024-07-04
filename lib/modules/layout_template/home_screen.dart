import 'package:chapa_admin/generated/assets.gen.dart';
import 'package:chapa_admin/handlers/snackbar.dart';
import 'package:chapa_admin/locator.dart';
import 'package:chapa_admin/navigation_service.dart';
import 'package:chapa_admin/routing/route_names.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/widgets/image.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:chapa_admin/modules/authentication/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.child});
  final Widget child;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  List items = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(builder: (context, authService, __) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Admin Dashboard',
            style: AppStyles.urbanist20Md.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                authService.changeLogoutStatus(true);
              },
            ),
          ],
        ),
        body: Row(
          children: [
            if (_auth.currentUser != null)
              SideMenu(
                // Page controller to manage a PageView
                controller: sideMenu,
                // Will shows on top of all items, it can be a logo or a Title text
                title: Image.asset(
                  Assets.logo.path,
                  height: 76,
                ),
                // Will show on bottom of SideMenu when displayMode was SideMenuDisplayMode.open
                footer: const Text('Chapa Now Admin dashboard'),
                // Notify when display mode changed
                onDisplayModeChanged: (mode) {
                  // print(mode);
                },
                style: SideMenuStyle(
                  selectedColor: AppColors.primary,
                  selectedIconColor: Colors.white,
                  showTooltip: true,
                  unselectedIconColor: AppColors.primary,
                  arrowOpen: AppColors.primary,
                  // showHamburger: true,
                  selectedTitleTextStyleExpandable:
                      AppStyles.urbanist16SmBd.copyWith(color: Colors.black),
                  selectedTitleTextStyle: AppStyles.urbanist16SmBd.copyWith(
                    color: Colors.white,
                  ),
                  unselectedTitleTextStyle: AppStyles.urbanist16SmBd.copyWith(),
                  selectedHoverColor: AppColors.primary,
                ),
                items: [
                  SideMenuItem(
                    title: 'Dashboard',
                    iconWidget: LocalSvgIcon(
                      Assets.icons.bulk.grid2,
                      color: AppColors.primary,
                      size: 22,
                    ),
                    onTap: (index, _) {
                      sideMenu.changePage(index);

                      locator<NavigationService>().navigateTo(dashboard);
                    },
                    // icon: const Icon(Icons.home),
                  ),
                  SideMenuItem(
                    title: 'All Categories',
                    iconWidget: LocalSvgIcon(
                      Assets.icons.bulk.category2,
                      color: AppColors.primary,
                      size: 22,
                    ),
                    onTap: (index, _) {
                      sideMenu.changePage(index);

                      locator<NavigationService>().navigateTo(categories);
                    },
                    // icon: const Icon(Icons.category_outlined),
                  ),
                  SideMenuItem(
                    title: 'Users',
                    iconWidget: LocalSvgIcon(
                      Assets.icons.bulk.people,
                      color: AppColors.primary,
                      size: 22,
                    ),
                    onTap: (index, _) {
                      sideMenu.changePage(index);
                      locator<NavigationService>().navigateTo(usersRoute);
                    },
                  ),
                  SideMenuItem(
                    title: 'Printing Services',
                    iconWidget: LocalSvgIcon(
                      Assets.icons.bulk.printer,
                      color: AppColors.primary,
                      size: 22,
                    ),
                    onTap: (index, _) {
                      sideMenu.changePage(index);
                      locator<NavigationService>().navigateTo(printingServices);
                    },
                  ),

                  SideMenuItem(
                    title: 'Colors & Sizes',
                    onTap: (index, _) {
                      sideMenu.changePage(index);
                      locator<NavigationService>().navigateTo(colorssRoute);
                    },
                    iconWidget: LocalSvgIcon(
                      Assets.icons.bulk.colorfilter,
                      color: AppColors.primary,
                      size: 22,
                    ),
                  ),
                  // SideMenuExpansionItem(
                  //     title: "Other Utils",
                  //     iconWidget: LocalSvgIcon(
                  //       Assets.icons.bulk.check,
                  //       color: AppColors.primary,
                  //       size: 22,
                  //     ),
                  //     children: [
                  //       SideMenuItem(
                  //         title: 'Colors & Sizes',
                  //         onTap: (index, _) {
                  //           sideMenu.changePage(index);
                  //           locator<NavigationService>()
                  //               .navigateTo(colorssRoute);
                  //         },
                  //         iconWidget: LocalSvgIcon(
                  //           Assets.icons.bulk.colorfilter,
                  //           color: AppColors.primary,
                  //           size: 22,
                  //         ),
                  //       ),
                  //       SideMenuItem(
                  //         title: 'Sizes',
                  //         onTap: (index, _) {
                  //           sideMenu.changePage(index);
                  //           locator<NavigationService>().navigateTo(sizesRoute);
                  //         },
                  //         iconWidget: LocalSvgIcon(
                  //           Assets.icons.bulk.size,
                  //           color: AppColors.primary,
                  //           size: 22,
                  //         ),
                  //       ),
                  //     ]),

                  SideMenuItem(
                    title: 'Log out',
                    onTap: (x, sideMenu) async {
                      sideMenu.changePage(x);

                      authService.changeLogoutStatus(true);
                    },
                    iconWidget: LocalSvgIcon(
                      Assets.icons.bulk.logout,
                      color: AppColors.primary,
                      size: 22,
                    ),
                  ),
                ],
              ),
            30.width,
            Expanded(
              child: authService.logOut ? LogoutWidget() : widget.child,
            ),
          ],
        ),
      );
    });
  }
}

class LogoutWidget extends StatefulWidget {
  const LogoutWidget({
    super.key,
  });

  @override
  State<LogoutWidget> createState() => _LogoutWidgetState();
}

class _LogoutWidgetState extends State<LogoutWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(builder: (context, authService, __) {
      return IntrinsicHeight(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 26),
          constraints: BoxConstraints(
            maxWidth: context.getWidth(.4),
          ),
          child: Column(
            children: [
              30.height,
              Text(
                "Log Out?",
                style: AppStyles.urbanist24Xbd,
              ),
              20.height,
              Text(
                "You are about to log out of your account. Are you sure?",
                style: AppStyles.urbanist16Md,
              ),
              20.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.red,
                        surfaceTintColor: AppColors.red,
                      ),
                      onPressed: () {
                        authService.changeLogoutStatus(false);
                      },
                      icon: LocalSvgIcon(
                        Assets.icons.linear.closeCircle,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Cancel",
                        style: AppStyles.urbanist14Smbd.copyWith(
                          color: Colors.white,
                        ),
                      )),
                  20.width,
                  TextButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        surfaceTintColor: AppColors.primary,
                      ),
                      onPressed: () async {
                        await authService.signOut().then((res) {
                          if (res) {
                            SnackbarHandler.showSuccessSnackbar(
                                context: context, message: authService.message);
                            locator<NavigationService>().replace(login);
                          } else {
                            SnackbarHandler.showHuzzDialog(
                                context: context, message: authService.message);
                            return;
                          }
                        });
                      },
                      icon: LocalSvgIcon(
                        Assets.icons.linear.check,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Continue",
                        style: AppStyles.urbanist14Smbd.copyWith(
                          color: Colors.white,
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
