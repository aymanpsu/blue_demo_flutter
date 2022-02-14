import 'package:flutter/material.dart';

import './result_of_saning.dart';

class ScanBottomSheet extends StatelessWidget {
  const ScanBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Take more than half of the screen size
      height: MediaQuery.of(context).size.height * 0.55,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: SizedBox(
              height: 20,
              child: Center(
                child: Image.asset(
                  "assets/icons/home-indicator.png",
                ),
              ),
            ),
          ),
          // List of bluetooth devices
          const Expanded(
            child: ResultOfScaning(),
          )
        ],
      ),
    );
  }
}
