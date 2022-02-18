import 'dart:ui';

import 'package:voice_message/helpers/style.dart';
import 'package:voice_message/helpers/widgets.dart';
import 'package:voice_message/widgets/bubble.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: _messagesWithUserInfo(context));

  _messagesWithUserInfo(BuildContext context) => SafeArea(
        child: Column(
          children: [
            _userInformation(context),
            const SizedBox(height: 8),
            _buildContainer(context),
          ],
        ),
      );

  _userInformation(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(vertical: 3.w, horizontal: 8.w),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.4.w),
                color: Colors.black.withOpacity(.07),
              ),
              padding: EdgeInsets.symmetric(horizontal: 3.8.w, vertical: 3.1.w),
              child: Icon(
                Icons.arrow_back_ios_outlined,
                size: 3.7.w,
              ),
            ),
            SizedBox(width: 5.5.w),
            //* avatar.
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CircleAvatar(
                radius: 5.w,
                child: Image.network(
                  'https://media-exp1.licdn.com/dms/image/C5603AQGVEMVyB9FTHA/profile-displayphoto-shrink_400_400/0/1635749927116?e=1650499200&v=beta&t=PNDp-3xRc66PlnbbcxQoNVHIB9BuUXpn636OUHgAcSc',
                ),
              ),
            ),
            SizedBox(width: 3.7.w),
            //* name & activity.
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: .3.w),
                const Text('Mehran Shoghi', style: TextStyle(fontSize: 13.5)),
                SizedBox(height: 1.1.w),
                Row(
                  children: [
                    Widgets.circle(context, 1.7.w, Colors.greenAccent),
                    SizedBox(width: 1.75.w),
                    Text(
                      'Active Now',
                      style: TextStyle(
                          fontSize: 12.2, color: Colors.grey.shade600),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      );

  _buildContainer(BuildContext context) => Expanded(
        child: Container(
          padding: const EdgeInsets.only(top: 18),
          decoration: BoxDecoration(
            boxShadow: S.innerBoxShadow(),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(S.radius38(context)),
              topRight: Radius.circular(S.radius38(context)),
            ),
          ),
          child: _messagesList(context),
        ),
      );

  _messagesList(BuildContext context) => ListView.builder(
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) => Bubble(
          index == 1 || index == 4 || index == 6, // for two chat side.
          index,
          voice: index == 4,
        ),
      );
}
