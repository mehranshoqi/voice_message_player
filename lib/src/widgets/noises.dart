import 'package:flutter/material.dart';
import 'package:voice_message_package/src/widgets/single_noise.dart';

class Noises extends StatelessWidget {
  const Noises({super.key, required this.isFromMe});

  final bool isFromMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < 27; i++)
          SingleNoise(
            isFromMe: isFromMe,
          )
      ],
    );
  }
}
