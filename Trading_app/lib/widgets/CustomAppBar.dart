import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trading/constants.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({super.key, required String title})
      : super(
    title: Text(title , style: GoogleFonts.lato(color: Colors.white)),
    centerTitle: true,
    backgroundColor: darkTheme.primaryColor,
    elevation: 0.0,
  );
}