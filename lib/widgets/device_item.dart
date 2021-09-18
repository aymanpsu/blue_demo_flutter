import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/blu_model.dart';
import '../providers/load_in_button.dart';
import '../screens/data_view.dart';
import 'loading_view.dart';

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
        trailing: Consumer<LoadInButton>(
          builder: (context, loadInButton, child) {
            return RaisedButton(
              onPressed: () async {
                loadInButton.turnOnLoading();
                log("device connected to: $deviceInfo");
                await Future.wait([
                  // To stop scaning
                  bluInstance.stopScan(),
                  // Connect to the device
                  deviceInfo.connect(
                    timeout: const Duration(seconds: 4),
                  ),
                ]);
                loadInButton.turnOffLoading();
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
              child: (loadInButton.load)
                  ? const SizedBox(
                      width: 25,
                      height: 25,
                      child: LoadingView(),
                    )
                  : const Text("Connect"),
            );
          },
        ),
      ),
    );
  }
}
