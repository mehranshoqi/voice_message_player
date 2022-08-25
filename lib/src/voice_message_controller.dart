import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'helpers/play_status.dart';

class VoiceMessageController {
  final String audioSrc;
  final Duration maxDuration;
  late Duration currentDuration = Duration.zero;
  final Function(String id) onComplete;
  final Function(String id) onPlaying;
  final Function(String id) onPause;

  final String id;

  final AudioPlayer _player = AudioPlayer();
  final bool isFile;
  late PlayStatus playStatus = PlayStatus.init;

  late PlaySpeed speed = PlaySpeed.x1;

  late ValueNotifier updater = ValueNotifier(null);

  //late final StreamSubscription? positionStream;
  //late final StreamSubscription? playerStateStream;

  bool isPlayerInit = false;

  ///state
  bool get isPlaying => playStatus == PlayStatus.playing;

  bool get isDownloading => playStatus == PlayStatus.downloading;

  bool get isDownloadError => playStatus == PlayStatus.downloadError;

  bool get isStop => playStatus == PlayStatus.stop;

  bool get isPause => playStatus == PlayStatus.pause;

  VoiceMessageController({
    required this.id,
    required this.audioSrc,
    required this.maxDuration,
    required this.isFile,
    required this.onComplete,
    required this.onPause,
    required this.onPlaying,
  });

  Future initAndPlay() async {
    playStatus = PlayStatus.downloading;
    _updateUi();
    try {
      if (!isPlayerInit) {
        final path = await _getFileFromCache();
        startPlaying(path);
        onPlaying(id);
        _listenToRemindingTime();
        _listenToPlayerState();
        isPlayerInit = true;
      } else {
        final path = await _getFileFromCache();
        startPlaying(path);
        onPlaying(id);
      }
      playStatus = PlayStatus.playing;
      _updateUi();
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
      _updateUi();
    });
  }

  void _updateUi() {
    updater.notifyListeners();
  }

  Future<void> onChangeSlider(double d) async {
    if (isPlaying) {
      playStatus = PlayStatus.pause;
    }
    _updateUi();
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
    //positionStream?.cancel();
    // playerStateStream?.cancel();

      _player.dispose();
      isPlayerInit = false;

  }

  Future<Duration> getMaxDuration() async {
    final voiceD = await _player.setFilePath(audioSrc);
    return voiceD!;
  }

  void onSeek(Duration duration) {
    currentDuration = duration;
    print(currentDuration);
    _updateUi();
    if (isPlayerInit) {
      _player.seek(duration);
    }
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
        await _player.stop();
        currentDuration = Duration.zero;
        playStatus = PlayStatus.init;
        _updateUi();
        onComplete(id);
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
    if (isPlayerInit) {
      _player.setSpeed(speed.getSpeed);
    }
    _updateUi();
  }
}

class MyTicker extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}
