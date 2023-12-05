import 'package:flutter/material.dart';
import 'package:voice_message_package/src/widgets/single_noise.dart';

class Noises extends StatelessWidget {
  const Noises({
    super.key,
    required this.rList,
    required this.activeSliderColor,
  });

  final List<double> rList;
  final Color activeSliderColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: rList
          .map(
            (e) => SingleNoise(
              activeSliderColor: activeSliderColor,
              height: e,
            ),
          )
          .toList(),
    );
  }
}
