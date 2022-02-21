import 'package:flutter/material.dart';

/// document will be added
class Widgets {
  /// document will be added
  static circle(
    BuildContext context,
    double width,
    Color color, {
    Widget child = const SizedBox(),
  }) =>
      Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: child,
        width: width,
        height: width,
      );
}
