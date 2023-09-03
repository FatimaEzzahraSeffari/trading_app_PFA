import 'package:flutter/material.dart';

//12/07/23
const entitlementID ='premium';
//12/07/23
const googleApiKey='goog_EzHXVCcfWlOAfgxzWWywnfTMvoe';

const Color primaryColor = Color(0xFF181A20);
const Color secondaryColor = Color(0xFF262A33);
final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSwatch(
    brightness: Brightness.light, // specify brightness
  ).copyWith(secondary: secondaryColor),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSwatch(
    brightness: Brightness.dark, // specify brightness
  ).copyWith(secondary: secondaryColor),
);

