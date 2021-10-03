import 'package:flutter/material.dart';
import 'package:flutter_application_crud/screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => MainScreen(),
        '/add': (context) => AddScreen(),
      },
    );
  }
}
