import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeartRateCard extends StatefulWidget {
  const HeartRateCard({Key key}) : super(key: key);

  @override
  _HeartRateCardState createState() => _HeartRateCardState();
}

class _HeartRateCardState extends State<HeartRateCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 7,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              children: [
                Icon(
                  Icons.favorite,
                  color: Colors.red[700],
                ),
                const Text(
                  " Heart rate",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          subtitle: Consumer<int>(
            builder: (_,int heartRate, child) {
              log("heart Rate: $heartRate");
              return RichText(
                text: TextSpan(
                  text: ' $heartRate',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' bpm',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
