import 'package:dg_courier/Pages_BottomBar/All_orders_details.dart';
import 'package:dg_courier/Pages_BottomBar/Notification.dart';
import 'package:dg_courier/Pages_BottomBar/profile.dart';
import 'package:dg_courier/Pages_BottomBar/shipment.dart';
import 'package:dg_courier/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _currentIndex = 0;
  final List<Widget> _children = const [
      Orders_Page(),
       Notification_Page(),
     Shipment_Page(),
      Profile_Page(),
  ];
  // int currentIndex = 0;

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Scaffold(
        body: Stack(
          children: [
            _children[_currentIndex],
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                width: size.width,
                // height: 80,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // CustomPaint(
                    //   size: Size(size.width, 120),
                    //   painter: RPSCustomPainter2(),
                    // ),
                    // Positioned(
                    //   bottom: 52,
                    //   right: 5,
                    //   child: Container(
                    //     height: 70,
                    //     width: 70,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(100),
                    //       gradient: LinearGradient(
                    //           colors: [dgblue, dggredientcolor2],
                    //           begin: Alignment.topCenter,
                    //           end: Alignment.bottomCenter),
                    //     ),
                    //     child: FloatingActionButton(
                    //         backgroundColor: Colors.transparent,
                    //         child: Icon(Icons.add_rounded, size: 55),
                    //         elevation: 1,
                    //         onPressed: () {
                    //           Navigator.pushNamed(context, MyRoutes.selection);
                    //         }),
                    //   ),
                    // ),
                    CustomPaint(
                      size: Size(size.width, 110),
                      painter: RPSCustomPainter(),
                    ),
                    Positioned(
                      bottom: 47,
                      right: 6,
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          gradient: const LinearGradient(
                              colors: [dgblue, dggredientcolor2],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                        child: FloatingActionButton(
                            backgroundColor: Colors.transparent,
                            elevation: 1,
                            onPressed: () {
                             Navigator.pushNamed(context, "placed_new_order");
                            },
                            child: const Icon(Icons.add_rounded, size: 55)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              // top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 15),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 85, 5),
                  child: GNav(
                      onTabChange: onTappedBar,
                      backgroundColor: Colors.transparent,
                      color: Colors.white,
                      activeColor: dgdarkpink,
                      tabBackgroundColor: Colors.white,
                      padding: const EdgeInsets.all(12),
                      gap: 8,
                      tabs: [
                        
                        GButton(
                          icon: Icons.shopping_bag_outlined,
                          text: "Orders",
                          textStyle: TextStyle(
                            fontFamily: GoogleFonts.salsa().fontFamily,
                            color: dgdarkpink,
                          ),
                        ),
                        GButton(
                          icon: Icons.sms,
                          text: "Chat",
                          textStyle: TextStyle(
                            fontFamily: GoogleFonts.salsa().fontFamily,
                            color: dgdarkpink,
                          ),
                        ),
                        GButton(
                          haptic: false,
                          icon: Icons.local_shipping_outlined,
                          text: "Shipment",
                          textStyle: TextStyle(
                            fontFamily: GoogleFonts.salsa().fontFamily,
                            color: dgdarkpink,
                          ),
                        ),
                        GButton(
                          icon: Icons.person_outline_sharp,
                          text: "Profile",
                          textStyle: TextStyle(
                            fontFamily: GoogleFonts.salsa().fontFamily,
                            color: dgdarkpink,
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            // )
          ],
        ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = dgdarkpink
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, size.height);
    path0.quadraticBezierTo(
        0, size.height * 0.4375000, 0, size.height * 0.2000000);
    path0.cubicTo(
        size.width * 0.1649375,
        size.height * 0.0769000,
        size.width * 0.2596500,
        size.height * 0.0487500,
        size.width * 0.3749125,
        size.height * 0.0350000);
    path0.cubicTo(
        size.width * 0.6320625,
        size.height * 0.0005000,
        size.width * 0.7593000,
        size.height * -0.0269500,
        size.width * 0.7879125,
        size.height * 0.2923500);
    path0.cubicTo(
        size.width * 0.8065750,
        size.height * 0.7444500,
        size.width * 0.9853625,
        size.height * 0.7494000,
        size.width,
        size.height * 0.2550500);
    path0.quadraticBezierTo(size.width * 1.0010500, size.height * 0.0140500,
        size.width, size.height);
    path0.lineTo(0, size.height);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = dgdarkpink
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, size.height);
    path0.lineTo(0, size.height * 0.2501500);
    path0.quadraticBezierTo(size.width * 0.7154625, size.height * 0.2415000,
        size.width * 0.7875000, size.height * 0.2500000);
    path0.cubicTo(
        size.width * 0.7881250,
        size.height * 0.7521000,
        size.width * 1.0001500,
        size.height * 0.7459500,
        size.width,
        size.height * 0.2500000);
    path0.quadraticBezierTo(size.width * 1.0000125, size.height * 0.0014500,
        size.width, size.height);
    path0.lineTo(0, size.height);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


// class BNBCustomPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = new Paint()
//       ..color = dgdarkpink
//       ..style = PaintingStyle.fill;

//     Path path = Path();
//     path.moveTo(0, 20); // Start
//     path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
//     path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
//     path.arcToPoint(Offset(size.width * 0.60, 20),
//         radius: Radius.circular(20.0), clockwise: false);
//     path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
//     path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.lineTo(0, 20);
//     canvas.drawShadow(path, Colors.black, 5, true);
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
