import 'package:flutter/material.dart';


class Apptheme {

 static ThemeData darkTheme() {
    return ThemeData(
      cardColor: Colors.teal,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        surface: Colors.grey.shade900,
        primary: Colors.lightGreen,
        secondary: Colors.grey.shade900,
        
      ),  
    );
  }

static ThemeData lightTheme() {
    return ThemeData(
      cardColor: Colors.purple,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
         // ignore: deprecated_member_use
         background: Colors.white,
        primary: Colors.lightBlue,
        secondary: Colors.black,
      )
    );
  }

}
