import 'dart:math';

import 'package:flutter/material.dart';
import 'package:voice_message/pages/voice_player.dart';
import 'package:voice_message_package/voice_message_package.dart';

// ignore: must_be_immutable
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final list = <VModel>[];

  @override
  void initState() {
    super.initState();
    list.addAll(List.generate(
      100,
      (i) => VModel(
        id: "${Random().nextInt(456747455)}".toString(),
        controller: VoiceMessageController(
          audioSrc: "https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.mp3",
          isFile: false,
          onPlaying: onPlaying,
          id: "${Random().nextInt(567567745)}".toString(),
          maxDuration: const Duration(
            seconds: 7,
            minutes: 3,
          ),
          onPause: (String id) {},
          onComplete: onComplete,
        ),
      ),
    ));
  }

  void onComplete(String id) {
    final cIndex = list.indexWhere((e) => e.id == id);
    if (cIndex == -1) {
      return;
    }
    if (cIndex == list.length - 1) {
      return;
    }
    if (list.length - 1 != cIndex) {
     list[cIndex + 1].controller.initAndPlay();
    }
  }

  void onPlaying(String id) {
    for (var e in list) {
      if (e.id != id) {
        if (e.controller.isPlaying) {
          e.controller.pausePlaying();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Example"),
        centerTitle: true,
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            onPressed: () {
              list.insert(
                0,
                VModel(
                  id: "${Random().nextInt(2364566745)}".toString(),
                  controller: VoiceMessageController(
                    audioSrc:
                        "https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.mp3",
                    isFile: false,
                    onPlaying: (id) {},
                    id: "${Random().nextInt(1000546345)}".toString(),
                    maxDuration: const Duration(
                      seconds: 7,
                      minutes: 3,
                    ),
                    onPause: (String id) {},
                    onComplete: (id) {},
                  ),
                ),
              );
              setState(() {});
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const VoicePlayer(
                    duration: Duration(seconds: 7, minutes: 3),
                    url:
                        "https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.mp3",
                  );
                },
              );
            },
            child: const Icon(Icons.music_note),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        reverse: false,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, i) {
          return VoiceMessageView(
            controller: list[i].controller,
            key: ValueKey(list[i].id),
          );
        },
        itemCount: list.length,
      ),
    );
  }
}

class VModel {
  final String id;

  final VoiceMessageController controller;

  VModel({
    required this.id,
    required this.controller,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
