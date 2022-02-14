import 'dart:developer';

import 'package:blu_demo/widgets/loading_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../services/blu_discover.dart';

import '../widgets/blood_oxygen_card.dart';
import '../widgets/blood_pressure_card.dart';
import '../widgets/body_temperature_card.dart';
import '../widgets/error_view.dart';
import '../widgets/heart_rate_card.dart';

class DataViewPage extends StatelessWidget {
  const DataViewPage({Key? key, this.device}) : super(key: key);

  final BluetoothDevice? device;

  @override
  Widget build(BuildContext context) {
    final BluDiscover bluDiscoverSerive = BluDiscover();
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Data from ${device!.name}"),
      ),
      body: FutureBuilder(
        future: bluDiscoverSerive.discoverServices(
          device!,
          "Heart Rate",
        ),
        builder: (c, snapshotOfServcies) {
          log("snapshotOfServcies: {$snapshotOfServcies}");
          if (snapshotOfServcies.hasData) {
            final BluetoothCharacteristic? heartRateCharacteristic = snapshotOfServcies.data as BluetoothCharacteristic?;
            return ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                // Heart rate card
                HeartRateCard(heartRateCharacteristic: heartRateCharacteristic,),
                // Blood pressure card
                const BloodPressureCard(),
                // Blood oxygen card
                const BloodOxygenCard(),
                // Body temperature card
                const BodyTemperatureCard(),
              ],
            );
          } else if (snapshotOfServcies.hasError) {
            // Dispaly erorr message
            return ErrorView(errorMessage: snapshotOfServcies.error.toString());
          } else {
            // Display loading indicator
            return const LoadingView();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[900],
        onPressed: () async{
          // Disconnect from the device
          log("Disconnected from the ${device!.name}");
          await device!.disconnect();
          // Route back to the scan page
          Navigator.of(context).pop();
        },
        child: const Icon(
          Icons.stop,
        ),
      ),
    );
  }
}
