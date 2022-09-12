import 'package:flutter/material.dart';

Future<void> showAlertDialog(BuildContext context,String? title,String? message) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        //title: SizedBox(),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message??"")
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}