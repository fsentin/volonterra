import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:volonterra/screens/common/welcomescreen.dart';
import 'package:volonterra/styles.dart';

void main() => runApp(VolonterraApp());

class VolonterraApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Volonterra',
      theme: ThemeData(
          errorColor: Styles.red,
          textTheme: GoogleFonts.ralewayTextTheme(
          Theme.of(context).textTheme,
          ),
        primarySwatch: Colors.grey,
      ),
      home: WelcomeScreen(),
    );
  }
}
