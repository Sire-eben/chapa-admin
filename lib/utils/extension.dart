import 'package:chapa_admin/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '__utils.dart';
import 'routes/__routes.dart';

extension ContextExtension on BuildContext {
  double getHeight([double factor = 1]) {
    assert(factor != 0);
    return MediaQuery.of(this).size.height * factor;
  }

  double getWidth([double factor = 1]) {
    assert(factor != 0);
    return MediaQuery.of(this).size.width * factor;
  }

  double get height => getHeight();
  double get width => getWidth();

  TextTheme get textTheme => Theme.of(this).textTheme;

  Future<T?> push<T>(Widget page) => Navigator.push<T>(
        this,
        PageRouter.transitTo(
          () => page,
          "/${page.runtimeType.toString()}",
        ),
      );

  Future<T?> replace<T>(Widget page) => Navigator.pushReplacement(
        this,
        PageRouter.transitTo(
          () => page,
          "/${page.runtimeType.toString()}",
        ),
      );

  Future<T?> pushOff<T>(Widget page) => Navigator.pushAndRemoveUntil<T>(
        this,
        PageRouter.transitTo(
          () => page,
          "/${page.runtimeType.toString()}",
        ),
        (_) => false,
      );

  void popOff([String? routeTag]) =>
      Navigator.popUntil(this, ModalRoute.withName(routeTag ?? '/AppScaffold'));

  Future<bool> pop<T>([T? result]) => Navigator.maybePop(this, result);
}

extension WidgetExtension on Widget {
  Widget onTap(VoidCallback action, {bool opaque = true}) {
    return GestureDetector(
      behavior: opaque ? HitTestBehavior.opaque : HitTestBehavior.deferToChild,
      onTap: action,
      child: this,
    );
  }

  Widget onPop(BuildContext context, {bool opaque = true}) {
    return GestureDetector(
      behavior: opaque ? HitTestBehavior.opaque : HitTestBehavior.deferToChild,
      onTap: () => context.pop(),
      child: this,
    );
  }
}

extension StringExtension on double {
  String moneyFormat() {
    final f = NumberFormat.currency(symbol: "₦");
    return f.format(this);
  }
}

extension StringExtensions on String {
  String get png => "assets/images/$this.png";
  String get svg => "assets/images/$this.svg";
  String get jpg => "assets/images/$this.jpg";
  String get jpeg => "assets/images/$this.jpeg";
  String get capitalize =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : this;
  String get allInCaps => toUpperCase();
  String get alphabet => "abcdefghijklmnopqrstuvwxyz";
  String get pascalCase => replaceAll(
          RegExp("(?=[${alphabet.toUpperCase()}])", multiLine: true), " ")
      .titleCase;
  String get titleCase => split(' ').map((str) => str.capitalize).join(' ');
  String get useFirstValue => split(" ").first;
  String get removeCommas => replaceAll(",", "");
  int get removeTheCommas => int.parse(replaceAll(",", "")).toInt();
  String get removeCurrencyPrefix => replaceAll(AppStrings.currency, "");

  String get hideMidCharacters {
    if (length <= 6) return this;
    final splitAcc = split("");

    final prefix = splitAcc.take(3).join("");
    final suffix = splitAcc.reversed.take(3).toList().reversed.join("");

    int asterisksCount = splitAcc.length - (prefix.length + suffix.length);
    return "$prefix${"*" * asterisksCount}$suffix";
  }
}

extension DateTimeExtension on DateTime {
  String formatDate() {
    final f = DateFormat.yMMMd();
    return f.format(this);
  }
}

extension IntExtension on int {
  Duration get seconds => Duration(seconds: this);
  Duration get minutes => Duration(minutes: this);
  Duration get milliseconds => Duration(
      microseconds: (this * Duration.microsecondsPerMillisecond).toInt());
  int get inKobo => this * 100;
  int get inNaira => this ~/ 100;
}
