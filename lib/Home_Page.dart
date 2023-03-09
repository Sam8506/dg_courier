// ignore_for_file: file_names, camel_case_types

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dg_courier/Pages_BottomBar/Notification.dart';
import 'package:dg_courier/Pages_BottomBar/All_orders_details.dart';
import 'package:dg_courier/Pages_BottomBar/placedOrder.dart';
import 'package:dg_courier/Pages_BottomBar/profile.dart';
import 'package:dg_courier/Pages_BottomBar/shipment.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  final appBarTitle = const [
      "Notification",
      "Order Details",
      "DG Curier",
      "Shipments",
      "Profile"
  ];

  final pages  = const [
     Notification_Page(),
     Orders_Page(),
     Place_NewOrder_Page(),
     Shipment_Page(),
     Profile_Page(),
     
  ];

  final bottomNav_list = const [
    Icon(Icons.notification_add,size: 30,),
    Icon(Icons.gif_box_rounded,size: 30,),
    Icon(Icons.add,size: 30,color: Colors.white,),
    Icon(Icons.fire_truck_rounded,size: 30,),
    Icon(Icons.person,size: 30,),
  ];

  int index = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20)
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink,
        title: Text(appBarTitle[index]),
      ),
     
      bottomNavigationBar: Theme(
         
        data: Theme.of(context).copyWith(iconTheme: IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          height: 75,
          color: Colors.pink,
          animationDuration: const Duration(milliseconds: 400),
          items: bottomNav_list,
          index: index,
          backgroundColor: Colors.white,
          onTap: (selectedIndex){
            setState(() {
              
              index = selectedIndex;
            });
          },
        ),
      ),
      
    body: pages[index],
    );
  }
}