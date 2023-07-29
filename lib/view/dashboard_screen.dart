// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view/Dashboard_Screens/Profile_screen.dart';
import 'package:tech_media/view/Dashboard_Screens/user_list.dart';
import 'package:animated_search_bar/animated_search_bar.dart';
import '../Session/session_controlar.dart';
import 'Dashboard_Screens/statue_screen.dart';

class dashboard_screen extends StatefulWidget {
  const dashboard_screen({Key? key}) : super(key: key);

  @override
  State<dashboard_screen> createState() => _dashboard_screenState();
}

class _dashboard_screenState extends State<dashboard_screen>
    with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    sendstatus("online");

  }
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  void sendstatus(String status) async{

    try{

      await _store.collection('users').doc(sessionControlar().userid.toString()).update({

        "onlinestatues":status,
      });
    }
    catch(e){

      utils.toastmassage("Check your internet connection");
    }

  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    if(state==AppLifecycleState.resumed){

      sendstatus("online");

    }
    else{

      sendstatus("offline");

    }

  }





  // PersistentTabController tabs= PersistentTabController(initialIndex: 0,);

  String searchValue = '';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
            title:  Text("Chat App"),




            bottom: const TabBar(
              tabs: [
                Tab(text: "Message"),
                Tab(text: "Statue"),
                Tab(text: "Profile")
              ],
            ),
          ),
          body:  TabBarView(

            children: [
              users_list_screen(),
              status_screen(),
              profile_screen(),
            ],
          ),
        ));
  }
}
