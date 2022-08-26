import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'voice_message_controller.dart';

class VoiceMessageView extends StatefulWidget {
  final VoiceMessageController controller;

  const VoiceMessageView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _VoiceMessageViewState createState() => _VoiceMessageViewState();
}

class _VoiceMessageViewState extends State<VoiceMessageView> {
  late final VoiceMessageController controller;

  @override
  void initState() {
    controller = widget.controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).brightness == Brightness.dark
        ? Colors.green
        : Colors.red;
    return SafeArea(
      child: ValueListenableBuilder(
        valueListenable: controller.updater,
        builder: (context, value, child) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  child:
                      Icon(PhosphorIcons.pauseCircle, size: 38, color: color),
                )
              else if (controller.isDownloadError)
                InkWell(
                  onTap: controller.initAndPlay,
                  child: Icon(Icons.replay_circle_filled_outlined,
                      size: 38, color: color),
                )
              else
                InkWell(
                  onTap: controller.initAndPlay,
                  child: Icon(
                    PhosphorIcons.playCircle,
                    color: color,
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
                    barHeight: 3,
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
                      color: color,
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
