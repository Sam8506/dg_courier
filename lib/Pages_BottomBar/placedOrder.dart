import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Utils/Colors.dart';
int flag = 0;
class Place_NewOrder_Page extends StatefulWidget {
  const Place_NewOrder_Page({Key? key}) : super(key: key);

  @override
  State<Place_NewOrder_Page> createState() => _Place_NewOrder_PageState();
}

class _Place_NewOrder_PageState extends State<Place_NewOrder_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("Place Order"),
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
              borderRadius:const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
        ),
      ),
    body: Container(
        margin: const EdgeInsets.fromLTRB(16,60,16,0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.purple,width: 2),
          borderRadius:const BorderRadius.all(Radius.circular(10)),
          // color: dgdarkpink.withOpacity(0.2),
           gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: 
                     [dgdarkpink.withOpacity(0.3),dgblue.withOpacity(0.3)] 
                    )
        ),
        
        child: Center(
          child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
            children: [
            
               GestureDetector(
                onTap: (){
                  setState(() {
                    flag = 0;
                  });
                  Navigator.pushNamed(context, 'schedule_order');
                },
                 child: Container(
                    height: MediaQuery.of(context).size.height/5,
                    width: MediaQuery.of(context).size.width/1.5,
                    decoration: BoxDecoration(
                      border: Border.all(color: dgdarkpink,width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    //   gradient: LinearGradient(
                    //   begin: Alignment.topCenter,
                    //   end: Alignment.bottomCenter,
                    //   colors: 
                      
                    // )
                  color: dgblue.withOpacity(0.4)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.timer,size: 45,color: Colors.white,),SizedBox(height: 5,),
                        Text('Place Now',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                      ],
                    ),
                  ),
               ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      flag = 1;
                    });
                     Navigator.pushNamed(context, 'schedule_order');
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height/5,
                    width: MediaQuery.of(context).size.width/1.5,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.pink,width: 3),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    //    gradient: const LinearGradient(
                    //   begin: Alignment.topCenter,
                    //   end: Alignment.bottomCenter,
                    //   colors: [
                    //     Colors.white,Colors.white
                    //   ],
                    // )
                    color: dgblue.withOpacity(0.4)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                         Icon(Icons.schedule,size: 45,color: Colors.white,),
                         Padding(
                          padding:  EdgeInsets.all(5.0),
                          child: Text('Schedule Now',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                        )
                      ],
                    ),
                  ),
                ),
              
            ],
          ),
        ),
      ),
    );
  }
}