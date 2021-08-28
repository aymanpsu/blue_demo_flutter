import 'dart:math';

class StreamCharFromDevice {
  final int heartRate;

  StreamCharFromDevice({this.heartRate});

  Stream<int> get viewHeatRate async* {
    var initialHeartRate = 0;
    while (initialHeartRate < 2295) {
      await Future.delayed(const Duration(seconds: 2), () {
        initialHeartRate = Random().nextInt(2000);
      });
      yield initialHeartRate;
    }
  }
}
