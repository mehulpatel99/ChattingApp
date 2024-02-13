import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseproject/Project/MyCustomButton.dart';
import 'package:firebaseproject/Project/MyTextField.dart';
import 'package:firebaseproject/Project/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class profile extends StatefulWidget {
  User? user;
  profile({super.key, required this.user});

  @override
  State<profile> createState() => _profileState();
}

TextEditingController namecon2 = TextEditingController();
TextEditingController emailcon2 = TextEditingController();

class _profileState extends State<profile> {
  var currentimage='';
  Future<void> userget() async {
    var doccument = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user!.uid)
        .get();
    setState(() {
      namecon2.text = doccument['username'];
      emailcon2.text = doccument['email'];
       currentimage = doccument['profilepic'];
    });
  }

  void update() async {
    User? user = await FirebaseAuth.instance.currentUser;

    // user!.updateEmail(newEmail)
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
      'username': namecon2.text.toString(),
      'email': emailcon2.text.toString(),
    });
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => myhome(users: user)));
  }

//image picker-----------------------------------------------------------
  File? _pic;
  // String? _myusername;
  ImagePicker _picker = ImagePicker();

  void selectpic() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pic = File(pickedFile.path);
      });
    }
  }

  // File? picker2;
  ImagePicker _picker2 =ImagePicker();
  void selectpic2()async{
    final pickedfile2 = await _picker2.pickImage(source: ImageSource.camera);
    if(pickedfile2 != null){
      setState(() {
        _pic=File(pickedfile2.path);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userget();
  }

  

  //storage profile pic-----------------------------
  Future<void> updateprofile()async{
   if(_pic != null){
    final _storage = await FirebaseStorage.instance;
    final _ref = _storage.ref().child('images').child(DateTime.now().toString());

    final uploadfile = _ref.putFile(_pic!);
    final snapshot = await uploadfile.whenComplete(() => null);
    final d_imageURL = await snapshot.ref.getDownloadURL();
    User? user = await FirebaseAuth.instance.currentUser;

     await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
      'profilepic':d_imageURL,
      'username': namecon2.text.toString(),
      'email': emailcon2.text.toString(),
    });
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => myhome(users: user)));
   }else{
    update();
   }
  }
 
 
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Container(
              alignment: Alignment.bottomRight,
              height: 200,
              width: 200,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(120),image: _pic !=null?DecorationImage(image: FileImage(_pic!),fit: BoxFit.fill): DecorationImage(image: NetworkImage(currentimage),fit: BoxFit.fill)),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(200),color: Color.fromARGB(255, 89, 143, 201)),
              child: IconButton(onPressed: (){
                // selectpic();
                showModalBottomSheet(context: context, builder: (context){
                  return SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text('Select your Profile',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                          Column(
                            children: [
                              IconButton(onPressed: (){
                                selectpic2();
                                 Navigator.of(context).pop();
                              }, icon: Icon(Icons.camera_alt_sharp,size: 50,)),
                              Text('Camera'),
                            ],
                          ),
                          
                           Column(
                             children: [
                               IconButton(onPressed: (){
                                selectpic();
                                Navigator.of(context).pop();
                               }, icon: Icon(Icons.photo,size: 50,)),
                                Text('Gallery'),
                             ],
                           ),
                        ],),
                      ],
                    ),
                  );
                });
              }, icon: Icon(Icons.camera_alt,size: 30,color: Colors.white,))),
             ),
              Text('Profile',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              // ElevatedButton(onPressed: (){
              //   selectpic();
              // }, child: Text('Pick image')),
              // MyTextField(
              //     controller: namecon2,
              //       icon2: Icon(Icons.edit),
              //     myicon: Icon(Icons.person),
              //     lable: 'Name',
              //     hintText: 'Enter your  Name'),
              TextField(
                controller: namecon2,
                decoration: InputDecoration(hintText: 'Enter your name',label: Text('Name'),prefixIcon: Icon(Icons.person),suffixIcon: Icon(Icons.edit,color: Color.fromARGB(255, 40, 108, 163),)),
              ),
               TextField(
                controller: emailcon2,
                readOnly: true,
                decoration: InputDecoration(hintText: 'Enter your name',label: Text('Email'),prefixIcon: Icon(Icons.email),suffixIcon: Icon(Icons.edit,color:Color.fromARGB(255, 40, 108, 163),)),
              ),
              TextField(
                
                // controller: ,
                readOnly: true,
                decoration: InputDecoration(hintText: '9929403892',prefixIcon: Icon(Icons.phone),suffixIcon: Icon(Icons.edit,color:Color.fromARGB(255, 40, 108, 163),)),
              ),
              // MyTextField(
              //     controller: emailcon2,
              //     myicon: Icon(Icons.email),
              //     icon2: Icon(Icons.edit),
              //     lable: 'user email',
              //     hintText: 'Enter your  email'),
            
             SizedBox(height: 20,),
              InkWell(
                  onTap: () {
                    // update();
                    updateprofile();
                  },
                  child:
                      MyCustomButton(textvalue: 'Update', colorname: Colors.teal))
            ],
          ),
        ),
      ),
    );
  }
}
