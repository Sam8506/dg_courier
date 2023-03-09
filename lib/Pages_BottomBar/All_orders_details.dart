import 'package:dg_courier/Utils/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
final user = FirebaseAuth.instance.currentUser!;
class Orders_Page extends StatefulWidget {
  const Orders_Page({Key? key}) : super(key: key);

  @override
  State<Orders_Page> createState() => Orders_PageState();
}

  //TextEditingController pick = TextEditingController();
  late DatabaseReference dbreference;
  late Query fetchData;
  //String databaseJSON = "";

class Orders_PageState extends State<Orders_Page> {
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbreference = FirebaseDatabase.instance.ref();
    fetchData = FirebaseDatabase.instance.ref().child(user.uid).child('order');
     
  }
int boom = 0;
  Widget orderList({required Map order}){
    return Card(
      child: ListTile(
        title: Text('${order['PickUp_Address']} - ${order['delivery_Address']}'),
        subtitle: Text('${order['dType']}'),
        onTap: ()  {

          showDialog(
        context: context,
        builder: (_) =>  AlertDialog(
            title: const Text('Order 1'),
            content: Column(
    
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Stack(
              children:    
          [
            Container(
              height: 300,
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.yellow
              ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.only(right:25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: dgyellow
                  ),
                  child: null
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text('Pickup Address: ${order['PickUp_Address']}',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: GoogleFonts.roboto().fontFamily
                  ),
                  ),
                  Text('Delivery Address: ${order['delivery_Address']}',
                  style:TextStyle(
                    fontSize: 18,
                    fontFamily: GoogleFonts.roboto().fontFamily
                  ),
                  ),
                  Text('Sender Number : +91 ${order['Sender_Number']}',
                  style:TextStyle(
                      fontSize: 18,
                      fontFamily: GoogleFonts.roboto().fontFamily
                    ),
                  ),
                  Text('Reciver Number : +91 ${order['Receiver_Number']}',
                  style:TextStyle(
                      fontSize: 18,
                      fontFamily: GoogleFonts.roboto().fontFamily
                    ),
                  ),
                  Text('PickUp Time: ${order['pTime']}',
                  style:TextStyle(
                      fontSize: 18,
                      fontFamily: GoogleFonts.roboto().fontFamily
                    ),
                  ),
                  Text('Delivery Time: ${order['dTime']}',
                  style:TextStyle(
                      fontSize: 18,
                      fontFamily: GoogleFonts.roboto().fontFamily
                    ),
                  ),
                  Text('Distance: ${order['Total_distance']} Km ',
                  style:TextStyle(
                      fontSize: 18,
                      fontFamily: GoogleFonts.roboto().fontFamily
                    ),
                  ),
                  Text('Amount: ${order['Total_Amount']}',
                  style:TextStyle(
                      fontSize: 18,
                      fontFamily: GoogleFonts.roboto().fontFamily
                    ),
                  )
                ]),
                
              ],
            ),
            
            ).scrollHorizontal(physics: BouncingScrollPhysics( ))
          ]
            ),
          ]
          
           
    
        ),

        )
    );
          
        },
        
      ),
    );
    // return Container(
    //   margin: EdgeInsets.all(8),
    //   padding: EdgeInsets.all(8),
    //   height: 100,
    //   decoration: BoxDecoration(
    //     color: Colors.pink[50]
    //   ),
    //   child: Column(
        
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text('Pickup Address:- '+order['PickUp_Address']),
    //       Text('Delivery Address:- '+order['delivery_Address']),
    //       Text('Receiver:- '+order['Receiver_Number']),
    //       Text('Sender Number:- '+order['Sender_Number']),
    //     ],
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Column(
            children: [
               Expanded(
                 child: SizedBox(
                  height: double.infinity,
                  child: FirebaseAnimatedList(
                    query: fetchData ,
                    itemBuilder: (BuildContext context,
                     DataSnapshot snapshot,
                      Animation<double>animation,
                      int index){
                        Map order;
                        order = snapshot.value as Map;
                        if(order.isNotEmpty){
                          scam(order:order);
                          return orderList(order: order);
                        }else{
                          return  const Center(
                            child:  Text('Opps! No Previous Order Found')
                            );
                        }
                          
                    },
                    ),
                ),
               ),
             
            ],
          ),
    );
  }
  Widget scam({required Map order}){   
    return Scaffold(
      body: Column(
    
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            Stack(
              children: 
              
          [
            Image.asset("assets/images/payment_bac.jpg",
            fit: BoxFit.fill,
            
                      ),
            Container(
              height: 300,
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                
              ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.only(right:25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: dgyellow
                  ),
                  child: Column(
                   
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                            Text('',
                            style: TextStyle(
                              
                              fontFamily: GoogleFonts.salsa().fontFamily,
                              fontSize: 30
                            ),
                            ) ,
                
                             Container(
                              margin: EdgeInsets.all(12),
                              padding: EdgeInsets.symmetric(horizontal: 7),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: dgdarkpink
                              ),
                               child: Text('order 1',
                               style:TextStyle(
                                                   fontSize: 22,
                                                   fontFamily: GoogleFonts.salsa().fontFamily
                                                 ),
                               ),
                             )
                          ],),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Row(
                   //mainAxisAlignment: MainAxisAlignment.spaceAround, 
                    children: [
                    Text('55',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: GoogleFonts.roboto().fontFamily
                    ),
                    ),
                    Text('g',
                    style:TextStyle(
                      fontSize: 18,
                      fontFamily: GoogleFonts.roboto().fontFamily
                    ),
                    )
    
                  ],
                  ),
                  Text('Contact No. ',
                  style:TextStyle(
                      fontSize: 18,
                      fontFamily: GoogleFonts.roboto().fontFamily
                    ),
                  ),
                  Text('Package Type }',
                  style:TextStyle(
                      fontSize: 18,
                      fontFamily: GoogleFonts.roboto().fontFamily
                    ),
                  ),
                  Text('Weight }',
                  style:TextStyle(
                      fontSize: 18,
                      fontFamily: GoogleFonts.roboto().fontFamily
                    ),
                  ),
                  Text('Distance  km',
                  style:TextStyle(
                      fontSize: 22,
                      fontFamily: GoogleFonts.salsa().fontFamily
                    ),
                  )
                ]),
                
              ],
            ),
            
            ).scrollHorizontal(physics: BouncingScrollPhysics( ))
          ]
            ),
          ]
          
           
    
        ),
    );
  }
}


//  class dOrder extends StatelessWidget {
//   const dOrder({super.key});


//   // final ref = FirebaseDatabase.instance.ref();
//   //                 final s = await ref.child('$user.uid/order').get();
//   @override
//   Widget build(BuildContext context) {
//     return  scam(order: order);
//   }
  
// }