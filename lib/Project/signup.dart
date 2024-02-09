import 'package:firebaseproject/Project/MyCustomButton.dart';
import 'package:firebaseproject/Project/MyTextField.dart';
import 'package:firebaseproject/Project/signin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String? profilePicUrl =
      "https://cdn3d.iconscout.com/3d/premium/thumb/profile-8260859-6581822.png?f=webp";

  Future<void> registerUser(
      String? username, String? email, String? password) async {
    // it will store data in authentication
    UserCredential usercredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);

    User? user = usercredential.user;

    await FirebaseFirestore.instance.collection("users").doc(user!.uid).set(
        {"email": email, "username": username, "profilepic": profilePicUrl});
    print("---------------------------------->$user");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.black,
        body: Stack(
      children: [

        Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xffB81736),Color(0xff281537)])),
            child: Padding(
              padding: const EdgeInsets.only(top:60.0,left: 22),
              child: Text("Hello\nSign Up!",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
            ),
          ),
       
        Padding(
          padding: const EdgeInsets.only(top: 200),
          child:  Container(
              height: MediaQuery.of(context).size.height *0.78,
                 decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))),

              child: SingleChildScrollView(
            child:
              Column(
                children: [
                 
                  // Image.network(
                  //   "$profilePicUrl",
                   
                  //   height: 100,
                  //   width: 100,
                  // ),
               Image.network('https://thumbs.dreamstime.com/b/businessman-avatar-image-beard-hairstyle-male-profile-vector-illustration-178545831.jpg',height: 100,width: 100,),
                  SizedBox(height: 20,),
                  
                  MyTextField(
                    controller: _usernameController,
                    lable: "Username",
                    hintText: "Enter Username",
                  ),
                  MyTextField(
                    
                    controller: _emailController,
                    lable: "Email",
                    hintText: "Enter Email",
                  ),
                  MyTextField(
                    myicon: Icon(Icons.password,),
                    controller: _passwordController,
                    lable: "Password",
                    hintText: "Enter Password",
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                      onTap: () {
                        registerUser(
                            _usernameController.text.toString(),
                            _emailController.text.toString(),
                            _passwordController.text.toString());
                        setState(() {
                          _usernameController.clear();
                          _emailController.clear();
                          _passwordController.clear();
                        });
                      },
                      child: Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xffB81736),Color(0xff281537)]),borderRadius: BorderRadius.circular(20),boxShadow: [BoxShadow(color: Colors.black,offset: Offset(5, 5),blurRadius: 3)]),
            child: Center(child: Text('Signup',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),))
          ),),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignIN()));
                      },
                      child: Text(
                        "Already Register ? Click Here for Login",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 116, 61, 125),
                            shadows: [
                              Shadow(color: Colors.black, blurRadius: 3)
                            ]),
                      ))
                ],
              ),
            ),
          ),
        ),
     
     
      ],
    ));
  }
}
