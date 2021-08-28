import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_blue/flutter_blue.dart';


class BluModel extends Model {
  // Init flutter_blue lib instance
  final FlutterBlue _blueInstance = FlutterBlue.instance;
  // Build get scoped data
  FlutterBlue get blueInstance => _blueInstance;
}