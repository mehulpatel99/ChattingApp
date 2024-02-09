// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  DocumentSnapshot userdocumentsnapshot;
  ChatScreen({super.key, required this.userdocumentsnapshot});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

TextEditingController messagebox = TextEditingController();

class _ChatScreenState extends State<ChatScreen> {
  Future<void> sendmessage() async {
    await FirebaseFirestore.instance.collection('messages').add({
      'sender': FirebaseAuth.instance.currentUser!.uid,
      'receiver': widget.userdocumentsnapshot.id,
      'message': messagebox.text.toString(),
      'timestamp': DateTime.now()
    });
    setState(() {
      messagebox.clear();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('sender : ${FirebaseAuth.instance.currentUser!.uid}');
    print('receiver : ${widget.userdocumentsnapshot.id}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      // appBar: AppBar(
      //   backgroundColor: Color.fromARGB(255, 104, 73, 73),
      //   title: Text(
      //     '${widget.userdocumentsnapshot['username']}',
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   // iconTheme: IconThemeData(color: Color.fromARGB(255, 104, 73, 73)),
      // ),
      body: Column(
        children: [
          Container(
             decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 55, 148, 105),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 5,
                            offset: Offset(3, 3))
                      ]),
            height: 100,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 30,left: 15),
              child: ListTile(
                title: Text('${widget.userdocumentsnapshot['username']}',style: TextStyle(fontSize: 25,color: Colors.white),),
                leading: CircleAvatar(child: Icon(Icons.person),),
                subtitle: Text('Online',style: TextStyle(color: Colors.white),),
                trailing: IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.arrow_circle_right_rounded,color: Colors.white,size: 40,)),
              ),
            ),
          ),
          Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('messages')
                      .where('receiver',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .where('sender',
                          isEqualTo: widget.userdocumentsnapshot!.id)
                      .orderBy('timestamp')
                      .snapshots(),
                  builder: (context, senderSnapshot) {
                    if (senderSnapshot.hasData) {
                      var sendermessage = senderSnapshot.data!.docs;
                      return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('messages')
                              .where('reciever',
                                  isEqualTo: widget.userdocumentsnapshot.id)
                              .where('sender',
                                  isEqualTo:
                                      FirebaseAuth.instance.currentUser!.uid)
                              .orderBy('timestamp')
                              .snapshots(),
                          builder: (context, receiverSnapshot) {
                            if (receiverSnapshot.hasData) {
                              var receiverMessage = receiverSnapshot.data!.docs;
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          });
                    }
                    return Center(
                      child: CupertinoActivityIndicator(),
                    );
                  })),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    // color: Colors.white,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 5,
                              offset: Offset(3, 3))
                        ]),
                    child: TextField(
                      controller: messagebox,
                      decoration: InputDecoration(
                          hintText: 'Type here your message...',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.teal)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 5,
                            offset: Offset(3, 3))
                      ]),
                  child: IconButton(
                      onPressed: () {
                        sendmessage();
                      },
                      icon: Icon(Icons.send)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
