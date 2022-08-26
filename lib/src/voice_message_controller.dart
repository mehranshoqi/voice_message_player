import 'dart:async';
import 'dart:math';
import 'package:just_audio/just_audio.dart' as jsAudio;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'helpers/play_status.dart';
import 'helpers/utils.dart';

class VoiceMessageController extends MyTicker {
  final String audioSrc;
  late Duration maxDuration;
  Duration currentDuration = Duration.zero;
  final Function(String id) onComplete;
  final Function(String id) onPlaying;
  final Function(String id) onPause;

  //100.5
  final double noiseWidth = 50.5.w();

  final String id;
  late AnimationController animController;

  final AudioPlayer _player = AudioPlayer();
  final bool isFile;
  PlayStatus playStatus = PlayStatus.init;

  PlaySpeed speed = PlaySpeed.x1;

  ValueNotifier updater = ValueNotifier(null);
  final randoms = <double>[];

  //late final StreamSubscription? positionStream;
  //late final StreamSubscription? playerStateStream;

  ///state
  bool get isPlaying => playStatus == PlayStatus.playing;
  bool get isInit => playStatus == PlayStatus.init;

  bool get isDownloading => playStatus == PlayStatus.downloading;

  bool get isDownloadError => playStatus == PlayStatus.downloadError;

  bool get isStop => playStatus == PlayStatus.stop;

  double get currentMillSeconds {
    final c = currentDuration.inMilliseconds.toDouble();
    if (c >= maxMillSeconds) {
      return maxMillSeconds;
    }
    return c;
  }

  bool get isPause => playStatus == PlayStatus.pause;

  double get maxMillSeconds => maxDuration.inMilliseconds.toDouble();

  VoiceMessageController({
    required this.id,
    required this.audioSrc,
    required this.maxDuration,
    required this.isFile,
    required this.onComplete,
    required this.onPause,
    required this.onPlaying,
  }) {
    _setRandoms();
    animController = AnimationController(
      vsync: this,
      upperBound: noiseWidth,
      duration: maxDuration,
    );
    // animController.addListener(() {
    //   print("value is "+animController.value.toString());
    // });
  }

  Future initAndPlay() async {
    playStatus = PlayStatus.downloading;
    _updateUi();
    try {
      final path = await _getFileFromCache();
      final maxDuration = await jsAudio.AudioPlayer().setFilePath(path);
      if (maxDuration != null) {
        this.maxDuration = maxDuration;
        animController.duration = maxDuration;
      }
      await startPlaying(path);
      _listenToRemindingTime();
      _listenToPlayerState();
      onPlaying(id);
      //animController.forward();
    } catch (err) {
      playStatus = PlayStatus.downloadError;
      _updateUi();
      rethrow;
    }
  }

  Future<String> _getFileFromCache() async {
    if (isFile) {
      return audioSrc;
    }
    final p = await DefaultCacheManager().getSingleFile(audioSrc);
    return p.path;
  }

  void _listenToRemindingTime() {
    _player.positionStream.listen((Duration p) {
      currentDuration = p;
      final value = (noiseWidth * currentMillSeconds) / maxMillSeconds;
      animController.value = value;
      _updateUi();
    });
  }

  void _updateUi() {
    updater.notifyListeners();
  }

  Future stopPlaying() async {
    _player.pause();
    playStatus = PlayStatus.stop;
    //  controller!.stop();
  }

  Future startPlaying(String path) async {
    await _player.setAudioSource(
      AudioSource.uri(Uri.parse(path)),
      initialPosition: currentDuration,
    );
    _player.play();
    _player.setSpeed(speed.getSpeed);
    //controller!.forward();
  }

  void dispose() {
    // positionStream?.cancel();
    //playerStateStream?.cancel();
    _player.dispose();
    animController.dispose();
    // isPlayerInit = false;
  }

  void onSeek(Duration duration) {
    currentDuration = duration;
    _updateUi();
    _player.seek(duration);
    if (playStatus == PlayStatus.pause) {
      _player.play();
    }
    //animController.forward();
  }

  void pausePlaying() {
    _player.pause();
    playStatus = PlayStatus.pause;
    _updateUi();
    onPause(id);
  }

  void _listenToPlayerState() {
    _player.playerStateStream.listen((event) async {
      if (event.processingState == ProcessingState.completed) {
        _player.stop();
        currentDuration = Duration.zero;
        playStatus = PlayStatus.init;
        _updateUi();
        animController.reset();
        onComplete(id);
      }
      if (event.playing) {
        playStatus = PlayStatus.playing;
        _updateUi();
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
        break;
      case PlaySpeed.x1_25:
        speed = PlaySpeed.x1_5;
        break;
      case PlaySpeed.x1_5:
        speed = PlaySpeed.x1_75;
        break;
      case PlaySpeed.x1_75:
        speed = PlaySpeed.x2;
        break;
      case PlaySpeed.x2:
        speed = PlaySpeed.x2_25;
        break;
      case PlaySpeed.x2_25:
        speed = PlaySpeed.x1;
        break;
    }
    _player.setSpeed(speed.getSpeed);
    _updateUi();
  }

  void onChangeStart(double value) {
    pausePlaying();
    //animController.stop();
  }

  void _setRandoms() {
    for (var i = 0; i < 50; i++) {
      randoms.add(5.74.w() * Random().nextDouble() + .26.w());
    }
  }

  void onChangeSlider(double d) {
    currentDuration = Duration(milliseconds: d.toInt());
    final value = (noiseWidth * d) / maxMillSeconds;
    // print("Durantion is "+value.toString() + "Value is $d " +" currentMillSeconds $currentMillSeconds" );
    animController.value = value;
    _updateUi();
  }

  String get remindingTime {
    if (currentDuration == Duration.zero) {
      return maxDuration.getStringTime;
    }
    if (isPause || isInit) {
      return maxDuration.getStringTime;
    }
    return currentDuration.getStringTime;
  }
}

class MyTicker extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}
