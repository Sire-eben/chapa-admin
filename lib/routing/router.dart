import 'package:chapa_admin/main.dart';
import 'package:chapa_admin/modules/404/error.dart';
import 'package:chapa_admin/modules/authentication/screens/login_screen.dart';
import 'package:chapa_admin/modules/categories/screens/add_category_screen.dart';
import 'package:chapa_admin/modules/categories/screens/categories.dart';
import 'package:chapa_admin/modules/dashboard/screens/dashboard.dart';
import 'package:chapa_admin/modules/printing_services/screens/printing_services.dart';
import 'package:chapa_admin/modules/users/screens/users.dart';
import 'package:chapa_admin/modules/utilities/screens/utilities.dart';
import 'package:flutter/material.dart';

import 'route_names.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case login:
      return _getPageRoute(const LoginScreen(), settings);
    case authWrapper:
      return _getPageRoute(const AuthWrapper(), settings);
    case dashboard:
      return _getPageRoute(const DashboardScreen(), settings);
    case categories:
      return _getPageRoute(const CategoriesScreen(), settings);
    case usersRoute:
      return _getPageRoute(const UsersScreen(), settings);
    case addCategories:
      return _getPageRoute(const AddCategoryScreen(), settings);
    case printingServices:
      return _getPageRoute(const PrintingServices(), settings);
    case colorssRoute:
      return _getPageRoute(const UtilitiesScreen(), settings);
    case sizesRoute:
      return _getPageRoute(const UtilitiesScreen(), settings);
    default:
      return _getPageRoute(const PageNotFound(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name!);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;

  _FadeRoute({required this.child, required this.routeName})
      : super(
            settings: RouteSettings(name: routeName),
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                child,
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) =>
                FadeTransition(
                  opacity: animation,
                  child: child,
                ));
}

typedef PageBuilder = Widget Function();

class PageRouter {
  static const double kDefaultDuration = .25;

  static Route<T> transitTo<T>(PageBuilder pageBuilder,
      [String? tag, double duration = kDefaultDuration]) {
    return MaterialPageRoute(
      builder: (context) => pageBuilder(),
      settings: RouteSettings(name: tag),
    );
  }
}
