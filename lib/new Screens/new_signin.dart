import 'package:flutter/material.dart';

class NewSignin extends StatefulWidget {
  const NewSignin({super.key});

  @override
  State<NewSignin> createState() => _NewSigninState();
}

class _NewSigninState extends State<NewSignin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xffB81736),Color(0xff281537)])),
            child: Padding(
              padding: const EdgeInsets.only(top:60.0,left: 22),
              child: Text("Hello\nSign in!",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
            ),
          ),
       
       
        Padding(
          padding: const EdgeInsets.only(top: 200),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))),
          ),
        )
        ],
      ),
    );
  }
}