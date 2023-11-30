import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:voice_message_package/src/helpers/utils.dart';

class SingleNoise extends StatefulWidget {
  const SingleNoise({
    super.key,
    required this.isFromMe,
  });

  final bool isFromMe;

  @override
  State<SingleNoise> createState() => _SingleNoiseState();
}

class _SingleNoiseState extends State<SingleNoise> {
  final double height = 5.74.w() * math.Random().nextDouble() + .26.w();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: .2.w()),
      width: .56.w(),
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        color: widget.isFromMe ? Colors.white : Colors.grey,
      ),
    );
  }
}
