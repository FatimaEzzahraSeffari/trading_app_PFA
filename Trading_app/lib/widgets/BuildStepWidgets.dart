import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildStep(String text) {
  return Text(
    text,
    style: GoogleFonts.poppins(
      fontSize: 18.0,
      color: const Color(0xFFACACBE),
    ),
  );
}

Widget buildSubStep(String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
       Text(
        '- ',
        style: GoogleFonts.poppins(
          fontSize: 18.0,
          color: const Color(0xFFACACBE),
        ),
      ),
      Expanded(
        child: Text(
          text,
          style:  GoogleFonts.poppins(
            fontSize: 18.0,
            color: const Color(0xFFACACBE),
          ),
        ),
      ),
    ],
  );
}
