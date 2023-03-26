import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ums_staff/shared/theme/color.dart';

var fonts = GoogleFonts.workSans().fontFamily;

class AppThemeData {
  ThemeData lightTheme = ThemeData(
    fontFamily: fonts,
    colorScheme: AppColorScheme().colorScheme,
  );
  ThemeData darkTheme = ThemeData(
    fontFamily: fonts,
    colorScheme: AppColorScheme().colorScheme,
  );
}
