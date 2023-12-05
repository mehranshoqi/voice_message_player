import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voice_message_package/voice_message_package.dart';

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({
    super.key,
    required this.controller,
    required this.color,
    required this.size,
  });

  final double size;
  final VoiceController controller;
  final Color color;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: controller.isDownloadError
            ? controller.initAndPlay
            : controller.isPlaying
                ? controller.pausePlaying
                : controller.initAndPlay,
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: controller.isDownloading
              ? const CupertinoActivityIndicator()
              : Icon(
                  controller.isDownloadError
                      ? Icons.refresh
                      : controller.isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                  color: Colors.white,
                ),
        ),
      );
}
