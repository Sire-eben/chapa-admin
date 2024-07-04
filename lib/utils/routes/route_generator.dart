// import 'package:chapa_admin/modules/home_screen.dart';
// import 'package:chapa_admin/utils/routes/routes.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class RouteGenerator {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     // final args = settings.arguments;

//     switch (settings.name) {
//       case Routes.homPage:
//         return _getPageRoute(const HomeScreen(), settings);

//       default:
//         return _getPageRoute(_errorPage());
//     }
//   }

//   ///Wraps widget with a CupertinoPageRoute and adds route settings
//   static CupertinoPageRoute _getPageRoute(
//     Widget child, [
//     RouteSettings settings = const RouteSettings(),
//     bool? isfullScreenDialog = false,
//   ]) {
//     return CupertinoPageRoute(
//       builder: (context) => child,
//       fullscreenDialog: isfullScreenDialog ?? false,
//       settings: RouteSettings(
//         name: settings.name,
//         arguments: settings.arguments,
//       ),
//     );
//   }

//   ///Error page shown when app attempts navigating to an unknown route
//   static Widget _errorPage({String message = "Error! Page not found"}) =>
//       kDebugMode
//           ? Scaffold(
//               appBar: AppBar(
//                   title: const Text(
//                 'Page not found',
//                 style: TextStyle(color: Colors.red),
//               )),
//               body: Center(
//                 child: Text(
//                   message,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               ),
//             )
//           : const SizedBox();
// }
