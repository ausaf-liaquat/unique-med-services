import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ums_staff/shared/theme/color.dart';

var fonts = GoogleFonts.workSans().fontFamily;

class AppThemeData {
  ThemeData lightTheme = ThemeData(
    fontFamily: fonts,
    colorScheme: AppColorScheme().colorScheme,
    buttonTheme: const ButtonThemeData(shape: StadiumBorder()),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: TextButton.styleFrom(shape: const StadiumBorder())),
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
