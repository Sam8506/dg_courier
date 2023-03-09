import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
class Notification_Page extends StatefulWidget {
  const Notification_Page({Key? key}) : super(key: key);

  @override
  State<Notification_Page> createState() => _Notification_PageState();
}

class _Notification_PageState extends State<Notification_Page> {
  @override
  Widget build(BuildContext context) {
    return  Center(child: Stack(
      children: [
        GestureDetector(child: Image.asset('assets/images/bot.jpg')
        //,onTap: ()=> ,
        ),
      ],
    ));
  }
}