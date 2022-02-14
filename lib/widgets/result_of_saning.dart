import 'dart:developer';

import 'package:blu_demo/widgets/loading_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/blu_model.dart';
import '../providers/load_in_button.dart';
import '../widgets/device_item.dart';
import '../widgets/error_view.dart';

class ResultOfScaning extends StatelessWidget {
  const ResultOfScaning({Key? key}) : super(key: key);

  /*
  -- Resulte of scaning --
  Here you will find all the code for scan process
  Getting the resulte and show it for the user
  skleaton loading and error handling 
  */

  @override
  Widget build(BuildContext context) {
    // inti the scope model
    final bluInstance =
        ScopedModel.of<BluModel>(context, rebuildOnChange: false).blueInstance;

    return FutureBuilder<dynamic>(
      future: bluInstance.startScan(
        timeout: const Duration(seconds: 4),
        scanMode: ScanMode.lowPower,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Listen to scan results
          return StreamBuilder<List<ScanResult>>(
            stream: bluInstance.scanResults,
            initialData: const [],
            builder: (_, sh) {
              log("The number of devices found: ${sh.data!.length}");
              // View list of devices
              if (sh.hasError) {
                log("empty list of devices");
                // Dispaly erorr message
                return ErrorView(errorMessage: sh.error.toString());
              } else if (sh.hasData) {
                return ListView.builder(
                  itemCount: sh.data!.length,
                  itemBuilder: (BuildContext context, index) {
                    final result = sh.data![index];
                    log(result.toString());
                    return ChangeNotifierProvider<LoadInButton>(
                      create: (context) => LoadInButton(),
                      child: DeviceItem(
                        deviceId: result.device.id.toString(),
                        deviceName: result.device.name,
                        deviceInfo: result.device,
                      ),
                    );
                  },
                );
              } else {
                // Display loading indicator
                return const LoadingView();
              }
            },
          );
        } else if (snapshot.hasError) {
          // Dispaly erorr message
          return ErrorView(errorMessage: snapshot.error.toString());
        } else {
          // Display loading indicator
          return const LoadingView();
        }
      },
    );
  }
}
