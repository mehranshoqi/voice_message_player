import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

final MediaQueryData media =
    MediaQueryData.fromWindow(WidgetsBinding.instance!.window);

extension NumberParsing on num {
  double w() => this * media.size.width / 100;

  double h() => this * media.size.height / 100;
}
