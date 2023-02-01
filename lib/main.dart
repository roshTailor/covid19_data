import 'package:covid19_data/screens/HomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      textTheme: const TextTheme(
        bodyText2: TextStyle(
          fontFamily: "Ubuntu",
        ),
      ),
    ),
    debugShowCheckedModeBanner: false,
    home: const HomePage(),
  ));
}
