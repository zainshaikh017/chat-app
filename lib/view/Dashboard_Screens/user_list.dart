// ignore_for_file: camel_case_types, must_be_immutable, unrelated_type_equality_checks, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chat_Screen.dart';



class users_list_screen extends StatefulWidget {

  const users_list_screen({ Key? key}) : super(key: key);

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
  // final emailcontroller = TextEditingController();
  // final emailfocusnode = FocusNode();

  void sffb( String Query)async{
    final result=await FirebaseFirestore.instance.collection("users").where(
      'email' , isEqualTo: Query
    ).get();

    setState(() {
      searchresult=result.docs.map((e) => e.data()).toList();
    });

  }
  List searchresult=[];
  final search=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            TextFormField(
              controller:search ,
              decoration: InputDecoration(
                hintText: "Enter Email"
              ),
              onChanged: (Query) {
              sffb(Query);
              },
            ),

      Expanded(
        child: ListView.builder(
          itemCount:searchresult.length,
          itemBuilder: (context, index) {
            return Card(
              child: InkWell(
                onTap: () {
                  final roomid = chatroomid(_auth.currentUser!.uid,
                      searchresult[index]['uid'].toString());

                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return chat_screen(
                        chatid:
                        searchresult[index]['uid'].toString(),
                        username: searchresult[index]['username']
                            .toString(),
                        imageurl: searchresult[index]['prfile']
                            .toString(),
                        chatroomID: roomid,
                        onlinestatus: searchresult[index]['onlinestatues']
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
                        searchresult[index]['prfile'].toString()),
                  ),
                  title: Text(
                      searchresult[index]['username'].toString()),
                  subtitle: Text(
                      searchresult[index]['email'].toString()),
                ),
              ),
            );
          },),
      ),
            // StreamBuilder(
            //     stream:FirebaseFirestore.instance.collection("users").where(
            //         "email",isEqualTo: search.text
            //     ),
            //     builder: (context, snapshot) {
            //       return Center();
            //       );
            //     },
            //   )
            //
            // StreamBuilder(
            //   stream: FirebaseFirestore.instance.collection("users").where(
            //     "email",isEqualTo: search.text,
            //   ).snapshots(),
            //   builder: (context, snapshot) {
            //     if(snapshot.connectionState== ConnectionState.active){
            //       if(snapshot.hasData){
            //        // QuerySnapshot key = snapshot.data as QuerySnapshot;
            //        //  final title= snapshot.data!.toString();
            //         if(search.text.isEmpty){
            //           return Text("all");
            //         }
            //         else if(
            //         title.toLowerCase().contains(search.text.toLowerCase().toString())){
            //
            //           return ListView.builder(
            //             itemCount:searchresult.length,
            //             itemBuilder: (context, index) {
            //             return ListTile(
            //               title: Text("hello"),
            //             );
            //           },);
            //         }
            //         else{
            //           return Container(
            //             color: Colors.red,
            //           );
            //         }
            //
            //
            //       }
            //       else if(snapshot.hasError){
            //         return Text("an error occured");
            //       }
            //       else{
            //         return Text("no result found!");
            //       }
            //
            //
            //
            //     }
            //     else{
            //       return Center(child: CircularProgressIndicator());
            //     }
            // },)
          ],
        )

    );
  }
}
