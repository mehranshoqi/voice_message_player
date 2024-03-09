import 'package:flutter/material.dart';
import 'package:voice_message_package/src/widgets/loading_widget.dart';
import 'package:voice_message_package/voice_message_package.dart';

/// A widget representing a play/pause button.
///
/// This button can be used to control the playback of a media player.
class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton(
      {super.key,
      required this.controller,
      required this.color,
      required this.size,
      required this.playIcon,
      required this.pauseIcon,
      required this.refreshIcon , 
      required this.stopDownloadingIcon ,
      required this.loadingColor ,
      this.buttonDecoration ,
      });

  /// The size of the button.
  final double size;

  /// The controller for the voice message view.
  final VoiceController controller;

  /// The color of the button.
  final Color color;

  /// The button Play Icon
  final Widget playIcon;

  /// The button pause Icon
  final Widget pauseIcon;

  /// The button pause Icon
  final Widget refreshIcon;

  /// The button stop Downloading Icon
  final Widget stopDownloadingIcon;

  /// The button Loading Color 
  final Color loadingColor ;

  
  /// The button (container) decoration
  final Decoration ? buttonDecoration ;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: controller.isDownloadError

            /// faild loading audio
            ? controller.play
            : controller.isPlaying

                /// playing or pause
                ? controller.pausePlaying
                : controller.play,
        child: Container(
            height: size,
            width: size,
            decoration: buttonDecoration ?? BoxDecoration(color: color, shape: BoxShape.circle) ,
            child: controller.isDownloading
                ? LoadingWidget(
                    progress: controller.downloadProgress,
                    loadingColor: loadingColor,
                    onClose: () {
                      controller.cancelDownload();
                    },
                    stopDownloadingIcon: stopDownloadingIcon,
                  )
                :

                /// faild to load audio
                controller.isDownloadError

                    /// show refresh icon
                    ?  refreshIcon
                    : controller.isPlaying
                        ? pauseIcon
                        : playIcon

            ),
      );
}
