import 'package:flutter/material.dart';
import 'package:fruit_and_veggies_recognition/home_page.dart';
import 'package:fruit_and_veggies_recognition/models/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.montserratAlternatesTextTheme(),
        ),
        home: HomePage(),
      ),
    );
  }
}
