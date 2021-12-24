import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personalexpense_app/widgets/home.dart';

void main() {
  // Since I'm using the latest version of flutter, then widgetsflutterbiding is a must;
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
