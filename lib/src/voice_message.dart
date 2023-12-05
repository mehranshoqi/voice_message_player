import 'package:flutter/material.dart';
import 'package:voice_message_package/src/helpers/play_status.dart';
import 'package:voice_message_package/src/helpers/utils.dart';
import 'package:voice_message_package/src/voice_controller.dart';
import 'package:voice_message_package/src/widgets/noises.dart';
import 'package:voice_message_package/src/widgets/play_pause_button.dart';

class VoiceMessage extends StatelessWidget {
  const VoiceMessage({
    Key? key,
    required this.controller,
    this.backgroundColor = Colors.white,
    this.activeSliderColor = Colors.red,
    this.notActiveSliderColor,
    this.circlesColor = Colors.red,
    this.innerPadding = 12,
    this.cornerRadius = 20,
    this.size = 38,
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

  final VoiceController controller;
  final Color backgroundColor;
  final Color circlesColor;
  final Color activeSliderColor;
  final Color? notActiveSliderColor;
  final TextStyle circlesTextStyle;
  final TextStyle counterTextStyle;
  final double innerPadding;
  final double cornerRadius;
  final double size;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final color = circlesColor;
    final newTHeme = theme.copyWith(
      sliderTheme: SliderThemeData(
        trackShape: CustomTrackShape(),
        thumbShape: SliderComponentShape.noThumb,
        minThumbSeparation: 0,
      ),
      splashColor: Colors.transparent,
    );

    return Container(
      padding: EdgeInsets.all(innerPadding),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(cornerRadius),
      ),
      child: ValueListenableBuilder(
        valueListenable: controller.updater,
        builder: (context, value, child) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PlayPauseButton(controller: controller, color: color, size: size),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 30,
                    width: controller.noiseWidth,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Noises(
                          rList: controller.randoms!,
                          activeSliderColor: activeSliderColor,
                        ),
                        AnimatedBuilder(
                          animation: CurvedAnimation(
                            parent: controller.animController,
                            curve: Curves.ease,
                          ),
                          builder: (BuildContext context, Widget? child) {
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
                          opacity: 0,
                          child: Container(
                            width: controller.noiseWidth,
                            color: Colors.transparent.withOpacity(1),
                            child: Theme(
                              data: newTHeme,
                              child: Slider(
                                value: controller.currentMillSeconds,
                                max: controller.maxMillSeconds,
                                onChangeStart: controller.onChangeSliderStart,
                                onChanged: controller.onChanging,
                                onChangeEnd: (value) {
                                  controller.onSeek(
                                    Duration(milliseconds: value.toInt()),
                                  );
                                  controller.play();
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(controller.remindingTime, style: counterTextStyle),
                ],
              ),
              const SizedBox(width: 12),
              Transform.translate(
                offset: const Offset(0, -7),
                child: InkWell(
                  onTap: controller.changeSpeed,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      controller.speed.playSpeedStr,
                      style: circlesTextStyle,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          );
        },
      ),
    );
  }
}

///
class CustomTrackShape extends RoundedRectSliderTrackShape {
  ///
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    const double trackHeight = 10;
    final double trackLeft = offset.dx,
        trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
