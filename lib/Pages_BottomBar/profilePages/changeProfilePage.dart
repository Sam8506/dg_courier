import 'package:flutter/material.dart';

class changeProfilePage extends StatefulWidget {
  const changeProfilePage({Key? key}) : super(key: key);

  @override
  State<changeProfilePage> createState() => _changeProfilePageState();
}

class _changeProfilePageState extends State<changeProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Change Profile'),
        backgroundColor: Colors.pink,

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            
            children: [
              const SizedBox(
                height: 50,
              ),
              const Center(
                child: CircleAvatar(
                 // backgroundImage: 
                  maxRadius: 35,
                ),
              ),
             
              const Padding(
                padding: EdgeInsets.only(top:16.0,bottom: 16.0),
                child: Divider(
                  color: Colors.pink,
                  thickness: 2,
                ),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   padding: EdgeInsets.only(left:4),
              //   alignment: Alignment.topLeft,
              //   child: Text(
              //     'Change Name',
              //     style: TextStyle(
              //       fontWeight: FontWeight.bold
              //     ),
              //     textAlign: TextAlign.start,
              //     ),
              //     ),
              //     SizedBox(
              //       height: 10,
              //     ),
                  
                TextFormField(
                  
                    decoration:const InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)) ),
                      label: Text('Change Name')
                    ),
               ),
                //  Container(
                // padding: EdgeInsets.only(left:4),
                // alignment: Alignment.topLeft,
                // child: Text(
                //   'Change Name',
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold
                //   ),
                //   textAlign: TextAlign.start,
                //   ),
                //   ),
                const SizedBox(
                  height: 15,
                ),
                
               TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)) ),
                    label: Text('Change Address')
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                       ),
                    label: Text('Chnage Mobile Number')
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/1.5,
                  margin: const EdgeInsets.only(top: 200),
                  decoration:  BoxDecoration(
                    color: Colors.pink[400],
                    borderRadius: const BorderRadius.all(Radius.circular(15))                  ),
                  child: TextButton(
                    onPressed: (){
                    
                  }, 
                  child: const Text('Submit',
                  style: TextStyle(
                    color: Colors.white
                  ),
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
