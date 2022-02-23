import 'package:voice_message/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Sizer(
        builder: (_, __, ___) => const MaterialApp(
            debugShowCheckedModeBanner: false, home: ChatPage()),
      );
}
