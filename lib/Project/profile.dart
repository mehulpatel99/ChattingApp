import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproject/Project/MyCustomButton.dart';
import 'package:firebaseproject/Project/MyTextField.dart';
import 'package:firebaseproject/Project/home_screen.dart';
import 'package:flutter/material.dart';

class profile extends StatefulWidget {
  User? user;
   profile({super.key,required this.user});

  @override
  State<profile> createState() => _profileState();
}
TextEditingController namecon2 = TextEditingController();
TextEditingController emailcon2 = TextEditingController();

class _profileState extends State<profile> {
  Future<void>userget()async{
    var doccument = await FirebaseFirestore.instance.collection('users').doc(widget.user!.uid).get();
    setState(() {
      namecon2.text=doccument['username'];
      emailcon2.text=doccument['email'];
      
    });
  }





 void update()async{
  User? user = await FirebaseAuth.instance.currentUser;

  // user!.updateEmail(newEmail)
  await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
    'username':namecon2.text.toString(),
    'email':emailcon2.text.toString(),
    
  });
  Navigator.pop(context);
  Navigator.push(context, MaterialPageRoute(builder: (context)=>myhome(users: user)));
 }

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(title: Text('Profile'),backgroundColor: Colors.blue,),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          MyTextField(controller: namecon2, lable: 'Name', hintText: 'Enter your  Name'),
           MyTextField(controller: emailcon2, lable: 'user email', hintText: 'Enter your  email'),
           InkWell(
            onTap: (){
              update();
            },
            child: MyCustomButton(textvalue: 'Update', colorname: Colors.teal))
        ],),
      ),
    );
  }
}

