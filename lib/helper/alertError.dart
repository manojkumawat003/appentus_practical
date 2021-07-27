
import 'package:flutter/material.dart';

showErrorDialog(context, msg) {
  showDialog(
    barrierDismissible: true, // JUST MENTION THIS LINE
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        backgroundColor: Colors.white,
          actions: <Widget>[
            OutlineButton(
              color: Colors.white,
              child: Text('close'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
          content: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
                height: 200,
                width: 50,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "$msg",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                )),
          ));
    },
  );
}
