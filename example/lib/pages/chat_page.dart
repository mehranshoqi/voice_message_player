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
  final l = List.generate(
    100,
    (i) => VModel(
      id: i,
      url: "https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.mp3",
      d: const Duration(
        seconds: 7,
        minutes: 3,
      ),
      controller: VoiceMessageController(
        audioSrc: "https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.mp3",
        isFile: true,
        maxDuration: const Duration(
          seconds: 7,
          minutes: 3,
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Example"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const VoicePlayer(
                duration: Duration(seconds: 7, minutes: 3),
                url: "https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.mp3",
              );
            },
          );
        },
        child: const Icon(Icons.music_note),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, i) {
          return VoiceMessageView(
            audioSrc: l[i].url,
            duration: l[i].d,
            me: true,
            isFile: false,
          );
        },
        itemCount: l.length,
      ),
    );
  }
}

class VModel {
  final int id;
  final String url;
  final Duration d;
  final VoiceMessageController controller;

  const VModel({
    required this.id,
    required this.url,
    required this.d,
    required this.controller,
  });
}
