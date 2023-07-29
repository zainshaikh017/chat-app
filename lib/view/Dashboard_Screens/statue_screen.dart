// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class status_screen extends StatefulWidget {
  const status_screen({super.key});

  @override
  State<status_screen> createState() => _status_screenState();
}

class _status_screenState extends State<status_screen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(


      body: Center(
        child: Text("soon"),
        // child:StreamBuilder<QuerySnapshot>(
        //   stream: FirebaseFirestore.instance.collection('users').snapshots(),
        //   builder:
        //       (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //     if (snapshot.hasError) {
        //       return Center(child: Text('Error: ${snapshot.error}'));
        //     }
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(child: Text('Loading...'));
        //     }
        //     if (!snapshot.hasData) {
        //       return const Center(child: Text('Document does not exist.'));
        //     }
        //     return ListView.builder(
        //       shrinkWrap: true,
        //       itemCount: snapshot.data!.docs.length,
        //       itemBuilder: (context, index) {
        //         return Card(
        //           child: InkWell(
        //             onTap: () {
        //               final roomid = chatroomid(_auth.currentUser!.uid,
        //                   snapshot.data!.docs[index]['uid'].toString());
        //
        //               Navigator.push(context, MaterialPageRoute(
        //                 builder: (context) {
        //                   return chat_screen(
        //                     chatid:
        //                     snapshot.data!.docs[index]['uid'].toString(),
        //                     username: snapshot.data!.docs[index]['username']
        //                         .toString(),
        //                     imageurl: snapshot.data!.docs[index]['prfile']
        //                         .toString(),
        //                     chatroomID: roomid,
        //                     onlinestatus: snapshot
        //                         .data!.docs[index]['onlinestatues']
        //                         .toString(),
        //                   );
        //                 },
        //               ));
        //             },
        //             child: ListTile(
        //               leading: CircleAvatar(
        //                 radius: 30,
        //                 backgroundColor: Colors.white60,
        //                 backgroundImage: NetworkImage(
        //                     snapshot.data!.docs[index]['prfile'].toString()),
        //               ),
        //               title: Text(
        //                   snapshot.data!.docs[index]['username'].toString()),
        //               subtitle: Text(
        //                   snapshot.data!.docs[index]['email'].toString()),
        //             ),
        //           ),
        //         );
        //       },
        //     );
        //   },
        // );
      ),
    );
  }
}








//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   Map<String, dynamic> dataMap = {}; // Store fetched data in this map
//
//   @override
//   void initState() {
//     super.initState();
//     fetchDataFromFirestore();
//   }
//
//   void fetchDataFromFirestore() async {
//     // Assuming you have a collection called "your_collection_name" in Firestore
//     QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("users").get();
//
//     // Store the fetched data in the map
//     snapshot.docs.forEach((doc) {
//       dataMap[doc.id] = doc.data();
//     });
//
//     setState(() {});
//   }
//
//   List<String> searchResults = []; // Store search results in this list
//
//   void performSearch(String searchQuery) {
//     // Clear previous search results
//     searchResults.clear();
//
//     // Perform search in the data map
//     dataMap.forEach((key, value) {
//       // Assuming you want to search for a specific field called "searchField"
//       String fieldValue = value["email"].toString().toLowerCase();
//       if (fieldValue.contains(searchQuery.toLowerCase())) {
//         searchResults.add(key);
//       }
//     });
//
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Firestore Data Search"),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(10.0),
//             child: TextField(
//               onChanged: (query) => performSearch(query),
//               decoration: InputDecoration(
//                 labelText: "Search",
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: searchResults.length,
//               itemBuilder: (context, index) {
//                 String docId = searchResults[index];
//                 Map<String, dynamic> data = dataMap[docId];
//                 return ListTile(
//                   title: Text(data["email"]),
//                   subtitle: Text(data["username"]),
//                   // Customize the data you want to display here
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
