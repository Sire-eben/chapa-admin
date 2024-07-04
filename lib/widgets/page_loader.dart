import 'package:chapa_admin/utils/__utils.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PageLoader extends StatelessWidget {
  final String? message;
  const PageLoader({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingAnimationWidget.discreteCircle(
            size: 35,
            color: Theme.of(context).primaryColor,
          ),
          if (message != null) ...[
            Gap(12),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: AppStyles.urbanist14Md,
            )
          ]
        ],
      ),
    );
  }
}

class PageLoaderWithPadding extends StatelessWidget {
  final String? message;
  const PageLoaderWithPadding({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingAnimationWidget.discreteCircle(
              size: 35,
              color: Theme.of(context).primaryColor,
            ),
            if (message != null) ...[
              Gap(12),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: AppStyles.urbanist14Md,
              )
            ]
          ],
        ),
      ),
    );
  }
}

class PageLoaderWithScaffold extends StatelessWidget {
  final String? message;
  const PageLoaderWithScaffold({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingAnimationWidget.discreteCircle(
              size: 35,
              color: Theme.of(context).primaryColor,
            ),
            if (message != null) ...[
              Gap(12),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: AppStyles.urbanist14Md,
              )
            ]
          ],
        ),
      ),
    );
  }
}
