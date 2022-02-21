import 'package:flutter/material.dart';

/// @nodoc
class Widgets {
  /// @nodoc
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
