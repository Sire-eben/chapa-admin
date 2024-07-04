import 'package:chapa_admin/modules/layout_template/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LayoutTemplate extends StatefulWidget {
  final Widget child;

  const LayoutTemplate({super.key, required this.child});

  @override
  State<LayoutTemplate> createState() => _LayoutTemplateState();
}

class _LayoutTemplateState extends State<LayoutTemplate> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizing) {
      return Scaffold(
          backgroundColor: Colors.white,
          key: scaffoldKey,
          body: Center(child: HomeScreen(child: widget.child)));
      // body: CenteredView(child: widget.child));
    });
  }
}
