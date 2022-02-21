import 'package:audioplayers/audioplayers.dart';
import 'package:voice_message_package/src/helpers/colors.dart';
import './duration.dart';
import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:just_audio/just_audio.dart' as jsAudio;
import 'package:sizer/sizer.dart';

import './helpers/widgets.dart';
import './noises.dart';

/// @nodoc
class VoiceMessage extends StatefulWidget {
  const VoiceMessage({
    Key? key,
    required this.audioSrc,
    this.noiseCount = 27,
    this.bgColor = AppColors.pink,
    this.fgColor = const Color(0xffffffff),
  }) : super(key: key);

  final String audioSrc;
  final int noiseCount;
  final Color bgColor, fgColor;

  @override
  _VoiceMessageState createState() => _VoiceMessageState();
}

class _VoiceMessageState extends State<VoiceMessage>
    with SingleTickerProviderStateMixin {
  final AudioPlayer _player = AudioPlayer();
  final double maxNoiseHeight = 6.w, noiseWidth = 27.w;
  Duration? _audioDuration;
  bool _isPlaying = false, x2 = false, _audioConfigurationDone = false;
  int _playingStatus = 0, duration = 00;
  String _remaingTime = '';
  AnimationController? _controller;

  @override
  void initState() {
    _setDuration();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: .8.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _playButton(context),
            SizedBox(width: 3.w),
            _durationWithNoise(context),
            SizedBox(width: 2.2.w),
            _speed(context),
          ],
        ),
      );

  _playButton(BuildContext context) => InkWell(
        child: Container(
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: widget.fgColor),
          width: 8.w,
          height: 8.w,
          child: InkWell(
            onTap: () => _changePlayingStatus(),
            child: Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
              color: widget.bgColor,
              size: 5.w,
            ),
          ),
        ),
      );

  _durationWithNoise(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _noise(context),
          SizedBox(height: .3.w),
          Row(
            children: [
              Widgets.circle(context, 1.w, widget.fgColor),
              SizedBox(width: 1.2.w),
              Text(
                _remaingTime,
                style: TextStyle(fontSize: 10, color: widget.fgColor),
              )
            ],
          ),
        ],
      );

  _noise(BuildContext context) => SizedBox(
        height: 6.5.w,
        width: noiseWidth,
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            const Noises(),
            if (_audioConfigurationDone)
              AnimatedBuilder(
                animation:
                    CurvedAnimation(parent: _controller!, curve: Curves.ease),
                builder: (context, child) {
                  return Positioned(
                    left: _controller!.value,
                    child: Container(
                      width: noiseWidth,
                      height: 6.w,
                      color: widget.bgColor.withOpacity(.4),
                    ),
                  );
                },
              ),
          ],
        ),
      );

  _speed(BuildContext context) => InkWell(
        onTap: () => _toggle2x(),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.6.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.8.w),
            color: widget.fgColor.withOpacity(.28),
          ),
          width: 9.3.w,
          child: Text(
            !x2 ? '1X' : '2X',
            style: TextStyle(fontSize: 10, color: widget.fgColor),
          ),
        ),
      );

  _setPlayingStatus() => _isPlaying = _playingStatus == 1;

  _startPlaying() async {
    _playingStatus = await _player.play(widget.audioSrc);
    _setPlayingStatus();
    _controller!.forward();
  }

  _stopPlaying() async {
    _playingStatus = await _player.pause();
    _controller!.stop();
  }

  void _setDuration() async {
    _audioDuration = await jsAudio.AudioPlayer().setUrl(widget.audioSrc);
    duration = _audioDuration!.inSeconds;
    _setAnimationCunfiguration(_audioDuration);
  }

  void _setAnimationCunfiguration(Duration? audioDuration) {
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: noiseWidth,
      duration: audioDuration,
    );
    _controller!.addListener(() {
      if (_controller!.isCompleted) {
        _controller!.reset();
        _isPlaying = false;
        x2 = false;
        setState(() {});
      }
    });
    _listenToRemaningTime();
    _remaingTime = VoiceDuration.getDuration(duration);
    _completeAnimationConfiguration();
  }

  void _completeAnimationConfiguration() =>
      setState(() => _audioConfigurationDone = true);

  void _toggle2x() {
    x2 = !x2;
    _controller!.duration = Duration(seconds: x2 ? duration ~/ 2 : duration);
    if (_controller!.isAnimating) _controller!.forward();
    _player.setPlaybackRate(x2 ? 2 : 1);
    setState(() {});
  }

  void _changePlayingStatus() async {
    _isPlaying ? _stopPlaying() : _startPlaying();
    setState(() => _isPlaying = !_isPlaying);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _listenToRemaningTime() {
    _player.onAudioPositionChanged.listen((Duration p) {
      final _newRemaingTime1 = p.toString().split('.')[0];
      final _newRemaingTime2 =
          _newRemaingTime1.substring(_newRemaingTime1.length - 5);
      if (_newRemaingTime2 != _remaingTime)
        setState(() => _remaingTime = _newRemaingTime2);
    });
  }
}
