import 'package:brain_pulse/core/Theming/text_style.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorsApp.white,
      selectedItemColor: ColorsApp.blue,
      unselectedItemColor: ColorsApp.black,
    ),
    scaffoldBackgroundColor: ColorsApp.white,
    appBarTheme: AppBarTheme(
      color: ColorsApp.white,
      elevation: 0,
      iconTheme: IconThemeData(color: ColorsApp.black),
      titleTextStyle: TextStyleApp.font18boldBlack,
    ),
    cardColor: Colors.white,
   // iconTheme: IconThemeData(color: ColorsApp.blue),
    textTheme:  TextTheme(
      titleLarge: TextStyleApp.font18boldBlack.copyWith(fontSize: 20),
      bodyLarge: TextStyleApp.font18boldBlack,
      bodyMedium: TextStyleApp.font14weight400colorGrey.copyWith(color: ColorsApp.black),
      bodySmall: TextStyleApp.font12weight400colorGrey.copyWith(color: ColorsApp.black),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorsApp.black,
      selectedItemColor: ColorsApp.blue,
      unselectedItemColor: ColorsApp.white,
    ),
    scaffoldBackgroundColor: ColorsApp.black,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsApp.black,
      elevation: 0,
      iconTheme: IconThemeData(color: ColorsApp.white),
      titleTextStyle: TextStyleApp.font18boldBlack.copyWith(color: ColorsApp.white),
    ),
    //iconTheme: IconThemeData(color: ColorsApp.blue),
    cardColor: ColorsApp.grey900,
    textTheme:  TextTheme(
      titleLarge: TextStyleApp.font18boldBlack.copyWith(fontSize: 22,color: ColorsApp.white),
      bodyLarge: TextStyleApp.font18boldBlack.copyWith(color: ColorsApp.white),
      bodyMedium: TextStyleApp.font14weight400colorGrey.copyWith(color: ColorsApp.white),
      bodySmall: TextStyleApp.font12weight400colorGrey.copyWith(color: ColorsApp.white),

    ),

  );
}
