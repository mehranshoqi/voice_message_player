import 'package:flutter/material.dart';

/// Get screen media.
final MediaQueryData media =
    MediaQueryData.fromWindow(WidgetsBinding.instance.window);

/// This extention help us to make widget responsive.
extension NumberParsing on num {
  double w() => this * media.size.width / 100;

  double h() => this * media.size.height / 100;
}

extension StringExtension on String {
  String? get appendZeroPrefix {
    return length <= 1 ? "0$this" : this;
  }
}

extension DurationExtension on Duration {
  String get formattedTime {
    int sec = inSeconds % 60;
    int min = (inSeconds / 60).floor();
    return "${min.toString().appendZeroPrefix}:${sec.toString().appendZeroPrefix}";
  }
}
