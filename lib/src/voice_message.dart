import 'package:flutter/material.dart';
import 'package:voice_message_package/src/helpers/utils.dart';
import 'package:voice_message_package/src/voice_controller.dart';
import 'package:voice_message_package/src/widgets/noises.dart';

/// This is the main widget.
// ignore: must_be_immutable
// class VoiceMessage extends StatefulWidget {
//   VoiceMessage({
//     Key? key,
//     required this.me,
//     this.audioSrc,
//     this.audioFile,
//     this.duration,
//     this.showDuration = false,
//     this.waveForm,
//     this.noiseCount = 27,
//     this.meBgColor = AppColors.pink,
//     this.contactBgColor = const Color(0xffffffff),
//     this.contactFgColor = AppColors.pink,
//     this.contactCircleColor = Colors.red,
//     this.mePlayIconColor = Colors.black,
//     this.contactPlayIconColor = Colors.black26,
//     this.radius = 12,
//     this.contactPlayIconBgColor = Colors.grey,
//     this.meFgColor = const Color(0xffffffff),
//     this.played = false,
//     this.onPlay,
//   }) : super(key: key);
//
//   final String? audioSrc;
//   Future<File>? audioFile;
//   final Duration? duration;
//   final bool showDuration;
//   final List<double>? waveForm;
//   final double radius;
//
//   final int noiseCount;
//   final Color meBgColor,
//       meFgColor,
//       contactBgColor,
//       contactFgColor,
//       contactCircleColor,
//       mePlayIconColor,
//       contactPlayIconColor,
//       contactPlayIconBgColor;
//   final bool played, me;
//   Function()? onPlay;
//
//   @override
//   // ignore: library_private_types_in_public_api
//   _VoiceMessageState createState() => _VoiceMessageState();
// }
//
// class _VoiceMessageState extends State<VoiceMessage>
//     with SingleTickerProviderStateMixin {
//   late StreamSubscription stream;
//   final AudioPlayer _player = AudioPlayer();
//   final double maxNoiseHeight = 6.w(), noiseWidth = 28.5.w();
//   Duration? _audioDuration;
//   double maxDurationForSlider = .0000001;
//   bool _isPlaying = false, x2 = false, _audioConfigurationDone = false;
//   int duration = 00;
//   String _remainingTime = '';
//   AnimationController? _controller;
//
//   @override
//   void initState() {
//     _setDuration();
//     super.initState();
//     stream = _player.onPlayerStateChanged.listen((event) {
//       switch (event) {
//         case PlayerState.stopped:
//           break;
//         case PlayerState.playing:
//           setState(() => _isPlaying = true);
//           break;
//         case PlayerState.paused:
//           setState(() => _isPlaying = false);
//           break;
//         case PlayerState.completed:
//           _player.seek(const Duration(milliseconds: 0));
//           setState(() {
//             duration = _audioDuration!.inMilliseconds;
//             _remainingTime = const Duration(milliseconds: 0).formattedTime;
//           });
//           break;
//         default:
//           break;
//       }
//     });
//     _player.onPositionChanged.listen(
//       (Duration p) {
//         // _remainingTime = p.toString().substring(2, 11);
//         _remainingTime = p.formattedTime;
//         setState(() {});
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) => _sizerChild(context);
//
//   Container _sizerChild(BuildContext context) => Container(
//         padding: EdgeInsets.symmetric(horizontal: .8.w()),
//         constraints: BoxConstraints(maxWidth: 100.w() * .8),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(widget.radius),
//             bottomLeft: widget.me
//                 ? Radius.circular(widget.radius)
//                 : const Radius.circular(4),
//             bottomRight: !widget.me
//                 ? Radius.circular(widget.radius)
//                 : const Radius.circular(4),
//             topRight: Radius.circular(widget.radius),
//           ),
//           color: widget.me ? widget.meBgColor : widget.contactBgColor,
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 4.w(), vertical: 2.8.w()),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _playButton(context),
//               SizedBox(width: 3.w()),
//               _durationWithNoise(context),
//               SizedBox(width: 2.2.w()),
//
//               /// x2 button will be added here.
//               // _speed(context),
//             ],
//           ),
//         ),
//       );
//
//   Widget _playButton(BuildContext context) => InkWell(
//         child: Container(
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: widget.me ? widget.meFgColor : widget.contactPlayIconBgColor,
//           ),
//           width: 10.w(),
//           height: 10.w(),
//           child: InkWell(
//             onTap: () =>
//                 !_audioConfigurationDone ? null : _changePlayingStatus(),
//             child: !_audioConfigurationDone
//                 ? Container(
//                     padding: const EdgeInsets.all(8),
//                     width: 10,
//                     height: 0,
//                     child: CircularProgressIndicator(
//                       strokeWidth: 1,
//                       color:
//                           widget.me ? widget.meFgColor : widget.contactFgColor,
//                     ),
//                   )
//                 : Icon(
//                     _isPlaying ? Icons.pause : Icons.play_arrow,
//                     color: widget.me
//                         ? widget.mePlayIconColor
//                         : widget.contactPlayIconColor,
//                     size: 5.w(),
//                   ),
//           ),
//         ),
//       );
//
//   Widget _durationWithNoise(BuildContext context) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _noise(context),
//           SizedBox(height: .3.w()),
//           Row(
//             children: [
//               /// show played badge
//               if (!widget.played)
//                 Widgets.circle(context, 1.5.w(),
//                     widget.me ? widget.meFgColor : widget.contactCircleColor),
//
//               /// show duration
//               if (widget.showDuration)
//                 Padding(
//                   padding: EdgeInsets.only(left: 1.2.w()),
//                   child: Text(
//                     widget.duration!.formattedTime,
//                     style: TextStyle(
//                       fontSize: 10,
//                       color:
//                           widget.me ? widget.meFgColor : widget.contactFgColor,
//                     ),
//                   ),
//                 ),
//               SizedBox(width: 1.5.w()),
//               SizedBox(
//                 width: 50,
//                 child: Text(
//                   _remainingTime,
//                   style: TextStyle(
//                     fontSize: 10,
//                     color: widget.me ? widget.meFgColor : widget.contactFgColor,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       );
//
//   /// Noise widget of audio.
//   Widget _noise(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     final newTHeme = theme.copyWith(
//       sliderTheme: SliderThemeData(
//         trackShape: CustomTrackShape(),
//         thumbShape: SliderComponentShape.noThumb,
//         minThumbSeparation: 0,
//       ),
//     );
//
//     ///
//     return Theme(
//       data: newTHeme,
//       child: SizedBox(
//         height: 6.5.w(),
//         width: noiseWidth,
//         child: Stack(
//           clipBehavior: Clip.hardEdge,
//           children: [
//             Noises(
//               isFromMe: widget.me,
//             ),
//             if (_audioConfigurationDone)
//               AnimatedBuilder(
//                 animation:
//                     CurvedAnimation(parent: _controller!, curve: Curves.ease),
//                 builder: (context, child) {
//                   return Positioned(
//                     left: _controller!.value,
//                     child: Container(
//                       width: noiseWidth,
//                       height: 6.w(),
//                       color: widget.me
//                           ? widget.meBgColor.withOpacity(.4)
//                           : widget.contactBgColor.withOpacity(.35),
//                     ),
//                   );
//                 },
//               ),
//             Opacity(
//               opacity: .0,
//               child: Container(
//                 width: noiseWidth,
//                 color: Colors.amber.withOpacity(0),
//                 child: Slider(
//                   min: 0.0,
//                   max: maxDurationForSlider,
//                   onChangeStart: (__) => _stopPlaying(),
//                   onChanged: (_) => _onChangeSlider(_),
//                   value: duration + .0,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // _speed(BuildContext context) => InkWell(
//   //       onTap: () => _toggle2x(),
//   //       child: Container(
//   //         alignment: Alignment.center,
//   //         padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.6.w),
//   //         decoration: BoxDecoration(
//   //           borderRadius: BorderRadius.circular(2.8.w),
//   //           color: widget.meFgColor.withOpacity(.28),
//   //         ),
//   //         width: 9.8.w,
//   //         child: Text(
//   //           !x2 ? '1X' : '2X',
//   //           style: TextStyle(fontSize: 9.8, color: widget.meFgColor),
//   //         ),
//   //       ),
//   //     );
//
//   void _startPlaying() async {
//     if (widget.audioFile != null) {
//       String path = (await widget.audioFile!).path;
//       debugPrint("> _startPlaying path $path");
//       await _player.play(DeviceFileSource(path));
//     } else if (widget.audioSrc != null) {
//       await _player.play(UrlSource(widget.audioSrc!));
//     }
//     _controller!.forward();
//   }
//
//   _stopPlaying() async {
//     await _player.pause();
//     _controller!.stop();
//   }
//
//   void _setDuration() async {
//     if (widget.duration != null) {
//       _audioDuration = widget.duration;
//     } else {
//       if (widget.audioFile != null) {
//         String path = (await widget.audioFile!).path;
//         _audioDuration = await jsAudio.AudioPlayer().setFilePath(path);
//       } else if (widget.audioSrc != null) {
//         _audioDuration = await jsAudio.AudioPlayer().setUrl(widget.audioSrc!);
//       }
//     }
//
//     _audioDuration ??= const Duration(seconds: 60);
//     duration = _audioDuration!.inMilliseconds;
//     maxDurationForSlider = duration + .0;
//
//     ///
//     _controller = AnimationController(
//       vsync: this,
//       lowerBound: 0,
//       upperBound: noiseWidth,
//       duration: _audioDuration,
//     );
//
//     ///
//     _controller!.addListener(() {
//       if (_controller!.isCompleted) {
//         _controller!.reset();
//         _isPlaying = false;
//         x2 = false;
//         setState(() {});
//       }
//     });
//     _setAnimationConfiguration(_audioDuration!);
//   }
//
//   void _setAnimationConfiguration(Duration audioDuration) async {
//     setState(() {
//       _remainingTime = audioDuration.formattedTime;
//     });
//     debugPrint("_setAnimationConfiguration $_remainingTime");
//     _completeAnimationConfiguration();
//   }
//
//   void _completeAnimationConfiguration() =>
//       setState(() => _audioConfigurationDone = true);
//
//   // void _toggle2x() {
//   //   x2 = !x2;
//   //   _controller!.duration = Duration(seconds: x2 ? duration ~/ 2 : duration);
//   //   if (_controller!.isAnimating) _controller!.forward();
//   //   _player.setPlaybackRate(x2 ? 2 : 1);
//   //   setState(() {});
//   // }
//
//   void _changePlayingStatus() async {
//     if (widget.onPlay != null) widget.onPlay!();
//     _isPlaying ? _stopPlaying() : _startPlaying();
//     setState(() => _isPlaying = !_isPlaying);
//   }
//
//   @override
//   void dispose() {
//     stream.cancel();
//     _player.dispose();
//     _controller?.dispose();
//     super.dispose();
//   }
//
//   ///
//   _onChangeSlider(double d) async {
//     if (_isPlaying) _changePlayingStatus();
//     duration = d.round();
//     _controller?.value = (noiseWidth) * duration / maxDurationForSlider;
//     _remainingTime = _audioDuration!.formattedTime;
//     await _player.seek(Duration(milliseconds: duration));
//     setState(() {});
//   }
// }

class VoiceMessage extends StatelessWidget {
  const VoiceMessage({
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

  final VoiceController controller;
  final Color backgroundColor;
  final Color circlesColor;
  final Color activeSliderColor;
  final Color? notActiveSliderColor;
  final TextStyle circlesTextStyle;
  final TextStyle counterTextStyle;

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
                  Container(
                    height: 38,
                    width: 38,
                    padding: const EdgeInsets.all(8),
                    decoration:
                        BoxDecoration(color: color, shape: BoxShape.circle),
                    child: CircularProgressIndicator(
                      color: backgroundColor,
                      strokeWidth: 2,
                    ),
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
                    onTap: controller.play,
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
                    onTap: controller.play,
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
                            activeSliderColor: activeSliderColor,
                          ),
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
                                child: Slider(
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
