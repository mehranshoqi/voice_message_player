import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:voice_message_package/voice_message_package.dart';

import '../helpers/colors.dart';
import '../helpers/style.dart';

/// document will be added
// ignore: must_be_immutable
class Bubble extends StatelessWidget {
  Bubble(this.me, this.index, {Key? key, this.voice = false}) : super(key: key);
  bool me, voice;
  int index;

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(horizontal: 5.2.w, vertical: 2.w),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          textDirection: me ? TextDirection.rtl : TextDirection.ltr,
          children: [
            _bubble(context),
            SizedBox(width: 2.w),
            _seenWithTime(context),
          ],
        ),
      );

  Widget _bubble(BuildContext context) => voice
      ? VoiceMessage(
          audioSrc:
              'https://weellu-chat.s3.us-east-2.amazonaws.com/62d6d147aa86b3d4c159c148/media600-5d441562-e4bb-4e3f-b0e4-5e8efe9d40c0.webm',
          me: index == 5 ? false : true,
          duration: Duration(seconds: 2),
        )
      : Container(
          constraints: BoxConstraints(maxWidth: 100.w * .7),
          padding: EdgeInsets.symmetric(
            horizontal: 4.w,
            vertical: voice ? 2.8.w : 2.5.w,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6.w),
              bottomLeft: me ? Radius.circular(6.w) : Radius.circular(2.w),
              bottomRight: !me ? Radius.circular(6.w) : Radius.circular(1.2.w),
              topRight: Radius.circular(6.w),
            ),
            color: me ? AppColors.pink : Colors.white,
            boxShadow: me
                ? S.pinkShadow(shadow: AppColors.pink100)
                : [S.boxShadow(context, opacity: .05)],
          ),
          child: Text(
            me
                ? 'Hello, How are u?'
                : Random().nextBool()
                    ? 'It\'s Rainy!'
                    : Random().nextBool()
                        ? 'Ok! got it.'
                        : 'How was going bro ?',
            style: TextStyle(
                fontSize: 13.2, color: me ? Colors.white : Colors.black),
          ),
        );

  Widget _seenWithTime(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (me)
            Icon(
              Icons.done_all_outlined,
              color: AppColors.pink,
              size: 3.4.w,
            ),
          Text(
            '1:' '${index + 30}' ' PM',
            style: const TextStyle(fontSize: 11.8),
          ),
          SizedBox(height: .2.w)
        ],
      );
}
