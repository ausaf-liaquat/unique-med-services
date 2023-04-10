import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ums_staff/shared/theme/color.dart';

var fonts = GoogleFonts.workSans().fontFamily;

class AppThemeData {
  ThemeData lightTheme = ThemeData(
      fontFamily: fonts,
      colorScheme: AppColorScheme().colorScheme,
      dividerTheme: DividerThemeData(
        color: AppColorScheme().black10,
        space: 1,
      ),
      buttonTheme: ButtonThemeData(
          shape: const StadiumBorder(),
          buttonColor: HexColor('#A018F8'),
          textTheme: ButtonTextTheme.accent),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              shape: const StadiumBorder(),
              minimumSize: const Size.fromHeight(50),
              textStyle: TextStyle(
                  color: AppColorScheme().black0,
                  fontSize: 14,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w600))),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              shape: const StadiumBorder(),
              minimumSize: const Size.fromHeight(50),
              textStyle: const TextStyle(
                  fontSize: 14,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w500))),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              side: BorderSide(color: HexColor('#A018F8'), width: 2),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              shape: const StadiumBorder(),
              minimumSize: const Size.fromHeight(50),
              textStyle: const TextStyle(
                  fontSize: 14,
                  wordSpacing: 0.4,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w600))),
      inputDecorationTheme: InputDecorationTheme(
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColorScheme().black0),
          ),
          filled: true,
          fillColor: AppColorScheme().black0),
      appBarTheme: AppBarTheme(
        titleTextStyle: const TextStyle(
            fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white),
        elevation: 3,
        titleSpacing: 8,
        iconTheme:
            IconThemeData(size: 26, color: AppColorScheme().black2, opacity: 1),
        color: HexColor('#6505A3'),
        toolbarHeight: 55,
      ));

  ThemeData darkTheme = ThemeData(
    fontFamily: fonts,
    colorScheme: AppColorScheme().colorScheme,
  );
}
