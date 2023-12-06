import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:voice_message_package/src/helpers/utils.dart';

/// A widget that represents a single noise.
///
/// This widget is used to display a single noise in the UI.
/// It is a stateful widget, meaning it can change its state over time.
class SingleNoise extends StatefulWidget {
  const SingleNoise({
    super.key,
    required this.activeSliderColor,
    required this.height,
  });

  /// The color of the active slider.
  final Color activeSliderColor;

  /// The height of the noise.
  final double height;
  @override
  State<SingleNoise> createState() => _SingleNoiseState();
}

class _SingleNoiseState extends State<SingleNoise> {
  /// Get screen media.
  final double height = 5.74.w() * math.Random().nextDouble() + .26.w();

  @override

  /// Build the widget.
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: .2.w()),
      width: .56.w(),
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        color: widget.activeSliderColor,
      ),
    );
  }
}
