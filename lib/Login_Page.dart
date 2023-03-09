// ignore: file_names
// ignore_for_file: camel_case_types, prefer_const_constructors, depend_on_referenced_packages
import 'package:dg_courier/FireBaseService/Services.dart';
import 'package:dg_courier/Utils/Colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

int intialIndex = 0;

class loginPage extends StatefulWidget {

  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {

  final _signUpFormKey = GlobalKey<FormState>();
  String errorMessage = '';
  bool isLogin = true;
  bool isValidateForm = false;
  int flag = 0;
  
  double _strength = 0;
  late String _password;
  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp special = RegExp(r".*[@,#,^,&,*]");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

  final TextEditingController uEmail = TextEditingController();
  final TextEditingController uPassword = TextEditingController();
  final TextEditingController cPassword = TextEditingController();
  final TextEditingController fName = TextEditingController();
  final TextEditingController lName = TextEditingController();
  final TextEditingController mNumber = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                child: flag==0?Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Login,\nWelcome To The Digital Word',
                  style: TextStyle(
                    fontFamily: GoogleFonts.salsa().fontFamily,
                    fontSize: 18
                    ),
                  ),
                ) : 
                Text(
                  'Hello\nSignUp Here ',
                style: TextStyle(
                  fontFamily: GoogleFonts.salsa().fontFamily,
                  fontSize: 18
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ), 
              Padding(
                padding: const EdgeInsets.only(left:12.0,bottom: 12.0),
                child: ToggleSwitch(
                  //animate: true,
                  curve: Curves.easeIn,
                  minHeight: 35,
                  minWidth: 100.0,
                  initialLabelIndex: intialIndex,
                  cornerRadius: 20.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.pink[100],
                  inactiveFgColor: Colors.black,
                  totalSwitches: 2,
                  labels:const ['Login', 'SignUp'],
                  activeBgColors:  [[dgdarkpink],[dgdarkpink]],
                  onToggle: (index) {
                      setState(() {
                          index == 1 ? flag = 1 : flag = 0;
                          intialIndex = index!;
                        });
                  },
                ),
              ),
             Container(
               child: intialIndex == 0?
              LoginForm() 
            :
            SignUpForm()
             ),
            ],
          ),
        ),
      ),
    );  
  }
  void _checkPassword(String value) {
    _password = value.trim();

    if (_password.isEmpty) {
      setState(() {
        _strength = 0;  
      });
    } else if (_password.length < 6) {
      setState(() {
        _strength = 1 / 4;  
      });
    } else if (_password.length < 8) {
      setState(() {
        _strength = 2 / 4;
        
      });
    } else {
      if (!letterReg.hasMatch(_password) || !numReg.hasMatch(_password) || !special.hasMatch(_password)) {
        setState(() {
          _strength = 3 / 4;  
        });
      } else {
        // Password length >= 8
        // Password contains both letter and digit characters
        setState(() {
          _strength = 1;
          
        });
      }
    }
  }
  // ignore: non_constant_identifier_names
  LoginForm(){
    return  Container(
      //color: Colors.pink[200],
      padding: EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/images/LoginImage.png',
          height: 225,
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
          child: Column(
            children: [
              // SizedBox(
              //   child: Image.asset('assets/images/courier_login.gif',
              //    height: 150,

              //   fit: BoxFit.cover,
              //   // width: MediaQuery.of(context).size.width,
              //   )
              //   ),
                // SizedBox(
                //   height: 20,
                // ),
              TextFormField(
                
                controller: uEmail,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)) ),
                  label: Text('Email')
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: uPassword,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                     ),
                  label: Text('Password')
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.pink[400],
                 borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                margin: const EdgeInsets.all(15.0),
                height: MediaQuery.of(context).size.height/14.5,
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                  onPressed: () async{
                     bool done = await signInWithEmailAndPassword(email: uEmail.text,password: uPassword.text);
                     if(done){
                      Navigator.pushNamed(context, 'home_page');
                     }else{
                      print('LOl');
                     }
                  },
                   child: "Login".text.size(20).color(Colors.white).make()
                   ),
              ),
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      height: 8,
                      color: Colors.pink,
                    ),
                  ),
                  "   OR   ".text.bold.make(),
                  Expanded(
                    child: Divider(
                      color: Colors.pink,
                      thickness: 2,
                      height: 8,
                    ),
                  ),

                ],
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     color: Color.fromARGB(255, 213, 205, 208),
              //    borderRadius: BorderRadius.all(Radius.circular(10))
              //   ),
              //   margin: const EdgeInsets.only(top:15.0,bottom: 5.0),
              //   height: MediaQuery.of(context).size.height/16.5,
              //   width: MediaQuery.of(context).size.width/
              //   1.4,
              //   child: TextButton(
              //     onPressed: () async{
              //       await FirebaseServices().signInWithGoogle();
              //       Navigator.pushNamed(context, 'home_page');
              //     },
              //      child: Row(
              //        // ignore: prefer_const_literals_to_create_immutables
              //        children: [
              //         Padding(
              //           padding: const EdgeInsets.only(left:10.0),
              //           child: Image(image: AssetImage('assets/images/google_icon.png')),
              //         ),
              //         // SizedBox(width: 20,),
              //         //  Padding(
              //         //    padding:  EdgeInsets.only(left:25.0),
              //         //    child: Text(
              //         //     'Login With Google',
              //         //     style: TextStyle(
              //         //       color: Colors.black
              //         //     ),
              //         //     ),
              //         //  ),
              //        ],
              //      )
              //      ),
              // ),
              // Container(
              //   decoration: BoxDecoration(
              //     color: Color.fromARGB(255, 213, 205, 208),
              //    borderRadius: BorderRadius.all(Radius.circular(10))
              //   ),
              //   margin: const EdgeInsets.only(top:15.0,bottom: 5.0),
              //   height: MediaQuery.of(context).size.height/16.5,
              //   width: MediaQuery.of(context).size.width/1.4,
              //   child: TextButton(
              //     onPressed: (){
              //       //Navigator.pushNamed(context, '');
              //     },
              //      child: Row(
              //        // ignore: prefer_const_literals_to_create_immutables
              //        children: [
              //         Padding(
              //           padding: const EdgeInsets.only(left:10.0),
              //           child: Image(image: AssetImage('assets/images/facebook_icon.png')),
              //         ),
              //         SizedBox(width: 20,),
              //          Padding(
              //            padding:  EdgeInsets.only(left:25.0),
              //            child: Text(
              //             'Login With FaceBook',
              //             style: TextStyle(
              //               color: Colors.black
              //             ),
              //             ),
              //          ),
              //        ],
              //      )
              //      ),
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(onTap: () async{
                    await FirebaseServices().signInWithGoogle();
                    Navigator.pushNamed(context, "home_page");
                  },
                    child: Container(
                      height: 70,
                      width:70 ,
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        
                      borderRadius: BorderRadius.all(Radius.circular(30))
                       
                      ),
                      child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Image.asset("assets/images/google_icon.png"),
                                                      
                            ),
                          ),
                  ),

                        Container(
                    height: 70,
                    width:70 ,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      
                    borderRadius: BorderRadius.all(Radius.circular(30))
                     
                    ),
                    child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Image.asset("assets/images/facebook_icon.png"),
                                                    
                          ),
                        ),
                ],
              )

              // Container(
              //   decoration: BoxDecoration(
              //     color: Color.fromARGB(255, 213, 205, 208),
              //    borderRadius: BorderRadius.all(Radius.circular(10))
              //   ),
              //   margin: const EdgeInsets.only(top:15.0,bottom: 5.0),
              //   height: MediaQuery.of(context).size.height/16.5,
              //   width: MediaQuery.of(context).size.width/1.4,
              //   child: TextButton(
              //     onPressed: (){
              //       //Navigator.pushNamed(context, '');
              //     },
              //      child: Row(
              //        // ignore: prefer_const_literals_to_create_immutables
              //        children: [
              //         Padding(
              //           padding: const EdgeInsets.only(left:10.0),
              //           child: Image(image: AssetImage('assets/images/google_icon.png')),
              //         ),
              //         SizedBox(width: 20,),
              //          Padding(
              //            padding:  EdgeInsets.only(left:25.0),
              //            child: Text(
              //             'Login With Mobile',
              //             style: TextStyle(
              //               color: Colors.black
              //             ),
              //             ),
              //          ),
              //        ],
              //      )
              //      ),
              // ),
            ],
          ), 
          
          ),
        ],
      ),
    ); 
    }

    SignUpForm(){
        
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
            Form(
            key: _signUpFormKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return 'Please Enter Your Name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)) ),
                          label: Text('First Name'),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return 'Please Enter Last Name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)) ),
                          label: Text('Last Name'),
                        ),
                      ),
                    ),
      
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return 'Please Enter Mobile Number';
                          }else if(value.length!=10){
                            return 'Please Enter Valid Mobile Number';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)) ),
                          label: Text('Phone Number'),
                        ),
                      ),
                 SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                          if(value == null || value.isEmpty){
                            return 'Please Enter Your Email';
                          }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)){
                            return 'Please Enter Valid Email Address';
                          }
                          return null;
                        },
                  controller: uEmail,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)) ),
                          label: Text('Email'),
                        ),
                      ),
               SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                          if(value == null || value.isEmpty){
                            return 'Please Enter Password';
                          }else if(_strength!=1){
                            return 'Please Enter Valid Password';
                          }
                          return null;
                        },
                        obscureText: true,
                  controller: uPassword,
                  onChanged: (value) => _checkPassword(value),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)) ),
                          label: Text('Password'),
                        ),
                      ),
                  SizedBox(
                    height: 10,
                  ),
                LinearProgressIndicator(
                  value: _strength,
                    
                  backgroundColor: Color.fromARGB(60, 87, 114, 100),
                    color: _strength <= 1 / 4
                            ? Colors.red
                            : _strength == 2 / 4
                            ? Colors.yellow
                            : _strength == 3 / 4
                            ? Colors.blue
                            : Colors.green,
                      minHeight: 10,
            ),
            
                 SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: cPassword,
                  validator: (value) {
                          if(value == null || value.isEmpty ){
                            return 'Please Enter Password';
                          }else if(uPassword.text != cPassword.text){
                            return 'Password No Matching...Please Check';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)) ),
                          label: Text('Confirm Password'),
                        ),
                      ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.pink[400],
                   borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  margin: const EdgeInsets.all(15.0),
                  height: MediaQuery.of(context).size.height/14.5,
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () async{
                      if(_signUpFormKey.currentState!.validate()){
                           isValidateForm = await createUserWithEmailAndPassword(
                        email:uEmail.text,
                        password: uPassword.text
                      );
                      }else{
                        isValidateForm = false;
                      }
                      if(isValidateForm){
                        setState(() {
                          intialIndex = 0;
                        });
                      }
                      // }else if(isValidateForm.text == 'The email address is already in use by another account.'){
                      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Opps!! User Already Exist Try to Login')));
                      // }
                      else{
                         // ignore: use_build_context_synchronously
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something Went Wrong!')));
                      }
                    },
                     child: Text(
                      'SignUp',
                      style: TextStyle(
                        color: Colors.white
                      ),
                      )
                     ),
                ),
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        height: 10,
                        color: dgdarkpink,
                      ),
                    ),
                    Text('   OR   '),
                    Expanded(
                      child: Divider(
                        color: dgdarkpink,
                        thickness: 2,
                        height: 10,
                      ),
                    ),
                    
      
                  ],
                  
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     color: Color.fromARGB(255, 213, 205, 208),
                //    borderRadius: BorderRadius.all(Radius.circular(10))
                //   ),
                //   margin: const EdgeInsets.only(top:15.0,bottom: 5.0),
                //   height: MediaQuery.of(context).size.height/16.5,
                //   width: MediaQuery.of(context).size.width/1.4,
                //   child: TextButton(
                //     onPressed: (){
                //       //Navigator.pushNamed(context, '');
                //     },
                //      child: Row(
                //        // ignore: prefer_const_literals_to_create_immutables
                //        children: [
                //         Padding(
                //           padding: const EdgeInsets.only(left:10.0),
                //           child: Image(image: AssetImage('assets/images/google_icon.png')),
                //         ),
                //         SizedBox(width: 20,),
                //          Padding(
                //            padding:  EdgeInsets.only(left:25.0),
                //            child: Text(
                //             'SignUp With Google',
                //             style: TextStyle(
                //               color: Colors.black
                //             ),
                //             ),
                //          ),
                //        ],
                //      )
                //      ),
                // ),
                // Container(
                //   decoration: BoxDecoration(
                //     color: Color.fromARGB(255, 213, 205, 208),
                //    borderRadius: BorderRadius.all(Radius.circular(10))
                //   ),
                //   margin: const EdgeInsets.only(top:15.0,bottom: 5.0),
                //   height: MediaQuery.of(context).size.height/16.5,
                //   width: MediaQuery.of(context).size.width/1.4,
                //   child: TextButton(
                //     onPressed: (){
                //       //sendDataToCloud();
                //     },
                //      child: Row(
                //        // ignore: prefer_const_literals_to_create_immutables
                //        children: [
                //         Padding(
                //           padding: const EdgeInsets.only(left:10.0),
                //           child: Image(image: AssetImage('assets/images/facebook_icon.png')),
                //         ),
                //         SizedBox(width: 20,),
                //          Padding(
                //            padding:  EdgeInsets.only(left:25.0),
                //            child: Text(
                //             'SignUp With FaceBook',
                //             style: TextStyle(
                //               color: Colors.black
                //             ),
                //             ),
                //          ),
                //        ],
                //      )
                //      ),
                // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(onTap: () async{
                    await FirebaseServices().signInWithGoogle();
                    setState(() {
                      intialIndex=0;
                    });
                  },
                    child: Container(
                      height: 70,
                      width:70 ,
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        
                      borderRadius: BorderRadius.all(Radius.circular(30))
                       
                      ),
                      child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Image.asset("assets/images/google_icon.png"),
                                                      
                            ),
                          ),
                  ),

                        Container(
                    height: 70,
                    width:70 ,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      
                    borderRadius: BorderRadius.all(Radius.circular(30))
                     
                    ),
                    child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Image.asset("assets/images/facebook_icon.png"),
                                                    
                          ),
                        ),
                ],
              )
              ],
            ), 
            
            ),
            ],
          ),
        ),
      ); 
    }
    
}


