import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../helpers/style.dart';
import '../helpers/widgets.dart';
import '../widgets/bubble.dart';

// ignore: must_be_immutable
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) =>
      Scaffold(
          body: _messagesWithUserInfo(context));

  Widget _messagesWithUserInfo(BuildContext context) => SafeArea(
        child: Column(
          children: [
            _userInformation(context),
            const SizedBox(height: 8),
            _buildContainer(context),
          ],
        ),
      );

  Widget _userInformation(BuildContext context) => Padding(
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
              child: Icon(Icons.arrow_back_ios_outlined, size: 3.7.w),
            ),
            SizedBox(width: 5.5.w),
            //* avatar.
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CircleAvatar(
                radius: 5.w,
                child: Image.network(
                  'https://media-exp1.licdn.com/dms/image/C4E03AQEL_Gzug73LaQ/profile-displayphoto-shrink_400_400/0/1645345884553?e=1651104000&v=beta&t=zTI_ZpRBstjAOoCtETIFCANGGjLIm7ueMW7MyDIBLlM',
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

  Widget _buildContainer(BuildContext context) => Expanded(
        child: Container(
          padding: const EdgeInsets.only(top: 18),
          decoration: BoxDecoration(
            color: Colors.black,
            boxShadow: S.innerBoxShadow(),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(S.radius38(context)),
              topRight: Radius.circular(S.radius38(context)),
            ),
          ),
          child: _messagesList(context),
        ),
      );

  Widget _messagesList(BuildContext context) => ListView.builder(
        itemCount: 7,
        itemBuilder: (BuildContext context, int index) => Bubble(
          index == 1 || index == 4 || index == 6, // for two chat side.
          index,
          voice: index == 4 || index == 5,
        ),
      );
}
