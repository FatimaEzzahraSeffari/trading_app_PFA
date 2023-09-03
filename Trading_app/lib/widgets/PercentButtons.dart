import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class PercentChargeButtons extends StatelessWidget {
  final int selectedButton;
  final Function(int) onButtonPressed;

  const PercentChargeButtons({super.key,
    required this.selectedButton,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double btnWidth = screenWidth*0.22;
    //double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            fixedSize: Size(btnWidth, 35),
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
            backgroundColor: selectedButton == 0 ? const Color(0xFFb6c4ca) : darkTheme.colorScheme.secondary,
          ),
          onPressed: () => onButtonPressed(0),
          child:  Text('10% -',style: GoogleFonts.poppins(
            fontSize: 12.0,
            color: Colors.white,
          ),),
        ),
        const SizedBox(width:2),
        TextButton(
          style: TextButton.styleFrom(
            fixedSize: Size(btnWidth, 35),
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
            backgroundColor: selectedButton == 1 ? const Color(0xFFb6c4ca) : darkTheme.colorScheme.secondary,
          ),
          onPressed: () => onButtonPressed(1),
          child:  Text('Red',style: GoogleFonts.poppins(
            fontSize: 12.0,
            color: Colors.white,
          ),),
        ),
        const SizedBox(width: 2),
        TextButton(
          style: TextButton.styleFrom(
            fixedSize: Size(btnWidth, 35),
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
            backgroundColor: selectedButton == 2 ? const Color(0xFFb6c4ca) : darkTheme.colorScheme.secondary,
          ),
          onPressed: () => onButtonPressed(2),
          child:  Text('Green',style: GoogleFonts.poppins(
            fontSize: 12.0,
            color: Colors.white,
          ),),
        ),
        const SizedBox(width: 2),
        TextButton(
          style: TextButton.styleFrom(
            fixedSize: Size(btnWidth, 35),
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
            backgroundColor: selectedButton == 3 ? const Color(0xFFb6c4ca) : darkTheme.colorScheme.secondary,
          ),
          onPressed: () => onButtonPressed(3),
          child:  Text('10% +',style: GoogleFonts.poppins(
            fontSize: 12.0,
            color: Colors.white,
          ),),
        ),
      ],
    );
  }

}