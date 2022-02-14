import 'dart:developer';

import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key, this.errorMessage}) : super(key: key);
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    log("erorr message: $errorMessage");
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60,
          ),
          Text(
            'Error: $errorMessage',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
