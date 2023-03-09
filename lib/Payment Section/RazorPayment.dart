import 'package:dg_courier/Pages_BottomBar/MapPage.dart';
import 'package:dg_courier/Pages_BottomBar/NewOrder.dart';
import 'package:dg_courier/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

//String TotalPayment = ladu.toString();
class RazorPayment extends StatefulWidget {
  const RazorPayment({Key? key}) : super(key: key);

  @override
  State<RazorPayment> createState() => _RazorPaymentState();
}

class _RazorPaymentState extends State<RazorPayment> {
  final _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear(); // Removes all listeners
  }

  var options = {
    'key': 'rzp_live_09OIyLRCluaVrI',
    'amount': ladu,
    'name': 'Digital Courier',
    'description': 'Canteen',
    'prefill': {'contact': '9998442728', 'email': 'eateria.support@gmail.com'}
  };

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    //sendOrders();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Failed baka');
    Navigator.pushReplacementNamed(context, 'mappage');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        elevation: 0.0,
        title: const Text("Payment Section"),
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontFamily: GoogleFonts.inter().fontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        flexibleSpace: Container(
          decoration:const  BoxDecoration(
              color: dgdarkpink,
              borderRadius:  BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
        ),
      ),
      body: Column(
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
              color: Colors.red
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
                          Text('₹ ${(int.parse(ladu.toString())/100).toStringAsFixed(0)}',
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
                             child: MaterialButton(
                                           
                                                       onPressed: () {
                              sendOrders();
                              try {
                                             
                                             _razorpay.open(options);
                              } catch (e) {
                                             print(e);
                              }
                                                       },
                                                       child:  Text('Pay Now',
                                                       style:TextStyle(
                                                 fontSize: 22,
                                                 fontFamily: GoogleFonts.salsa().fontFamily
                                               ),
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
                  Text('${pickUpController.text} - ',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: GoogleFonts.roboto().fontFamily
                  ),
                  ),
                  Text(deliveryController.text,
                  style:TextStyle(
                    fontSize: 18,
                    fontFamily: GoogleFonts.roboto().fontFamily
                  ),
                  )

                ],
                ),
                Text('Contact No. ${yourPhoneNumber.text}',
                style:TextStyle(
                    fontSize: 18,
                    fontFamily: GoogleFonts.roboto().fontFamily
                  ),
                ),
                Text('Package Type ${buttons.elementAt(dtype.selectedIndex as int)}',
                style:TextStyle(
                    fontSize: 18,
                    fontFamily: GoogleFonts.roboto().fontFamily
                  ),
                ),
                Text('Weight ${kgs.elementAt(kg.selectedIndex as int)}',
                style:TextStyle(
                    fontSize: 18,
                    fontFamily: GoogleFonts.roboto().fontFamily
                  ),
                ),
                Text('Distance $placeDistance km',
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
