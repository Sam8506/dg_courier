import 'package:flutter/material.dart';
class Shipment_Page extends StatefulWidget {
  const Shipment_Page({Key? key}) : super(key: key);

  @override
  State<Shipment_Page> createState() => _Shipment_PageState();
}

class _Shipment_PageState extends State<Shipment_Page> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset('assets/images/shipment.jpeg'));
  }
}