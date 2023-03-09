// import 'package:dg_courier/Pages_BottomBar/MapPage.dart';
// import 'package:dg_courier/Pages_BottomBar/NewOrder.dart';
// import 'package:dg_courier/Utils/Colors.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:velocity_x/velocity_x.dart';

// class detailsOfOrder extends StatelessWidget {
//   const detailsOfOrder({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Stack(
//             children: 
            
//         [
//           Image.asset("assets/images/payment_bac.jpg",
//           fit: BoxFit.fill,
          
//                     ),
//           Container(
//             height: 300,
//             padding: EdgeInsets.all(30),
//             margin: EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
              
//             ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Container(
//                 margin: EdgeInsets.only(right:25),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   color: dgyellow
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                           Text('₹${order['Total_Amount']}',
//                           style: TextStyle(
                            
//                             fontFamily: GoogleFonts.salsa().fontFamily,
//                             fontSize: 30
//                           ),
//                           ) ,
              
//                            Container(
//                             margin: EdgeInsets.all(12),
//                             padding: EdgeInsets.symmetric(horizontal: 7),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(100),
//                               color: dgdarkpink
//                             ),
//                              child: Text('order 1',
//                              style:TextStyle(
//                                                  fontSize: 22,
//                                                  fontFamily: GoogleFonts.salsa().fontFamily
//                                                ),
//                              ),
//                            )
//                         ],),
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                 Row(
//                  //mainAxisAlignment: MainAxisAlignment.spaceAround, 
//                   children: [
//                   Text('${pickUpController.text} - ',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontFamily: GoogleFonts.roboto().fontFamily
//                   ),
//                   ),
//                   Text(deliveryController.text,
//                   style:TextStyle(
//                     fontSize: 18,
//                     fontFamily: GoogleFonts.roboto().fontFamily
//                   ),
//                   )

//                 ],
//                 ),
//                 Text('Contact No. ${yourPhoneNumber.text}',
//                 style:TextStyle(
//                     fontSize: 18,
//                     fontFamily: GoogleFonts.roboto().fontFamily
//                   ),
//                 ),
//                 Text('Package Type ${buttons.elementAt(dtype.selectedIndex as int)}',
//                 style:TextStyle(
//                     fontSize: 18,
//                     fontFamily: GoogleFonts.roboto().fontFamily
//                   ),
//                 ),
//                 Text('Weight ${kgs.elementAt(kg.selectedIndex as int)}',
//                 style:TextStyle(
//                     fontSize: 18,
//                     fontFamily: GoogleFonts.roboto().fontFamily
//                   ),
//                 ),
//                 Text('Distance $placeDistance km',
//                 style:TextStyle(
//                     fontSize: 22,
//                     fontFamily: GoogleFonts.salsa().fontFamily
//                   ),
//                 )
//               ]),
              
//             ],
//           ),
          
//           ).scrollHorizontal(physics: BouncingScrollPhysics( ))
//         ]
//           ),
//         ]
        
         

//       );
  
//   }
// }