import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

import 'voice_message_controller.dart';

class VoiceMessageView extends StatefulWidget {
  final String audioSrc;
  final Duration duration;
  final bool me;
  final bool isFile;

  const VoiceMessageView({
    Key? key,
    required this.audioSrc,
    required this.duration,
    required this.me,
    required this.isFile,
  }) : super(key: key);

  @override
  _VoiceMessageViewState createState() => _VoiceMessageViewState();
}

class _VoiceMessageViewState extends State<VoiceMessageView> {
  late final VoiceMessageController controller;

  @override
  void initState() {
    controller = VoiceMessageController(
      widget.audioSrc,
      widget.duration,
      widget.isFile,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder(
        valueListenable: controller.updater!,
        builder: (context, value, child) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 5,
              ),
              if (controller.isPlaying)
                InkWell(
                  onTap: controller.pausePlaying,
                  child: const Icon(
                    Icons.pause_circle,
                    size: 38,
                    color: Colors.red,
                  ),
                )
              else
                InkWell(
                  onTap: controller.startPlaying,
                  child: const Icon(
                    Icons.play_circle,
                    color: Colors.red,
                    size: 38,
                  ),
                ),
              const SizedBox(
                width: 2,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProgressBar(
                    progress: controller.currentDuration,
                    total: controller.maxDuration,
                    barCapShape: BarCapShape.square,
                    baseBarColor: Colors.grey,
                    barHeight: 10,
                    progressBarColor: Colors.redAccent,
                    thumbGlowColor: Colors.red,
                    thumbGlowRadius: 12,
                    timeLabelLocation: TimeLabelLocation.below,
                    thumbColor: Colors.green,
                    timeLabelType: TimeLabelType.totalTime,
                    onSeek: (duration) {
                      controller.onSeek(duration);
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Transform.translate(
                offset: const Offset(0, 8),
                child: InkWell(
                  onTap: controller.changeSpeed,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      controller.playSpeedStr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
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
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
