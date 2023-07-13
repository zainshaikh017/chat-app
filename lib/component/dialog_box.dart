import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onPressed;

  CustomDialog({required this.title, required this.content, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text('OK'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}




















RaisedButton(
onPressed: () {
showDialog(
context: context,
builder: (BuildContext context) {
return CustomDialog(
title: 'Dialog Title',
content: 'Dialog content goes here',
onPressed: () {
// Do something when the user presses the OK button
Navigator.of(context).pop();
},
);
},
);
},
child: Text('Show Dialog'),
)
