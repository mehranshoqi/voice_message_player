import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../helpers/utils.dart';

/// document will be added
class Noises extends StatelessWidget {
  final List<double> rList;
  final Color activeSliderColor;

  const Noises({Key? key, required this.rList, required this.activeSliderColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: rList.map((e) => _singleNoise(e)).toList(),
    );
  }

  Widget _singleNoise(double height) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: .2.w()),
      width: .5.w(),
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        color: activeSliderColor,
      ),
    );
  }
}
