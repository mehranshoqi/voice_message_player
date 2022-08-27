import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'helpers/utils.dart';
import 'voice_message_controller.dart';
import 'widgets/noises.dart';

class VoiceMessageView extends StatelessWidget {
  final VoiceMessageController controller;
  final Color backgroundColor;
  final Color circlesColor;
  final Color activeSliderColor;
  final Color? notActiveSliderColor;
  final TextStyle circlesTextStyle;
  final TextStyle counterTextStyle;

  const VoiceMessageView({
    Key? key,
    required this.controller,
    this.backgroundColor = Colors.white,
    this.activeSliderColor = Colors.red,
    this.notActiveSliderColor,
    this.circlesColor = Colors.red,
    this.circlesTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 10,
      fontWeight: FontWeight.bold,
    ),
    this.counterTextStyle = const TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final color = circlesColor;
    final ThemeData theme = Theme.of(context);
    final newTHeme = theme.copyWith(
      sliderTheme: SliderThemeData(
        trackShape: CustomTrackShape(),
        thumbShape: SliderComponentShape.noThumb,
        minThumbSeparation: 0,
      ),
    );

    return ColoredBox(
      color: backgroundColor,
      child: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: controller.updater,
          builder: (context, value, child) {
            return Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 5,
                ),
                if (controller.isDownloading)
                  const SizedBox(
                    height: 38,
                    width: 38,
                    child: CupertinoActivityIndicator(),
                  )
                else if (controller.isPlaying)
                  InkWell(
                    onTap: controller.pausePlaying,
                    child: Container(
                      height: 38,
                      width: 38,
                      decoration:
                          BoxDecoration(color: color, shape: BoxShape.circle),
                      child: const Icon(
                        Icons.pause_rounded,
                        color: Colors.white,
                      ),
                    ),
                  )
                else if (controller.isDownloadError)
                  InkWell(
                    onTap: controller.initAndPlay,
                    child: Container(
                      height: 38,
                      width: 38,
                      decoration:
                          BoxDecoration(color: color, shape: BoxShape.circle),
                      child: const Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                    ),
                  )
                else
                  InkWell(
                    onTap: controller.initAndPlay,
                    child: Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                      width: controller.noiseWidth,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Noises(
                              rList: controller.randoms,
                              activeSliderColor: activeSliderColor),
                          AnimatedBuilder(
                            animation: CurvedAnimation(
                              parent: controller.animController,
                              curve: Curves.ease,
                            ),
                            builder: (BuildContext context, Widget? child) {
                              //print("controller.animController.value is ${controller.animController.value}");
                              return Positioned(
                                left: controller.animController.value,
                                child: Container(
                                  width: controller.noiseWidth,
                                  height: 6.w(),
                                  color: notActiveSliderColor ??
                                      backgroundColor.withOpacity(.4),
                                ),
                              );
                            },
                          ),
                          Opacity(
                            opacity: .0,
                            child: Container(
                              width: controller.noiseWidth,
                              color: Colors.amber.withOpacity(1),
                              child: Theme(
                                data: newTHeme,
                                child: Slider.adaptive(
                                  value: controller.currentMillSeconds,
                                  max: controller.maxMillSeconds,
                                  onChangeStart: controller.onChangeSliderStart,
                                  onChanged: controller.onChanging,
                                  onChangeEnd: (value) {
                                    controller.onSeek(
                                      Duration(milliseconds: value.toInt()),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      controller.remindingTime,
                      style: counterTextStyle,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
                Transform.translate(
                  offset: const Offset(0, -7),
                  child: InkWell(
                    onTap: controller.changeSpeed,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3, vertical: 2),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        controller.playSpeedStr,
                        style: circlesTextStyle,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
