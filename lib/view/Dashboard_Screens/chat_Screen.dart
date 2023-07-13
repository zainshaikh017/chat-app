// ignore_for_file: must_be_immutable, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/Session/session_controlar.dart';
import 'package:tech_media/component/massage_bubble.dart';

class chat_screen extends StatefulWidget {



   chat_screen({Key? key,
     required this.onlinestatus,
     required this.chatroomID,
     required this.chatid,
     required this.username,
     required this.imageurl,
   } ) : super(key: key);
   String onlinestatus;
   String chatroomID;
  String chatid;
  String username;
  String imageurl;
  @override
  State<chat_screen> createState() => _chat_screenState();
}

class _chat_screenState extends State<chat_screen> {

final  FirebaseFirestore _firestore=FirebaseFirestore.instance;


   final massagecontroler=TextEditingController();

   bool isme = true;


   void send()async{

     Map<String , dynamic> messages={
       "sendby":sessionControlar().userid.toString(),
       "msg": massagecontroler.text,
       "time":FieldValue.serverTimestamp(),
     };

     await _firestore.collection("chatroom").doc(widget.chatroomID).collection('chats').add(messages).then((value){
       massagecontroler.clear();
     });

   }









  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(widget.imageurl),
          ),
        ) ,
        title:sessionControlar().userid.toString() == widget.chatid ? const Text('ItsYou') : Text(widget.username),

        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(child: Text(widget.onlinestatus)),
          ),
        ],

      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [



                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('chatroom')
                        .doc(widget.chatroomID)
                        .collection("chats")
                        .orderBy("time",descending: false)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: Text('Loading...'));
                      }

                      if (!snapshot.hasData) {
                        return const Center(child: Text('Document does not exist.'));
                      }

                      return ListView.builder(

                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {

                          return  MessageBubble(
                            sender:snapshot.data!.docs[index]['sendby'].toString(),
                            text:snapshot.data!.docs[index]['msg'].toString() ,
                            isMe:snapshot.data!.docs[index]['sendby'].toString()==sessionControlar().userid ? true :false ,);
                        }

    );
                    },
                  ),







                ],
              ),
            ),
            const Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: massagecontroler,
                        decoration: const InputDecoration(
                            hintText: 'Type a message',

                          )
                        ),
                      ),

                    IconButton(onPressed: (){}, icon: const Icon(Icons.image_outlined)),

                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          send();

                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}