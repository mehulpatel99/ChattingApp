
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebaseproject/Project/MyCustomButton.dart';
import 'package:firebaseproject/Project/MyTextField.dart';
import 'package:firebaseproject/Project/forgot_pass.dart';
import 'package:firebaseproject/Project/home_screen.dart';
import 'package:firebaseproject/Project/signup.dart';
import 'package:flutter/material.dart';


class SignIN extends StatefulWidget {
  const SignIN({super.key});

  @override
  State<SignIN> createState() => _SignINState();
}

class _SignINState extends State<SignIN> {
  // TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
 
 void myshowSnackBar(){
  
  var snakbar = SnackBar(content: Text("Invalid email or password"),backgroundColor: Colors.teal, duration:Duration(seconds: 2));
 ScaffoldMessenger.of(context).showSnackBar(snakbar);
 }


 Future<void> userlogin(String? email,String? password)async{
  try{
 UserCredential? usercredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!);
  User? user = usercredential.user;
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (conntext)=>myhome(users: user,)));
  }catch(e){
      myshowSnackBar();
  }
 
 }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: 

      Stack(children: [
       
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
            height: MediaQuery.of(context).size.height*5,
            width: 500,
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment:  MainAxisAlignment.center,
                children: [
                    // Image.network('https://banner2.cleanpng.com/20180426/lwq/kisspng-computer-icons-login-management-user-5ae155f3386149.6695613615247170432309.jpg',height: 200,width: 300,),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Center(
                        child: Text(
                      "Welcome",
                      style: TextStyle(fontSize: 36, color: Color.fromARGB(221, 209, 16, 3)),
                    )),
                  ),
                  MyTextField(
                    controller: _emailController,
                    lable: "Email",
                    hintText: "Enter Email",
                  ),
                  MyTextField(
                    controller: _passwordController,
                    lable: "Password",
                    hintText: "Enter Password",
                    // color: Colors.amber,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      InkWell(
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>ForgotPass()));
                          },
                          child: Text('Forgot? Password',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black87),))
                    ],),
                  ),
                    SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      userlogin(_emailController.text.toString(), _passwordController.text.toString());
                    },
                    child:   Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xffB81736),Color(0xff281537)]),borderRadius: BorderRadius.circular(20),boxShadow: [BoxShadow(color: Colors.black,offset: Offset(5, 5),blurRadius: 3)]),
            child: Center(child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),))
          ),
        ),
        SizedBox(height: 20,),
                  InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(),));
                      },
                      child: Text(
                        "Don't have account? Signup",
                        style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 116, 61, 125)),
                      )),
                    
                      
                ],
              ),
            ),
               
                ),
        ),
   
      ],)
      
   
    );
  }
}
