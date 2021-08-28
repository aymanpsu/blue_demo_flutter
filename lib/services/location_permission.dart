import 'dart:developer';
import 'package:permission_handler/permission_handler.dart';

/*
-- location permssion service --
Here in this service system check if the location service is enabled
Check the permssion of the location
if user denied the permssion system will ask agian
System need location permssion because it's BLE protocol standard
*/

class LocationPermssion {
  // Function to check the location service if it enabled
  Future<bool> isOn() async {
    // Check process start
    final bool locationIsEnabled =
        await Permission.locationWhenInUse.serviceStatus.isEnabled;
    log("Loaction is enabled: $locationIsEnabled");
    if (locationIsEnabled) {
      // Location location service is //enabled//
      return true;
    } else {
      // Location location service is //not enabled//
      return false;
    }
  }

  // function to check the location permission in the phone
  Future<bool> checkLocationPermission() async {
    // Check process start
    final PermissionStatus loactionPerStatus =
        await Permission.locationWhenInUse.status;
    log("Loaction permission status: $loactionPerStatus");
    // Check if location permission not allowed with these conditions
    if (loactionPerStatus == PermissionStatus.permanentlyDenied ||
        loactionPerStatus == PermissionStatus.denied ||
        loactionPerStatus == PermissionStatus.restricted ||
        loactionPerStatus == PermissionStatus.undetermined) {
      // If it not allowed ask the user to give acess
      final bool afterAskForPerm = await askForLocationPermission();
      // Check if the user not allow it again
      if (afterAskForPerm) {
        return false;
      }
      return !afterAskForPerm;
    } else {
      // Start scanning if permission is allowed
      return true;
    }
  }

  // Function to ask the user for location permission
  Future<bool> askForLocationPermission() async {
    log("Erorr: Location need to be enabled");
    // Request process start
    final bool locationIsDenied =
        await Permission.locationWhenInUse.request().isDenied;
    log("Location is denied: $locationIsDenied");
    return locationIsDenied;
    /* Extra code 
    // Open settings in the phone (in case of ristrcation)
    openAppSettings();
    */
  }
}
