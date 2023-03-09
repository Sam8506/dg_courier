import 'package:dg_courier/Login_Page.dart';
import 'package:dg_courier/Order_Details_All/each_order_details.dart';
import 'package:dg_courier/Pages_BottomBar/All_orders_details.dart';
import 'package:dg_courier/Pages_BottomBar/BottomNavigationBar.dart';
import 'package:dg_courier/Pages_BottomBar/NewOrder.dart';
import 'package:dg_courier/Pages_BottomBar/MapPage.dart';
import 'package:dg_courier/Pages_BottomBar/placedOrder.dart';
import 'package:dg_courier/Pages_BottomBar/profilePages/changeProfilePage.dart';
import 'package:dg_courier/Payment%20Section/RazorPayment.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Tutorial Pages/Splash Screen.dart';


Future<void> main() async{
         
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dg-Curier',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        //accentColor: Colors.pink,
        primarySwatch: Colors.pink,
      ),
      debugShowCheckedModeBanner: false,
      
      initialRoute: 'splash_screen',
      routes: {
       'splash_screen' : (context) => const SplashScreen(),
       'login_page' : (context) => const loginPage(),
       'home_page'  : (context) => const BottomNavigationBarWidget(),
       'changeProfile' :(context) => const changeProfilePage(),
       'schedule_order' :(context) => const  NewOrder(),
       'mappage' :(context) => const HomePage(),
       'payment' :(context) => const RazorPayment(),
       'placed_new_order' :(context) => const Place_NewOrder_Page(),
      // 'dOrder' :(context) => const dOrder(),
       
      },
    );
  }
}