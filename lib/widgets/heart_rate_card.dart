import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class HeartRateCard extends StatelessWidget {
  HeartRateCard({Key key, this.heartRateCharacteristic}) : super(key: key);
  BluetoothCharacteristic heartRateCharacteristic;

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
          subtitle: StreamBuilder<List<int>>(
            stream: heartRateCharacteristic.value.asBroadcastStream(),
            builder: (nx, res) {
              final int heartRate = res.data[1];
              log("res: ${res.data}");
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
