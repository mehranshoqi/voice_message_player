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
  final l = <VModel>[];
  VModel? currentPlay;

  @override
  void initState() {
    super.initState();
    l.addAll(List.generate(
      1,
      (i) => VModel(
        id: i.toString(),
        controller: VoiceMessageController(
          audioSrc: "https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.mp3",
          isFile: true,
          onPlaying: onPlaying,
          id: i.toString(),
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
    final cIndex = l.indexWhere((e) => e.id == id);
    if (l.length - 1 != cIndex) {
      l[cIndex + 1].controller.initAndPlay();
    }
  }

  void onPlaying(String id) {
    for (var e in l) {
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
              l.add(
                VModel(
                  id: "i".toString(),
                  controller: VoiceMessageController(
                    audioSrc:
                        "https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.mp3",
                    isFile: true,
                    onPlaying: onPlaying,
                    id: "i".toString(),
                    maxDuration: const Duration(
                      seconds: 7,
                      minutes: 3,
                    ),
                    onPause: (String id) {},
                    onComplete: onComplete,
                  ),
                ),
              );
              setState(() {});
            },
            child: const Icon(Icons.add),
          ),
          SizedBox(
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
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, i) {
          return Builder(builder: (context) =>VoiceMessageView(
            controller: l[i].controller,
          ) ,);

        },
        itemCount: l.length,
      ),
    );
  }
}

class VModel {
  final String id;

  final VoiceMessageController controller;

  const VModel({
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
