import 'package:dg_courier/Pages_BottomBar/placedOrder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';
import 'package:velocity_x/velocity_x.dart';
import '../Utils/Colors.dart';

TextEditingController pickUpController = TextEditingController();
TextEditingController pickUpPhoneNumber = TextEditingController();
TextEditingController receiverPhoneNumber = TextEditingController();
TextEditingController deliveryController = TextEditingController();
TextEditingController yourPhoneNumber = TextEditingController();
TextEditingController cValue= TextEditingController();

GroupButtonController dtype = GroupButtonController();
GroupButtonController kg = GroupButtonController();

List buttons =  [
                                "Documents",
                                "Food",
                                "Clothes",
                                "Groceries",
                                "Flowers",
                                "Cake",
                                "Cameras",
                                "Fabric",
                                "Computers"
                              ];

List kgs =  [
                                "1 kgs",
                                "5 kgs",
                                "10 kgs",
                                "20 kgs",
                                "Above 20 kgs",
                              ];                             
late DatabaseReference sendOrder;
final user = FirebaseAuth.instance.currentUser!;
int i =0;

class NewOrder extends StatefulWidget {
  const NewOrder({Key? key}) : super(key: key);

  @override
  State<NewOrder> createState() => NewOrderState();
}
  late TimeOfDay time1;
  late TimeOfDay time2;
  late TimeOfDay droped;
  late TimeOfDay picked;

class NewOrderState extends State<NewOrder> {
 
  

  @override
  void initState() {
    super.initState();
    sendOrder = FirebaseDatabase.instance.ref();
    time1 = TimeOfDay.now();
    time2 = TimeOfDay.now();
  }

  Future<void> selectTime1(BuildContext context) async {
    picked = (await showTimePicker(context: context, initialTime: time1))!;
    setState(() {
      time1 = picked;
    });
  }

  Future<void> selectTime2(BuildContext context) async {
    droped = (await showTimePicker(context: context, initialTime: time1))!;
    setState(() {
      time2 = droped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("Create Order"),
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontFamily: GoogleFonts.inter().fontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: dgdarkpink,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
        ),
      ),
      body: SafeArea(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Book a Courier,",
                          style: TextStyle(
                              fontSize: 22,
                              fontFamily: GoogleFonts.salsa().fontFamily),
                        ),
                        Text(
                          "We will arrive at each address at specific times.",
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: GoogleFonts.inter().fontFamily,
                              fontStyle: FontStyle.italic),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.circle_rounded,
                                      size: 15,
                                      color: dgblue,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: dgblue,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        height: 213,
                                        width: 2.5,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Icon(
                                        Icons.location_pin,
                                        size: 18,
                                        color: dggreen,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: dgblue,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        height: 165,
                                        width: 2.5,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Icon(
                                        Icons.add_circle,
                                        size: 18,
                                        color: dgdarkpink,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width - 68,
                                  child: Column(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Pickup Point",
                                            style: TextStyle(
                                              color: dgdarkpink,
                                              fontFamily:
                                                  GoogleFonts.inriaSans()
                                                      .fontFamily,
                                              fontSize: 18,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          
                                          InkWell(
                                            child: TextFormField(
                                              controller: pickUpController,
                                              // onTap: () {
                                                  
                                              //     setState(() async {
                                              //       {
                                              //         Position position =
                                              //             (await determinePosition())
                                              //                 as Position;

                                              //         googlemapController.animateCamera(
                                              //             CameraUpdate.newCameraPosition(
                                              //                 CameraPosition(
                                              //                     target: LatLng(
                                              //                         position
                                              //                             .latitude,
                                              //                         position
                                              //                             .longitude),
                                              //                     zoom: 18)));
                                              //         markers.clear();
                                              //         markers.add(Marker(
                                              //             markerId: MarkerId(
                                              //                 'Current Address'),
                                              //             position: LatLng(
                                              //                 position.latitude,
                                              //                 position
                                              //                     .longitude)));
                                              //       }
                                              //     });
                                              // },
                                              textCapitalization:
                                                  TextCapitalization.words,
                                              decoration:const InputDecoration(
                                                hintText: "Address",
                                                hintStyle:
                                                    TextStyle(fontSize: 14),
                                                suffixIcon: Icon(
                                                  Icons.location_pin,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.timer_outlined,
                                                color: dgdarkpink,
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Text(
                                                  "Enter the address to find out when the courier will arrive",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        GoogleFonts.inter()
                                                            .fontFamily,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            controller: pickUpPhoneNumber,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            textCapitalization:
                                                TextCapitalization.words,
                                            decoration: const InputDecoration(
                                              hintText: "Phone Number",
                                              hintStyle:
                                                  TextStyle(fontSize: 14),
                                              suffixIcon: Icon(
                                                Icons.phone_enabled,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              selectTime1(context);
                                              print(time1);
                                            },
                                            child: Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  flag == 0 ?Text(
                                                    'Time For PickUp of Courier => ${time1.hour}:${time1.minute}',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily:
                                                            GoogleFonts.inter()
                                                                .fontFamily,
                                                        color: Colors.black),
                                                  ) : 
                                                  const Text('Our Delivery Boy Arrive at Your Location Soon').scrollHorizontal(),
                                                  const Padding(
                                                    padding:
                                                         EdgeInsets.only(
                                                      right: 12,
                                                    ),
                                                    child: Icon(
                                                      Icons.access_time,
                                                      color: Colors.grey,
                                                    ),
                                                  )
                                                ],
                                              ).scrollHorizontal(),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Delivery Point",
                                            style: TextStyle(
                                              color: dgdarkpink,
                                              fontFamily:
                                                  GoogleFonts.inriaSans()
                                                      .fontFamily,
                                              fontSize: 18,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            controller: deliveryController,
                                            onTap: () {
                                              // Navigator.pushNamed(context,
                                              //     MyRoutes.destinationmap);
                                            },
                                            textCapitalization:
                                                TextCapitalization.words,
                                            decoration:const InputDecoration(
                                              hintText: "Address",
                                              hintStyle:
                                                  TextStyle(fontSize: 14),
                                              suffixIcon: Icon(
                                                Icons.location_pin,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.timer_outlined,
                                                color: dgdarkpink,
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Text(
                                                  "Enter the address to find out when the courier will arrive",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        GoogleFonts.inter()
                                                            .fontFamily,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            controller: receiverPhoneNumber,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            textCapitalization:
                                                TextCapitalization.words,
                                            decoration: const InputDecoration(
                                              hintText: "Phone Number",
                                              hintStyle:
                                                  TextStyle(fontSize: 14),
                                              suffixIcon: Icon(
                                                Icons.phone_enabled,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              selectTime2(context);
                                              print(time2);
                                            },
                                            child: Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  
                                                  Text(
                                                    'Time For Delivery of Courier => ${time2.hour}:${time2.minute}',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily:
                                                            GoogleFonts.inter()
                                                                .fontFamily,
                                                        color: Colors.black),
                                                  ),
                                                  const Padding(
                                                    padding:
                                                         EdgeInsets.only(
                                                            right: 12),
                                                    child: Icon(
                                                      Icons.access_time,
                                                      color: Colors.grey,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: dggrey,
                    height: 15,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Package",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: GoogleFonts.salsa().fontFamily),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            "What are you sending?",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.5),
                              fontFamily: GoogleFonts.inter().fontFamily,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            const SizedBox(
                              height: 5,
                              width: 15,
                            ),
                            GroupButton(
                              controller: dtype,
                              options: GroupButtonOptions(
                                  selectedTextStyle: TextStyle(
                                    fontFamily: GoogleFonts.inter().fontFamily,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  unselectedTextStyle: TextStyle(
                                    fontFamily: GoogleFonts.inter().fontFamily,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  borderRadius:
                                     const BorderRadius.all(Radius.circular(50)),
                                  direction: Axis.horizontal,
                                  spacing: 10,
                                  unselectedColor:
                                     const Color.fromARGB(255, 227, 225, 225),
                                  selectedColor: const Color(0xfff82b60),
                                  textPadding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5)
                                      ),
                              
                              isRadio: true, buttons: buttons,
                            ),
                            const SizedBox(
                              height: 5,
                              width: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: cValue,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            prefixText: "₹  ",
                            prefixStyle: TextStyle(
                                fontFamily: GoogleFonts.inter().fontFamily,
                                fontSize: 16),
                            labelText: "Courier Value",
                            labelStyle: TextStyle(
                                fontFamily: GoogleFonts.inter().fontFamily),
                          ),
                          style: TextStyle(
                              fontFamily: GoogleFonts.inter().fontFamily,
                              fontSize: 16),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Text(
                            "We will reimburse the value of lost items within three working days in accordance with the rules. Maximum compensation - will be available up to 50,000.",
                            style: TextStyle(
                              color: const Color.fromARGB(221, 70, 70, 70),
                              fontFamily: GoogleFonts.inter().fontFamily,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            
                            GroupButton(
                              controller: kg,
                              options: GroupButtonOptions(
                                  selectedTextStyle: TextStyle(
                                    fontFamily: GoogleFonts.inter().fontFamily,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  unselectedTextStyle: TextStyle(
                                    fontFamily: GoogleFonts.inter().fontFamily,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  borderRadius:
                                     const BorderRadius.all(Radius.circular(50)),
                                  direction: Axis.horizontal,
                                  spacing: 10,
                                  unselectedColor:
                                     const Color.fromARGB(255, 227, 225, 225),
                                  selectedColor: const Color(0xfff82b60),
                                  textPadding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5)
                                      ),
                              
                              isRadio: true, buttons: kgs,
                            ),
                            const SizedBox(
                              height: 5,
                              width: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  // ignore: prefer_const_constructors
                  ExpansionTile(
                    expandedAlignment: Alignment.centerLeft,
                      title: const Text('Price Distribution Per Kilometer'),
                    children:const [
                       Text(' 1 kg = 1 ₹ \n 5 kg = 4 ₹ \n 10 kg = 7 ₹ \n 20 kg = 13 ₹ \n Above 20 kg = 17 ₹  ')
                    ], 
                       
                        ),
                        TextFormField(
                          controller: yourPhoneNumber,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            labelText: "Your Phone",
                            labelStyle: TextStyle(
                                fontFamily: GoogleFonts.inter().fontFamily),
                            prefixText: "+91  ",
                            prefixStyle: TextStyle(
                                fontFamily: GoogleFonts.inter().fontFamily,
                                fontSize: 16),
                            suffixIcon:const Icon(
                              Icons.phone_enabled,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed:() async{
                        //sendOrders();
                       Navigator.pushNamed(context, "mappage");
                      } ,
                       child: const Text("Next")),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
    
  }
  
}



