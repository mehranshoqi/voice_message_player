import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

/// get screen media.
final MediaQueryData media =
    MediaQueryData.fromWindow(WidgetsBinding.instance!.window);

/// this extention help us to make widget responsive.
extension NumberParsing on num {
  double w() => this * media.size.width / 100;

  double h() => this * media.size.height / 100;
}
