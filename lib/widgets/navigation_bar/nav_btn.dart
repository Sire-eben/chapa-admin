// import 'package:gap/gap.dart';
// import 'package:kunke_naturals/config/theme.dart';
// import 'package:kunke_naturals/core/providers/cart_provider.dart';
// import 'package:kunke_naturals/core/routing/route_names.dart';
// import 'package:kunke_naturals/core/services/navigation_service.dart';
// import 'package:kunke_naturals/core/widgets/images/local_svg_icon.dart';
// import 'package:kunke_naturals/generated/assets.gen.dart';
// import 'package:flutter/material.dart';
// import 'package:kunke_naturals/locator.dart';
// import 'package:provider/provider.dart';

// class NavButton extends StatelessWidget {
//   final CrossAxisAlignment? alignment;

//   const NavButton({
//     Key? key,
//     this.alignment,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         locator<NavigationService>().navigateTo(cartRoute);
//       },
//       child: Container(
//           // width: 100,
//           height: 40,
//           padding: EdgeInsets.symmetric(horizontal: Insets.lg),
//           alignment: Alignment.center,
//           child: Column(
//             crossAxisAlignment: alignment ?? CrossAxisAlignment.end,
//             children: [
//               InkWell(
//                 onTap: () => locator<NavigationService>().navigateTo(cartRoute),
//                 child: Row(
//                   children: [
//                     const Text(
//                       "Cart",
//                       style: TextStyle(
//                         color: AppColors.primaryColor,
//                         fontSize: FontSizes.sm,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const Gap(Insets.md),
//                     Stack(
//                       children: [
//                         LocalSvgIcon(
//                           Assets.icons.linear.shoppingCart,
//                         ),
//                         Positioned(
//                           left: -2,
//                           top: -3,
//                           child: Container(
//                             alignment: Alignment.center,
//                             padding: const EdgeInsets.all(2),
//                             decoration: const BoxDecoration(
//                               color: Colors.red,
//                               shape: BoxShape.circle,
//                             ),
//                             child: Consumer<CartProvider>(
//                               builder: (context, value, child) {
//                                 return Text(
//                                   value.getNumOfItems.toString(),
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               Gap(alignment == CrossAxisAlignment.center ? 10 : 3),
//               InkWell(
//                 onTap: () =>
//                     locator<NavigationService>().navigateTo(loginRoute),
//                 child: Row(
//                   children: [
//                     const Text(
//                       "Account",
//                       style: TextStyle(
//                         color: AppColors.primaryColor,
//                         fontSize: FontSizes.sm,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const Gap(Insets.md),
//                     LocalSvgIcon(
//                       Assets.icons.linear.user,
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
// }
