import 'package:flutter/material.dart';
import 'package:fruit_and_veggies_recognition/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fruit and Veggies Recognition',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.montserratAlternatesTextTheme(),
      ),
      home: HomePage(),
    );
  }
}
