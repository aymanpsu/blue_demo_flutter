import 'dart:developer';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/*
-- Blu discover Service ---

*/

class BluDiscover {
  Future<BluetoothCharacteristic?> discoverServices(
      BluetoothDevice bluetoothDevice, String seviceType) async {
    /// init the main vlues
    List<BluetoothService> services;
    BluetoothService service;
    BluetoothService heartRateService;
    List<BluetoothCharacteristic> characteristics;
    BluetoothCharacteristic characteristic;
    BluetoothCharacteristic? heartRateCharacteristic;

    /// Get all services from the device
    try {
      services = await bluetoothDevice.discoverServices().timeout(
            const Duration(seconds: 4),
            onTimeout: () => <BluetoothService>[],
          );
      log("services from funcation: $services");
      if (services.isEmpty) {
        throw Exception('No services avalible');
      } else {
        // looking for the heart rate service
        for (service in services) {
          if (service.uuid.toString() == dotenv.get('TEST_HEART_RATE_SERVICE_UUID')) {
            // found the service
            heartRateService = service;
            log("Found heart rate service ${heartRateService.uuid}");
            characteristics = heartRateService.characteristics;
            // looking for the heart rate characteristic
            for (characteristic in characteristics) {
              if (characteristic.uuid.toString() ==
                  dotenv.get('TEST_HEART_RATE_CHARACTERISTIC_UUID')) {
                // found the characteristic
                heartRateCharacteristic = characteristic;
                log("Found heart rate characteristic ${characteristic.uuid}");
                log("start the stream here: $characteristic");
                try {
                  if (characteristic == null) {
                    throw Exception('characteristic is coming null');
                  } else {
                    // Start stream between APP and BLE Device
                    await characteristic.setNotifyValue(true);
                  }
                } catch (e) {
                  log("Error: $e");
                }
                return heartRateCharacteristic;
              }
            }
          }
        }
      }
    } catch (e) {
      log("Error: $e");
    }
    return heartRateCharacteristic;
  }
}
