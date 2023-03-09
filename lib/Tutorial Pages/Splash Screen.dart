
import 'package:dg_courier/Login_Page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  void _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 1500));
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => loginPage()));
  }

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.95),
      child: Center(
        child: SizedBox(
          height: 230,
          width: 230,
          child: Image.asset("assets/images/Logo.png"),
        ),
      ),
    );
  }
}
