import 'package:flutter/material.dart';

class Styles {
  static const black = Color(0xFF242729);
  static const blue = Color(0xFF3174A5);
  static const lightBlue = Color(0xFF61C4EF);
  static const red = Color(0xFFFD3921);
  static const green = Color(0xFFF407C49);
  static final EdgeInsets insets = EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0);
  static final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0)
  );

  static final TextStyle textStyleBlack = TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 18,
      color: Styles.black
  );

  static final TextStyle textStyleRed = TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 18,
      color: Styles.red
  );

  static final TextStyle  textStyleWhite = TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 18,
      color: Colors.white
  );

  static final TextStyle textStyleBlue = TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 18,
      color: Styles.blue
  );

  static final ButtonStyle btnStyleWhite = ButtonStyle(
    elevation: MaterialStateProperty.all(10),
    backgroundColor: MaterialStateProperty.all(Colors.white),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),)
    ),
  );

  static final ButtonStyle btnStyleBlack = ButtonStyle(
    elevation: MaterialStateProperty.all(10),
    backgroundColor: MaterialStateProperty.all(Styles.black),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    ),
  );

  static final ButtonStyle btnStyleRed = ButtonStyle(
    elevation: MaterialStateProperty.all(10),
    backgroundColor: MaterialStateProperty.all(Styles.red),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    ),
  );

}
