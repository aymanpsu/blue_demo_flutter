import 'package:flutter/cupertino.dart';

class IosAlert extends StatelessWidget {
  const IosAlert({this.title, this.content});

  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Text(
          content,
          style: const TextStyle(fontSize: 15),
        ),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
