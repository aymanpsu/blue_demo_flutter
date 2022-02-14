import 'package:blu_demo/models/blu_model.dart';
import 'package:blu_demo/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:scoped_model/scoped_model.dart';

Future main() async {
  // Call the env file before load the app
  await dotenv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    // init the scoped model
    final BluModel model = BluModel();
    return ScopedModel<BluModel>(
      // return the scope in the main widget
      model: model,
      child: MaterialApp(
        title: 'Blu Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomePage(),
      ),
    );
  }
}
