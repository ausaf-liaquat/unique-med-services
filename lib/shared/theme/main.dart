import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ums_staff/shared/theme/color.dart';

var fonts = GoogleFonts.workSans().fontFamily;

class AppThemeData {
  ThemeData lightTheme = ThemeData(
    fontFamily: fonts,
    colorScheme: AppColorScheme().colorScheme,
    buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        buttonColor: HexColor('#A018F8'),
        textTheme: ButtonTextTheme.accent),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: TextButton.styleFrom(
            iconColor: AppColorScheme().black0,
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            shape: const StadiumBorder(),
            minimumSize: const Size.fromHeight(50),
            textStyle: TextStyle(
                color: AppColorScheme().black0,
                fontSize: 14,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w600))),
    inputDecorationTheme: InputDecorationTheme(
        contentPadding:
            const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColorScheme().black0),
        ),
        filled: true,
        fillColor: AppColorScheme().black0),
  );

  ThemeData darkTheme = ThemeData(
    fontFamily: fonts,
    colorScheme: AppColorScheme().colorScheme,
  );
}
