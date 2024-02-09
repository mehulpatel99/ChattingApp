import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseproject/Project/home_screen.dart';
import 'package:firebaseproject/Project/signin.dart';
import 'package:firebaseproject/Project/signup.dart';
import 'package:firebaseproject/Project/splash.dart';
import 'package:firebaseproject/firebase_options.dart';
import 'package:firebaseproject/new%20Screens/new_signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(myapp());
}
class myapp extends StatelessWidget {
  const myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: mysplash (),
    );
  }
}
