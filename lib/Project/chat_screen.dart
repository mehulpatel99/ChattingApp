

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
    await FirebaseFirestore.instance.collection('MessagesUser').add({
      'Sender': FirebaseAuth.instance.currentUser!.uid,
      'Receiver': widget.userdocumentsnapshot.id,
      'Message': messagebox.text.toString(),
      'Timestamp': DateTime.now()
    });
    setState(() {
      messagebox.clear();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Sender : ${FirebaseAuth.instance.currentUser!.uid}');
    print('Receiver : ${widget.userdocumentsnapshot.id}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
                      color: Colors.black, blurRadius: 5, offset: Offset(3, 3))
                ]),
            height: 100,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 15),
              child: ListTile(
                title: Text(
                  '${widget.userdocumentsnapshot['username']}',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                leading: CircleAvatar(
                  child: Icon(Icons.person),
                ),
                subtitle: Text(
                  'offline',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_circle_right_rounded,
                      color: Colors.white,
                      size: 40,
                    )),
              ),
            ),
          ),
          Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('MessagesUser')
                      .where('Receiver',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .where('Sender',
                          isEqualTo: widget.userdocumentsnapshot.id)
                      .snapshots(),
                  builder: (context, senderSnapshot) {
                    if (senderSnapshot.hasData) {
                      var senderSms = senderSnapshot.data!.docs;
                      return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('MessagesUser')
                            .where('Receiver',
                                isEqualTo: widget.userdocumentsnapshot.id)
                            .where('Sender',
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (context, receiverSnapshot) {
                          var receiverSms = receiverSnapshot.data!.docs;
                          var allMessages = senderSms + receiverSms;
                          allMessages.sort((a, b) =>
                              (a['Timestamp'] as Timestamp)
                                  .compareTo(b['Timestamp'] as Timestamp));
                              if(receiverSnapshot.hasData){
                                 return ListView.builder(
                            itemCount: allMessages.length,
                            itemBuilder: (context, index) {
                              var message = allMessages[index];
                              String SenderId = message['Sender'];
                              bool IsCurrentUser = SenderId ==
                                  FirebaseAuth.instance.currentUser!.uid;
                              return Padding(
                                padding: EdgeInsets.all(12),
                                child: Row(
                                  mainAxisAlignment: IsCurrentUser?MainAxisAlignment.end:MainAxisAlignment.start,
                                  children: [
                                   if(!IsCurrentUser)
                                   Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.grey[500],
                                        child: Text(widget.userdocumentsnapshot['username'][0].toUpperCase()),),
                                        
                                    ],
                                   )else
                                   SizedBox(width: 40,),

                                   SizedBox(width: 10,),
                                   Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: IsCurrentUser? Color.fromARGB(255, 186, 245, 188):Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(message['Message'],style: TextStyle(color: Colors.black,fontSize: 15
                                      ),),
                                    )),
                                  ],
                                ),
                              );
                            },
                          );
                          
                              }

                         return Center(
                      child: CircularProgressIndicator(),
                    );
                        }
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  )),
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
