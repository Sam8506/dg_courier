import 'package:dg_courier/FireBaseService/Services.dart';
import 'package:dg_courier/Pages_BottomBar/NewOrder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

enum Fruit { COD, Razorpay }

Fruit? _fruit = Fruit.COD;

class Profile_Page extends StatefulWidget {
  const Profile_Page({Key? key}) : super(key: key);

  @override
  State<Profile_Page> createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
 
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            user.photoURL!= null? Center(
              child: CircleAvatar(
              backgroundImage: NetworkImage(user.photoURL!),
              maxRadius: 60,
              ),
            ) :
            const Center(
              child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/images.png'),
              maxRadius: 60,
              ),
            ),
            
          
            Padding(
              padding:const EdgeInsets.all(16.0),
              child: user.displayName!=null? Text(
                user.displayName!, //Display User Name
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22
              ),)
             :
             const Text('John Doe'), 
            ),
            user.email!=null? Text(user.email!) : const Text('null'),
            Container(
              margin: const EdgeInsets.only(left:8,right: 8.0,top: 10.0),
              height: 650,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 239, 180, 199),
                borderRadius:  BorderRadius.only(
                  topLeft:  Radius.circular(20),
                  topRight: Radius.circular(20),
                  ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  Container(
                    color: Colors.pink,
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Text('Change Your Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        wordSpacing: 1.2
                      ),
                      
                      ),
                      )
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: (){
                            showDialog(
        context: context,
        builder: (_) =>  AlertDialog(
            title: const Text('Add Company Details'),
            content: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Enter Specific Location'
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Enter Comapany Number'
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                                  children: [
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },
                                        child: const Text('CANCEL')),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                      child: ElevatedButton(
                                          onPressed: () async{
                                            Navigator.pop(context, false);
                                          },
                                          child: const Text('SUBMIT'))),
                                ]),
              ],
            )

        )
    );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          // ignore: prefer_const_literals_to_create_immutables
                          child: Row(children: [
                            const Icon(Icons.info_outline_sharp),
                            const SizedBox(
                              width: 10,
                            ),
                            Text('Company Details')
                          ]),
                        ),
                      ),
                       GestureDetector(
                        onTap: (){
                           showDialog(
        context: context,
        builder: (_) =>  AlertDialog(
            title: const Text('Selcet Payment Method'),
            content: Column(
              children: [
                

 ListTile(
            title: const Text('Cash On Delivery'),
            leading: Radio<Fruit>(
              value: Fruit.COD,
              groupValue: _fruit,
              onChanged: (Fruit? value) {
                setState(() {
                  _fruit = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('RazorPay API'),
            leading: Radio<Fruit>(
              value: Fruit.Razorpay,
              groupValue: _fruit,
              onChanged: (Fruit? value) {
                setState(() {
                  _fruit = value;
                });
              },
            ),
            ),
            Row(
                                  children: [
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },
                                        child: const Text('CANCEL')),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: ElevatedButton(
                                          onPressed: () async{
                                            Navigator.pop(context, false);
                                          },
                                          child: const Text('OK'))),
                                ]),
              ],
            ),
            scrollable: true,

        )
    );
                        },
                         child: Container(
                          padding: const EdgeInsets.all(12),
                          child: Row(children: [
                            Icon(Icons.payment),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Payments Method')
                          ]),
                                             ),
                       ),
                       Container(
                        padding: EdgeInsets.all(12),
                        child: Row(children: [
                          Icon(Icons.location_on_sharp),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Set Your Locaion')
                        ]),
                      ),
                       Container(
                        padding: EdgeInsets.all(12),
                        child: InkWell(
                          onTap: () async{
                            showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        backgroundColor: Colors.pink[50],
                            title: const Icon(Icons.power_settings_new_rounded),
                            content: SizedBox(
                              
                              width: 100,
                              height: 120,
                              child: Column(
                                children: [
                                const Text("Do You want to Log Out?",
                                style:  TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black
                                ),
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  children: [
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },
                                        child: const Text('CANCEL')),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: ElevatedButton(
                                          onPressed: () async{
                                            await FirebaseServices().signOutWithGoogle();
                                           
                                            Navigator.pushNamed(context, 'login_page');
                                          },
                                          child: const Text('OK'))),
                                ]),
                              ]),
                            ),
                          ));
                            
                          },
                          child: Row(
                            children:const [
                             Icon(Icons.logout_sharp),
                            SizedBox(
                              width: 10,
                            ),
                           Text('Log Out')
                          ]),
                        ),
                      ),
                       Container(
                        padding: const EdgeInsets.all(12),
                        child: InkWell(
                          onTap: () async{
                         showDialog(
        context: context,
        builder: (_) =>  AlertDialog(
            title: const Text('Share Application'),
            content: Text('Coming Soon..'),
        )
        
        
    );
      
       
                          },
                          child: Row(
                            children:const [
                            Icon(Icons.share),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Share Application')
                          ]),
                        ),
                      ),
                       GestureDetector(
                        onTap: (){
                          showDialog(
        context: context,
        builder: (_) =>  AlertDialog(
            title: const Text('About Us'),
            content: Text('Email: dgcurier@support1.com\nCompant Locatuon: Anand')

        )
    );
                        },
                         child: Container(
                          padding: const EdgeInsets.all(12),
                          child: Row(children: [
                            Icon(Icons.info),
                            SizedBox(
                              width: 10,
                            ),
                            Text('About Us')
                          ]),
                                             ),
                       ),
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        decoration:const BoxDecoration(
                          color: Color.fromARGB(255, 70, 158, 231),
                          borderRadius: BorderRadius.all(Radius.circular(8))
                        ),
                        child: TextButton(
                         
                          onPressed: (){
                            Navigator.pushNamed(context, 'changeProfile');
                          },
                          child: const Text('Change Profile',style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            letterSpacing: 1.1
                          ),),
                        ),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}