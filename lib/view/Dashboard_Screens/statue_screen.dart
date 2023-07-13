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
        child: Text(
          'status not not for this time'
        ),
      ),
    );
  }
}
