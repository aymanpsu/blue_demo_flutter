import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: (Platform.isAndroid)
          // Android-specific code
          ? const CircularProgressIndicator()
          // iOS-specific code
          : const CupertinoActivityIndicator(),
    );
  }
}
