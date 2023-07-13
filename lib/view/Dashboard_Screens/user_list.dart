// ignore_for_file: camel_case_types, must_be_immutable, unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/view/Dashboard_Screens/chat_Screen.dart';



class users_list_screen extends StatefulWidget {

  users_list_screen({ Key? key}) : super(key: key);

  @override
  State<users_list_screen> createState() => _users_list_screenState();
}

class _users_list_screenState extends State<users_list_screen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String chatroomid(String user1, user2) {
    if (user1.toLowerCase().codeUnits[0] > user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }
  final emailcontroller = TextEditingController();
  final emailfocusnode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child:  StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: InkWell(
                      onTap: () {
                        final roomid = chatroomid(_auth.currentUser!.uid,
                            snapshot.data!.docs[index]['uid'].toString());

                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return chat_screen(
                              chatid:
                              snapshot.data!.docs[index]['uid'].toString(),
                              username: snapshot.data!.docs[index]['username']
                                  .toString(),
                              imageurl: snapshot.data!.docs[index]['prfile']
                                  .toString(),
                              chatroomID: roomid,
                              onlinestatus: snapshot
                                  .data!.docs[index]['onlinestatues']
                                  .toString(),
                            );
                          },
                        ));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white60,
                          backgroundImage: NetworkImage(
                              snapshot.data!.docs[index]['prfile'].toString()),
                        ),
                        title: Text(
                            snapshot.data!.docs[index]['username'].toString()),
                        subtitle: Text(
                            snapshot.data!.docs[index]['email'].toString()),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        )

    );
  }
}
