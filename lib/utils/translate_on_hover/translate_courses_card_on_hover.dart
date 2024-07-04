import 'package:flutter/material.dart';

class TranslateProductsOnHover extends StatefulWidget {
  final Widget child;

  const TranslateProductsOnHover({
    super.key,
    required this.child,
  });

  @override
  State<TranslateProductsOnHover> createState() =>
      _TranslateProductsOnHoverState();
}

class _TranslateProductsOnHoverState extends State<TranslateProductsOnHover> {
  final nonHoverTransform = Matrix4.identity();
  final hoverTransform = Matrix4.identity()..translate(0, -4, 0);

  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) => _mouseEnter(true),
      onExit: (e) => _mouseEnter(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              blurRadius: _hovering ? 22 : 0,
              spreadRadius: _hovering ? 1 : 0,
              color: _hovering ? Colors.black26 : Colors.black12,
            )
          ],
        ),
        // color: _hovering ? AppColors.primaryLight : Colors.white,
        transform: _hovering ? hoverTransform : nonHoverTransform,
        child: widget.child,
      ),
    );
  }

  void _mouseEnter(bool hovering) {
    setState(() {
      _hovering = hovering;
    });
  }
}
