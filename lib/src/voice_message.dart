import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:just_audio/just_audio.dart' as jsAudio;
import 'package:voice_message_package/src/contact_noise.dart';
import 'package:voice_message_package/src/helpers/utils.dart';

import './helpers/widgets.dart';
import './noises.dart';
import 'duration.dart';
import 'helpers/colors.dart';

/// This is the main widget.
///
// ignore: must_be_immutable
class VoiceMessage extends StatefulWidget {
  VoiceMessage({
    Key? key,
    required this.audioSrc,
    required this.me,
    this.durationTime = '',
    this.noiseCount = 27,
    this.meBgColor = AppColors.pink,
    this.contactBgColor = const Color(0xffffffff),
    this.contactFgColor = AppColors.pink,
    this.contactCircleColor = Colors.red,
    this.mePlayIconColor = Colors.black,
    this.contactPlayIconColor = Colors.black26,
    this.contactPlayIconBgColor = Colors.grey,
    this.meFgColor = const Color(0xffffffff),
    this.played = false,
    this.onPlay,
  }) : super(key: key);

  final String audioSrc;
  final String durationTime;
  final int noiseCount;
  final Color meBgColor,
      meFgColor,
      contactBgColor,
      contactFgColor,
      contactCircleColor,
      mePlayIconColor,
      contactPlayIconColor,
      contactPlayIconBgColor;
  final bool played, me;
  Function()? onPlay;

  @override
  // ignore: library_private_types_in_public_api
  _VoiceMessageState createState() => _VoiceMessageState();
}

class _VoiceMessageState extends State<VoiceMessage>
    with SingleTickerProviderStateMixin {
  late StreamSubscription stream;
  final AudioPlayer _player = AudioPlayer();
  final double maxNoiseHeight = 6.w(), noiseWidth = 26.5.w();
  Duration? _audioDuration;
  double maxDurationForSlider = .0000001;
  bool _isPlaying = false, x2 = false, _audioConfigurationDone = false;
  int duration = 00;
  String _remaingTime = '';
  AnimationController? _controller;

  @override
  void initState() {
    _setDuration();
    super.initState();
    stream = _player.onPlayerStateChanged.listen((event) {
      switch (event) {
        case PlayerState.stopped:
          break;
        case PlayerState.playing:
          setState(() {
            _isPlaying = true;
          });
          break;
        case PlayerState.paused:
          setState(() {
            _isPlaying = false;
          });
          break;
        case PlayerState.completed:
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) => _sizerChild(context);

  Container _sizerChild(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: .8.w()),
      constraints: BoxConstraints(maxWidth: 100.w() * .7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6.w()),
          bottomLeft:
              widget.me ? Radius.circular(6.w()) : Radius.circular(2.w()),
          bottomRight:
              !widget.me ? Radius.circular(6.w()) : Radius.circular(1.2.w()),
          topRight: Radius.circular(6.w()),
        ),
        color: widget.me ? widget.meBgColor : widget.contactBgColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w(), vertical: 2.8.w()),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _playButton(context),
            SizedBox(width: 3.w()),
            _durationWithNoise(context),
            SizedBox(width: 2.2.w()),

            /// x2 button will be added here.
            // _speed(context),
          ],
        ),
      ),
    );
  }

  _playButton(BuildContext context) => InkWell(
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.me ? widget.meFgColor : widget.contactPlayIconBgColor,
          ),
          width: 10.w(),
          height: 10.w(),
          child: InkWell(
            onTap: () =>
                !_audioConfigurationDone ? null : _changePlayingStatus(),
            child: !_audioConfigurationDone
                ? Container(
                    padding: const EdgeInsets.all(8),
                    width: 10,
                    height: 0,
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                      color:
                          widget.me ? widget.meFgColor : widget.contactFgColor,
                    ),
                  )
                : Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    color: widget.me
                        ? widget.mePlayIconColor
                        : widget.contactPlayIconColor,
                    size: 5.w(),
                  ),
          ),
        ),
      );

  _durationWithNoise(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _noise(context),
          SizedBox(height: .3.w()),
          Row(
            children: [
              if (!widget.played)
                Widgets.circle(context, 1.5.w(),
                    widget.me ? widget.meFgColor : widget.contactCircleColor),
              if (widget.durationTime.isNotEmpty)
                SizedBox(width: 1.2.w()),
              if (widget.durationTime.isNotEmpty)
                Text(
                  widget.durationTime,
                  style: TextStyle(
                    fontSize: 10,
                    color: widget.me ? widget.meFgColor : widget.contactFgColor,
                  ),
                ),
              SizedBox(width: 1.5.w()),
              Text(
                _remaingTime,
                style: TextStyle(
                  fontSize: 10,
                  color: widget.me ? widget.meFgColor : widget.contactFgColor,
                ),
              ),
            ],
          ),
        ],
      );

  /// Noise widget of audio.
  _noise(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final newTHeme = theme.copyWith(
      sliderTheme: SliderThemeData(
        trackShape: CustomTrackShape(),
        thumbShape: SliderComponentShape.noThumb,
        minThumbSeparation: 0,
      ),
    );

    /// document will be added
    return Theme(
      data: newTHeme,
      child: SizedBox(
        height: 6.5.w(),
        width: noiseWidth,
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            widget.me ? const Noises() : const ContactNoise(),
            if (_audioConfigurationDone)
              AnimatedBuilder(
                animation:
                    CurvedAnimation(parent: _controller!, curve: Curves.ease),
                builder: (context, child) {
                  return Positioned(
                    left: _controller!.value,
                    child: Container(
                      width: noiseWidth,
                      height: 6.w(),
                      color: widget.me
                          ? widget.meBgColor.withOpacity(.4)
                          : widget.contactBgColor.withOpacity(.35),
                    ),
                  );
                },
              ),
            Opacity(
              opacity: .0,
              child: Container(
                width: noiseWidth,
                color: Colors.amber.withOpacity(1),
                child: Slider(
                  min: 0.0,
                  max: maxDurationForSlider,
                  onChangeStart: (__) => _stopPlaying(),
                  onChanged: (_) => _onChangeSlider(_),
                  value: duration + .0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // _speed(BuildContext context) => InkWell(
  //       onTap: () => _toggle2x(),
  //       child: Container(
  //         alignment: Alignment.center,
  //         padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.6.w),
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(2.8.w),
  //           color: widget.meFgColor.withOpacity(.28),
  //         ),
  //         width: 9.8.w,
  //         child: Text(
  //           !x2 ? '1X' : '2X',
  //           style: TextStyle(fontSize: 9.8, color: widget.meFgColor),
  //         ),
  //       ),
  //     );


  void _startPlaying() async {
    await _player.play(UrlSource(widget.audioSrc));
    _controller!.forward();
  }

  _stopPlaying() async {
    await _player.pause();
    _controller!.stop();
  }

  void _setDuration() async {
    _audioDuration = await jsAudio.AudioPlayer().setUrl(widget.audioSrc);
    duration = _audioDuration!.inSeconds;
    maxDurationForSlider = duration + .0;

    /// document will be added
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: noiseWidth,
      duration: _audioDuration,
    );

    /// document will be added
    _controller!.addListener(() {
      if (_controller!.isCompleted) {
        _controller!.reset();
        _isPlaying = false;
        x2 = false;
        setState(() {});
      }
    });
    _setAnimationCunfiguration(_audioDuration);
  }

  void _setAnimationCunfiguration(Duration? audioDuration) async {
    _listenToRemaningTime();
    setState(() {
      _remaingTime = VoiceDuration.getDuration(duration);
    });
    debugPrint("_setAnimationCunfiguration $_remaingTime");
    _completeAnimationConfiguration();
  }

  void _completeAnimationConfiguration() =>
      setState(() => _audioConfigurationDone = true);

  // void _toggle2x() {
  //   x2 = !x2;
  //   _controller!.duration = Duration(seconds: x2 ? duration ~/ 2 : duration);
  //   if (_controller!.isAnimating) _controller!.forward();
  //   _player.setPlaybackRate(x2 ? 2 : 1);
  //   setState(() {});
  // }

  void _changePlayingStatus() async {
    if (widget.onPlay != null) widget.onPlay!();
    _isPlaying ? _stopPlaying() : _startPlaying();
    setState(() => _isPlaying = !_isPlaying);
  }

  @override
  void dispose() {
    stream.cancel();
    _player.dispose();
    super.dispose();
  }

  void _listenToRemaningTime() {
    _player.onPositionChanged.listen((Duration p) {
      final newRemaingTime1 = p.toString().split('.')[0];
      final newRemaingTime2 = newRemaingTime1.substring(newRemaingTime1.length - 5);
      if (newRemaingTime2 != _remaingTime) {
        setState(() => _remaingTime = newRemaingTime2);
      }
    });
  }

  /// document will be added
  _onChangeSlider(double d) async {
    if (_isPlaying) _changePlayingStatus();
    duration = d.round();
    _controller?.value = (noiseWidth) * duration / maxDurationForSlider;
    _remaingTime = VoiceDuration.getDuration(duration);
    await _player.seek(Duration(seconds: duration));
    setState(() {});
  }
}

/// document will be added
class CustomTrackShape extends RoundedRectSliderTrackShape {
  /// document will be added
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    const double trackHeight = 10;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
