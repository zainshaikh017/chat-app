

// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/Session/session_controlar.dart';
import 'package:tech_media/controller/profile_controlar.dart';
import 'package:tech_media/res/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../utils/routes/route_name.dart';
import '../../utils/utils.dart';

class profile_screen extends StatefulWidget {
  const profile_screen({Key? key}) : super(key: key);

  @override
  State<profile_screen> createState() => _profile_screenState();
}
enum SampleItem { itemOne, itemTwo, itemThree }
class _profile_screenState extends State<profile_screen> {

  String currentuserid = sessionControlar().userid.toString();
  SampleItem? selectedMenu;
  TextEditingController rename=TextEditingController();
  TextEditingController rephone=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
          create: (_) => profile_controlar(),
          child:
              Consumer<profile_controlar>(builder: (context, provider, child) {
            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('uid', isEqualTo: sessionControlar().userid.toString())
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No users found.'));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,

                  itemBuilder: (context, index) {
                    String imageurls=snapshot.data!.docs[index]['prfile'].toString();
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: PopupMenuButton<SampleItem>(

                              initialValue: selectedMenu,
                              // Callback that sets the selected popup menu item.
                              onSelected: (SampleItem item) {
                                setState(() {
                                  selectedMenu = item;
                                });
                              },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
                     PopupMenuItem<SampleItem>(
                       onTap: (){


                       },
                    value: SampleItem.itemOne,
                    child: const Text('Edit'),
                    ),

                     PopupMenuItem<SampleItem>(
                       onTap: ()async{


                         try {
                           User? user = FirebaseAuth.instance.currentUser;
                           if (user != null) {
                             // Deleting the user from Firebase Authentication
                             await user.delete();

                             // Deleting the user's data from the FirebaseDatabase
                             await FirebaseFirestore.instance.collection("users").doc(sessionControlar().userid).delete().then((value) {

                               Navigator.pushReplacementNamed(context, RouteName.dashboardscreen);
                               utils.toastmassage("Account Deleted  Succesfully");
                             });

                           }
                         } catch (e) {
                           utils.toastmassage("Failed check connection");
                         }

                       },
                        value: SampleItem.itemOne,
                        child: const Text('Delete Account'),
                      ),
                       PopupMenuItem<SampleItem>(
                        onTap:  (){
                          FirebaseAuth.instance.signOut().then((value) {
                            FirebaseFirestore.instance.collection("users").doc(sessionControlar().userid).update({
                              "onlinestatues":"offline",
                            });
                            sessionControlar().userid=null;
                            Navigator.pushReplacementNamed(context, RouteName.loginview);


                          });
                        },
                        value: SampleItem.itemOne,
                        child: const Text('Logout'),

                      ),
                    ]
                            )
                    ),

                        Stack(
                       alignment: Alignment.bottomCenter,
                       children: [
                         Padding(
                           padding: const EdgeInsets.symmetric(vertical: 10.0),
                           child: Center(
                             child: Container(
                               height: 130,
                               width: 130,
                               decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 border: Border.all(
                                     color: AppColors.primaryTextTextColor
                                 ),



                               ),
                               child: ClipRRect(
                                 borderRadius: BorderRadius.circular(100),


                                 child:
                                 provider.image == null ?

                                 snapshot.data!.docs[index]['prfile'].toString() ==""?
                                 const Icon(Icons.person,size: 35,):
                                 Image(
                                     fit:BoxFit.cover,
                                     image: NetworkImage(
                                     imageurls
                                 )) : Image.file(
                                   File(provider.image!.path).absolute
                                 ),
                               ),


                             ),
                           ),
                         ),
                         InkWell(
                           onTap: (){

                             provider.picimage(context);
                           },
                           child: const CircleAvatar(
                             radius: 14,
                             backgroundColor: AppColors.primaryIconColor,
                             child: Icon(Icons.add,size: 18,color: Colors.white,),
                           ),
                         )
                       ],

                     ),
                        listdata(
                            title: 'Username',
                            value: snapshot.data!.docs[index]['username'].toString(),
                            iconData: Icons.person, 
                          editpress: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: SizedBox(
                                  height:140,
                                  child: Column(
                                    children: [
                                      Container(
                                  color: Colors.grey,

                                  width: double.infinity,
                                  child: Center(
                                    child: const Text("Edit Profile",style: TextStyle(
                                      color: Colors.white,
                                    ),),
                                  )),

                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      
                                      TextFormField(
                                        controller:rename ,
                                        decoration: InputDecoration(
                                          hintText: "New user name",
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0)
                                          ),
                                        ),
                                      ),
                                      
                                      Align(
                                        alignment: Alignment.bottomRight,
                                          child: TextButton(onPressed: (){

                                            FirebaseFirestore.instance.collection("users").doc(sessionControlar().userid).update({
                                              "username":rename.text.toString(),
                                            });



                                          }, child: const Text("ok",style: TextStyle(
                                            color: Colors.black
                                          ),)),),


                                    ],),
                                ),
                              );
                            },);
                        },),
                        listdata(
                            title: 'Email',
                            value: snapshot.data!.docs[index]['email'].toString(),
                            iconData: Icons.email_outlined, editpress: () {
                              
                              utils.toastmassage("Email can not be changed");
                        },),
                        listdata(
                            title: 'Phone',
                            value: snapshot.data!.docs[index]['phone'].toString(),
                            iconData: Icons.phone, editpress: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: SizedBox(
                                  height:140,
                                  child: Column(
                                    children: [
                                      Container(
                                          color: Colors.grey,

                                          width: double.infinity,
                                          child: Center(
                                            child: const Text("Edit Profile",style: TextStyle(
                                              color: Colors.white,
                                            ),),
                                          )),

                                      const SizedBox(
                                        height: 10.0,
                                      ),

                                      TextFormField(
                                        controller:rename ,
                                        decoration: InputDecoration(
                                          hintText: "New Number",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0)
                                          ),
                                        ),
                                      ),

                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: TextButton(onPressed: (){

                                          FirebaseFirestore.instance.collection("users").doc(sessionControlar().userid).update({
                                            "phone":rephone.text,
                                          });



                                        }, child: const Text("ok",style: TextStyle(
                                            color: Colors.black
                                        ),)),),


                                    ],),
                                ),
                              );
                            },);
                              
                        },),










                      ],
                    );

                  },
                );
              },
            );
          })),
    );
  }
}

class listdata extends StatelessWidget {
  const listdata(
      {Key? key,
      required this.title,
      required this.value,
      required this.iconData,
        required this.editpress
      })
      : super(key: key);
  final String title;
  final String value;
  final IconData iconData;
  final VoidCallback editpress;
  // String value
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          trailing: InkWell(
              onLongPress: editpress,
              child: Text(value)),
          title: Text(title),
          leading: Icon(iconData),
        ),

        const Divider(
          color: Colors.black,
        ),
      ],
    );
  }
}
// app.2
