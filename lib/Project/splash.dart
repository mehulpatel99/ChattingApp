// import 'dart:js';

import 'package:firebaseproject/Project/signin.dart';
import 'package:firebaseproject/Project/signup.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class mysplash extends StatefulWidget {
  const mysplash({super.key});

  @override
  State<mysplash> createState() => _mysplashState();
}
 void mychange(BuildContext context)async{
  await Future.delayed(Duration(seconds: 5));
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIN()));
 }
class _mysplashState extends State<mysplash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mychange(context as BuildContext);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Lottie.network('https://lottie.host/1efa62b9-354c-4ded-93bf-8d7374e9281a/u8nHH7GKx6.json'),),
    );
  }
}