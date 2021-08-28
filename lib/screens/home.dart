import 'dart:developer';
import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:toast/toast.dart';

import '../models/blu_model.dart';
import '../services/location_permission.dart';
import '../widgets/android_alert.dart';
import '../widgets/ios_alert.dart';
import '../widgets/loading_view.dart';
import '../widgets/scan_bottom_sheet.dart';

/*
-- Home page --
This is the home page in the app (main/index page)
User start from here to scan for bluetooth devices
It will connect with the device via BLE prtocole
App is requeting location permssion from the user
*/

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Init loader state
  bool _loader = false;
  // Init locatrion permssion service
  final LocationPermssion _locationPermssion = LocationPermssion();

  @override
  Widget build(BuildContext context) {
    // inti the scope model
    final bluInstance =
        ScopedModel.of<BluModel>(context, rebuildOnChange: false).blueInstance;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Blu demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 290,
              child: Image.asset(
                "assets/blu_logo.png",
                width: double.infinity,
              ),
            ),
            const Text(
              'Press the button to scan for test device',
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
              ),
              child: RaisedButton(
                onPressed: () async {
                  // Make lodaing indictoer //start// with checks
                  setState(() {
                    _loader = true;
                  });
                  // Check all needed points
                  final res = await Future.wait([
                    _locationPermssion.isOn(),
                    bluInstance.isOn,
                    _locationPermssion.checkLocationPermission(),
                    Future.delayed(const Duration(seconds: 1)),
                  ]);
                  // Check location servcie if it enabled
                  final bool locationStat = res[0] as bool;
                  // Check bluetooth servcie if it enabled
                  final bool bluetoothStat = res[1] as bool;
                  log("bluetooth is enabled: $bluetoothStat");
                  // Check location permission
                  final bool locationPerStat = res[2] as bool;
                  // Make lodaing indictoer //stop// with end of checks
                  setState(() {
                    _loader = false;
                  });
                  if (bluetoothStat && locationStat && locationPerStat) {
                    // Show the results
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                        ),
                      ),
                      builder: (BuildContext context) {
                        // List of devices inside BottomSheet
                        return const ScanBottomSheet();
                      },
                    );
                  } else if (!locationPerStat) {
                    // In case user denied the location permission
                    Toast.show(
                      "Permission denied",
                      context,
                      duration: Toast.LENGTH_SHORT,
                      gravity: Toast.BOTTOM,
                      backgroundColor: Colors.grey.shade600,
                    );
                  } else {
                    // Alert user to turn on bluetooth and location.
                    log("Erorr: User should turn on bluetooth and location");
                    if (Platform.isAndroid) {
                      // Android-specific code
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return const AndroidAlert(
                            title: "Whoops something went wrong!",
                            content: "please turn on bluetooth and location",
                          );
                        },
                      );
                    } else if (Platform.isIOS) {
                      // iOS-specific code
                      showCupertinoDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return const IosAlert(
                            title: "Whoops something went wrong!",
                            content: "please turn on bluetooth and location",
                          );
                        },
                      );
                    }
                  }
                },
                // Button to start scanning
                child: _loader
                    ? const SizedBox(
                        width: 25,
                        height: 25,
                        child: LoadingView(),
                      )
                    : const Text("Scan"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
