import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproject/Project/MyCustomButton.dart';
import 'package:firebaseproject/Project/MyTextField.dart';
import 'package:flutter/material.dart';
class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

Future<void> resetpass(String? email,BuildContext context)async{
  await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('check your mail')));
}

TextEditingController emailcon = TextEditingController();
class _ForgotPassState extends State<ForgotPass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.teal),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height*5,
            width: 500,
          child: Column(children: [
             Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Center(
                        child: Text(
                      "Forgot Password",
                      style: TextStyle(fontSize: 36, color: Colors.teal),
                    )),
                  ),
                  MyTextField(
                    controller: emailcon,
                    lable: "Email",
                    hintText: "Enter Email",
                  ),
                  InkWell(
                    onTap: (){
                      resetpass(emailcon.text, context);
                      setState(() {
                        emailcon.clear();
                      });
                    },
                    child: MyCustomButton(textvalue: 'Reset', colorname: Colors.teal))
          ],),
        ),
      ),
    );
  }
}