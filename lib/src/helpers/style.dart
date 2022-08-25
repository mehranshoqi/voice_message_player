import 'package:flutter/material.dart';

import 'colors.dart';

/// document will be added
class S {
  /// document will be added
  static List<BoxShadow> innerBoxShadow() => [
        BoxShadow(color: Colors.black.withOpacity(.13)),
        BoxShadow(
          color: Colors.grey.shade200.withOpacity(1),
          spreadRadius: -16.0,
          offset: const Offset(0, 30),
          blurRadius: 40.0,
        ),
        BoxShadow(
          color: Colors.grey.shade200,
          spreadRadius: -16.0,
          offset: const Offset(-40, 0),
          blurRadius: 40.0,
        ),
        BoxShadow(
          color: Colors.grey.shade200,
          spreadRadius: -16.0,
          offset: const Offset(40, 0),
          blurRadius: 40.0,
        ),
      ];

  /// document will be added
  static double radius38(BuildContext context) =>
      S.min(38, MediaQuery.of(context).size.width * .08);

  /// document will be added
  static BoxShadow boxShadow(
    BuildContext context, {
    double opacity = .2,
    Color color = Colors.black87,
  }) =>
      BoxShadow(
        color: color.withOpacity(opacity),
        offset: const Offset(0, 18),
        blurRadius: 31,
        spreadRadius: 4.7,
      );

  /// document will be added
  static List<BoxShadow> pinkShadow({Color? shadow}) => [
        BoxShadow(
          color: shadow ?? AppColors.pink300,
          blurRadius: 56,
          spreadRadius: .4,
          offset: const Offset(0, 13),
        )
      ];

  /// document will be added
  static double min(double a, double b) => a > b ? b : a;

  /// document will be added
  static double w(Size? s) => s!.width;

  /// document will be added
  static double h(Size? s) => s!.height;
}
