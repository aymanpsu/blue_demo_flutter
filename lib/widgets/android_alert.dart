import 'package:flutter/material.dart';

class AndroidAlert extends StatelessWidget {
  const AndroidAlert({this.title, this.content});

  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
      content: Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Text(
          content,
          style: const TextStyle(fontSize: 14),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
