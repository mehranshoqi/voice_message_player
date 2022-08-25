import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:just_audio/just_audio.dart';
import 'helpers/play_status.dart';

class VoiceMessageController {
  final String audioSrc;
  final Duration maxDuration;
  Duration currentDuration = Duration.zero;
  final _player = AudioPlayer();
  final bool isFile;
  PlayStatus playStatus = PlayStatus.init;
  PlaySpeed speed = PlaySpeed.x1;
  late ValueNotifier? updater = ValueNotifier(null);
  late final StreamSubscription positionStream;
  late final StreamSubscription playerStateStream;

  ///state
  bool get isPlaying => playStatus == PlayStatus.playing;

  bool get isStop => playStatus == PlayStatus.stop;

  bool get isPause => playStatus == PlayStatus.pause;

  bool get isInit => playStatus == PlayStatus.init;

  VoiceMessageController(
    this.audioSrc,
    this.maxDuration,
    this.isFile,
  ) {
    init();
  }

  Future init() async {
    // controller = AnimationController(
    //   vsync: MyTicker(),
    //   upperBound: noiseWidth,
    //   duration: maxDuration,
    // );
    _listenToRemindingTime();
    _listenToPlayerState();
  }

  void _listenToRemindingTime() {
    positionStream = _player.positionStream.listen((Duration p) {
      currentDuration = p;
      updateUi();
    });
  }

  void updateUi() {
    if (updater != null) {
      updater!.notifyListeners();
    }
  }

  Future<void> onChangeSlider(double d) async {
    if (isPlaying) {
      playStatus = PlayStatus.pause;
    }
    updateUi();
  }

  Future stopPlaying() async {
    _player.pause();
    playStatus = PlayStatus.stop;
    //  controller!.stop();
  }

  Future startPlaying() async {
    await _player.setAudioSource(
      AudioSource.uri(Uri.parse(audioSrc)),
      initialPosition: currentDuration,
    );
    _player.play();
    _player.setSpeed(2.5);
    playStatus = PlayStatus.playing;
    updateUi();
    //controller!.forward();
  }

  void dispose() {
    //  controller?.dispose();
    positionStream.cancel();
    playerStateStream.cancel();
    _player.dispose();
    updater?.dispose();
    updater = null;
  }

  Future<Duration> getMaxDuration() async {
    final voiceD = await _player.setFilePath(audioSrc);
    return voiceD!;
  }

  void onSeek(Duration duration) {
    currentDuration = duration;
    updateUi();
    _player.seek(duration);
  }

  void pausePlaying() {
    _player.pause();
    playStatus = PlayStatus.pause;
    updateUi();
  }

  void _listenToPlayerState() {
    playerStateStream = _player.playerStateStream.listen((event) async {
      if (event.processingState == ProcessingState.completed) {
        await _player.stop();
        currentDuration = Duration.zero;
        playStatus = PlayStatus.init;
        updateUi();
      }
    });
  }

  String get playSpeedStr {
    switch (speed) {
      case PlaySpeed.x1:
        return "1.00x";
      case PlaySpeed.x1_25:
        return "1.25x";
      case PlaySpeed.x1_5:
        return "1.50x";
      case PlaySpeed.x1_75:
        return "1.75x";
      case PlaySpeed.x2:
        return "2.00x";
      case PlaySpeed.x2_25:
        return "2.25x";
    }
  }

  void changeSpeed() {
    switch (speed) {
      case PlaySpeed.x1:
        speed = PlaySpeed.x1_25;
        _player.setSpeed(1.25);
        break;
      case PlaySpeed.x1_25:
        speed = PlaySpeed.x1_5;
        _player.setSpeed(1.5);
        break;
      case PlaySpeed.x1_5:
        _player.setSpeed(1.75);
        speed = PlaySpeed.x1_75;
        break;
      case PlaySpeed.x1_75:
        _player.setSpeed(2);
        speed = PlaySpeed.x2;
        break;
      case PlaySpeed.x2:
        _player.setSpeed(2.25);
        speed = PlaySpeed.x2_25;
        break;
      case PlaySpeed.x2_25:
        _player.setSpeed(1);
        speed = PlaySpeed.x1;
        break;
    }
    updateUi();
  }
}

class MyTicker extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}
