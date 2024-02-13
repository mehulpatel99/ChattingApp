import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseproject/Project/chat_screen.dart';
import 'package:firebaseproject/Project/profile.dart';
import 'package:firebaseproject/Project/signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class myhome extends StatefulWidget {
  User? users;
  myhome({super.key, required this.users});

  @override
  State<myhome> createState() => _myhomeState();
}

class _myhomeState extends State<myhome> {
  bool isvisible=true;
  // var imagefetch = '';





  String? username = '';
  String? e_mail = '';
  void getuserdata() async {
    var doccument = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.users!.uid)
        .get();
    setState(() {
      username = doccument['username'];
      e_mail = doccument['email'];
      // imagefetch = doccument['profilepic'];
    });
  }

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
      // filteredlist = List.from(mainlist!);
  }

  List<DocumentSnapshot>? mainlist ;
  List<DocumentSnapshot>? filteredlist ;
  void searchdata(String? keyword) async {
    setState(() {
      if (keyword!.isEmpty) {
        filteredlist = List.from(mainlist!);
      } else {
        filteredlist = mainlist
            ?.where((element) => element['username']
                .toLowerCase()
                .contains(keyword.toLowerCase()))
            .toList();
      }
    });

    print(keyword);
  }
 
 
  @override
  Widget build(BuildContext context) {
    CollectionReference myuser = FirebaseFirestore.instance.collection('users');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(Icons.person,color: Colors.white,),
        title: Text('Hi! $username',style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 11, 123, 74),
        actions: [
          // IconButton(
          //     onPressed: () {
          //       Get.changeTheme(ThemeData.dark());
          //     },
          //     icon: Icon(Icons.change_circle)),
          // IconButton(
          //     onPressed: () {
          //       Get.changeTheme(ThemeData.light());
          //     },
          //     icon: Icon(Icons.change_circle_outlined)),
          PopupMenuButton(
              icon: Icon(Icons.more_vert,color: Colors.white,),
              color: const Color.fromARGB(255, 137, 232, 223),
              onSelected: (value) {
                if (value == "Profile") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => profile(
                                user: widget.users,
                              )));
                } else if (value == "Logout") {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignIN()));
                }
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(value: "Profile", child: Text('Profile')),
                  PopupMenuItem(value: "Logout", child: Text('Logout')),
                ];
              })
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: (value) {
                searchdata(value);
              },
              decoration: InputDecoration(
                  hintText: 'Type here...',
                  hintStyle: TextStyle(color: Colors.black38),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.teal),
            ),
          ),
          Expanded(
              child: StreamBuilder(
                  stream: myuser.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // var data = snapshot.data!.docs;
                      // var data = snapshot.data!.docs.where((element) => element.id!=widget.users!.uid).toList();
                      mainlist = snapshot.data!.docs
                          .where((element) => element.id != widget.users!.uid)
                          .toList();

                      filteredlist ??= List.from(mainlist!);
                      return ListView.builder(
                          itemCount: filteredlist!.length,
                          itemBuilder: (context, index) {
                            return
                            // return Padding(
                            //   padding: const EdgeInsets.only(
                            //       left: 10, right: 10, top: 15),
                            //   child: Container(
                            //     decoration: BoxDecoration(color: Colors.white,boxShadow: [
                            //       BoxShadow(
                            //           color: Colors.black,
                            //           offset: Offset(3, 3),
                            //           blurRadius: 3)
                            //     ]),
                               
                                  //  elevation: 10,
                                  // color: Colors.white,
                                   Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.push(context,MaterialPageRoute(builder: (context)=>ChatScreen(userdocumentsnapshot: filteredlist![index])));
                                      },
                                      leading:    CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(filteredlist?[index]['profilepic']),
                                          
                                        ), 
                                        title:Text( '${filteredlist![index]['username']}', style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800),) ,
                                        trailing: Text('Yesterday'),
                                    subtitle: Text('messages'),
                                    
                                    
                                   
                                  ),
                                );
                            //   ),
                            // );
                          });
                    }
                    return Center(child: CircularProgressIndicator());
                  }))
        ],
      ),
     floatingActionButton: FloatingActionButton(backgroundColor: Color.fromARGB(255, 11, 123, 74),onPressed: (){},child: Icon(Icons.sms,color: Colors.white,)),
    );
  }
}
