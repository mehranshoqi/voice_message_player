import 'package:flutter/material.dart';

class Widgets {
  static circle(
    BuildContext context,
    double width,
    Color color, {
    Widget child = const SizedBox(),
  }) =>
      Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2000), color: color),
        child: child,
        width: width,
        height: width,
      );
}
