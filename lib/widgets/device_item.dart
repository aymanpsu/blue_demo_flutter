import 'dart:developer';

import 'package:blu_demo/screens/data_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/blu_model.dart';

class DeviceItem extends StatelessWidget {
  const DeviceItem({
    this.deviceName,
    this.deviceId,
    this.deviceInfo,
  });

  final String deviceName;
  final String deviceId;
  final BluetoothDevice deviceInfo;

  /*
    -- List of devices --
    Here yo find list of dices
  */

  @override
  Widget build(BuildContext context) {
    // inti the scope model
    final bluInstance =
        ScopedModel.of<BluModel>(context, rebuildOnChange: false).blueInstance;

    return Card(
      child: ListTile(
        title: Text(
          (deviceName.isEmpty) ? "Unknown devcie" : deviceName,
        ),
        subtitle: Text(deviceId.toString()),
        leading: const Icon(Icons.bluetooth),
        // Connect to the device
        trailing: RaisedButton(
          onPressed: () {
            log("device connected to: $deviceInfo");
            // To stop scaning
            bluInstance.stopScan();
            // Connect to the device
            deviceInfo.connect(
              timeout: const Duration(seconds: 4),
            );
            // Route to data screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return DataViewPage(device: deviceInfo);
                },
              ),
            );
          },
          child: const Text("Connect"),
        ),
      ),
    );
  }
}
