import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class AppColorScheme {
  ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,
    background: HexColor("#FAFAFA"),
    onBackground: HexColor('#1A1A1A'),
    primary: HexColor('#A018F8'),
    onPrimary: HexColor('#FFFFFF'),
    secondary: HexColor('#2AABE4'),
    onSecondary: HexColor('#FFFFFF'),
    error: HexColor('#DB3329'),
    onError: HexColor('#FFFFFF'),
    surface: HexColor('#FFFFFF'),
    onSurface: HexColor('#1A1A1A'),
  );

  // black
  Color black100 = HexColor('#000000');
  Color black90 = HexColor('#1A1A1A');
  Color black80 = HexColor('#333333');
  Color black70 = HexColor('#4D4D4D');
  Color black60 = HexColor('#666666');
  Color black50 = HexColor('#808080');
  Color black40 = HexColor('#999999');
  Color black30 = HexColor('#B3B3B3');
  Color black20 = HexColor('#CCCCCC');
  Color black10 = HexColor('#E6E6E6');
  Color black8 = HexColor('#EBEBEB');
  Color black6 = HexColor('#F0F0F0');
  Color black4 = HexColor('#F5F5F5');
  Color black2 = HexColor('#FAFAFA');
  Color black0 = HexColor('#FFFFFF');

  get color => null;

  get grey80 => null;

  get grey8 => null;
}
