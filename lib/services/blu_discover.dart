import 'dart:developer';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BluDiscover {

  Future<List<BluetoothService>> discoverServicesAndCharacteristics(
      BluetoothDevice bluetoothDevice, String seviceType) async {
    /// init the main vlues
    List<BluetoothService> services;
    BluetoothService service;
    List<BluetoothCharacteristic> characteristics;
    BluetoothCharacteristic characteristic;

    /// Get all services from the device
    try {
      services = await bluetoothDevice.discoverServices().timeout(
            const Duration(seconds: 4),
            onTimeout: () => <BluetoothService>[],
          );
      log("services from funcation: $services");
      // if (services.isEmpty) {
      //   log("Service list empty, flutter_blue race condition?");
      //   // services =
      //   //     await bluetoothDevice.services.catchError();

      //   if (services.isEmpty) {
      //     log("no services advertised!");
      //     // _cleanupAndCancel();
      //     return null;
      //   }
      // }
    } catch (e) {
      log("Error: $e");
    }

    switch (seviceType) {
      case "Heart Rate":
        {
          BluetoothService heartRateService;
          BluetoothCharacteristic heartRateCharacteristic;
          for (service in services) {
            if (service.uuid.toString() ==
                env['TEST_HEART_RATE_SERVICE_UUID']) {
              heartRateService = service;
              log("Found heart rate service ${heartRateService.uuid}");
              characteristics = heartRateService.characteristics;
              for (characteristic in characteristics) {
                if (characteristic.uuid.toString() ==
                    env['TEST_HEART_RATE_CHARACTERISTIC_UUID']) {
                  heartRateCharacteristic = characteristic;
                }
              }
            }
          }
        }
        break;
      case "Blood Pressure":
        {
          log("2");
        }
        break;
      default:
        {
          log("no service try agian");
        }
    }
    return services;
  }

  Stream<String> getheatRate(
      BluetoothCharacteristic bluetoothCharacteristic) async* {
    log("Found heart rate characteristic ${bluetoothCharacteristic.uuid}");
    await bluetoothCharacteristic.setNotifyValue(true);
    // log("Start listening heart rate from ${bluetoothDevice.name} on notification");
    // bluetoothCharacteristic.value.listen((event) {
    //   final value = event[1];
    //   hearRate = value;
    //   log("value: $value");
    //   yield hearRate;
    // });
  }
}
