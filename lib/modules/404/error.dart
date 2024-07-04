import 'package:chapa_admin/generated/assets.gen.dart';
import 'package:chapa_admin/locator.dart';
import 'package:chapa_admin/navigation_service.dart';
import 'package:chapa_admin/routing/route_names.dart';
import 'package:chapa_admin/utils/__utils.dart';
import 'package:chapa_admin/widgets/call_to_action/call_to_action.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: context.getHeight(.8),
              width: context.getWidth(),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(Assets.icons.linear.eraser2),
                ),
              ),
            ),
            const Gap(Insets.lg),
            const Text(
              "Oops! Something went wrong.\n"
              "Looks like you tried to visit a page on our website that either doesn't exist or has been removed.",
              textAlign: TextAlign.center,
            ),
            const Gap(Insets.lg),
            CallToAction(
                title: 'Back To Home',
                action: () {
                  locator<NavigationService>().navigateTo(dashboard);
                })
          ],
        ),
      ),
    );
  }
}
