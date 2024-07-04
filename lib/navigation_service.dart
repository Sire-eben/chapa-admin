import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> chapaNavigatorKey =
      GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return chapaNavigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> replace(String routeName) {
    return chapaNavigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  void goBack() {
    return chapaNavigatorKey.currentState!.pop();
  }
}
