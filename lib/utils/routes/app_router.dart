// import 'package:flutter/cupertino.dart';

// typedef PageBuilder = Widget Function();

// class PageRouter {
//   static const double kDefaultDuration = .8;

//   static PageRouteBuilder<T> transitTo<T>(
//       PageBuilder pageBuilder, [
//         String? tag,
//         double duration = kDefaultDuration,
//       ]) {
//     return PageRouteBuilder<T>(
//       pageBuilder: (context, animation, secondaryAnimation) => pageBuilder(),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         const begin = Offset(1.0, 0.0); // Adjust the values as needed
//         const end = Offset.zero;
//         const curve = Curves.easeInOut;
//         var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//         var offsetAnimation = animation.drive(tween);

//         return SlideTransition(
//           position: offsetAnimation,
//           child: child,
//         );
//       },
//       transitionDuration: Duration(seconds: duration.toInt()),
//       settings: RouteSettings(name: tag),
//     );
//   }
// }
