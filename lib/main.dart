import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;
import 'package:scoped_model/scoped_model.dart';

import './models/blu_model.dart';
import './screens/home.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    // init the scoped model
    final BluModel model = BluModel();
    return ScopedModel<BluModel>( // return the scope in the main widget
      model: model,
      child: MaterialApp(
        title: 'Blu Demo',
        theme: ThemeData(
          primaryColor: Colors.indigo[900],
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomePage(),
      ),
    );
  }
}
