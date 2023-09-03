import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';

class CustomElevatedButton extends StatelessWidget {
  final String image;
  final String text;
  final Widget page;

  const CustomElevatedButton({super.key,
    required this.image,
    required this.text,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: darkTheme.colorScheme.secondary,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        minimumSize: const Size(double.infinity, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11.0),
        ),
       alignment: Alignment.centerLeft,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            image,
            width: 30,
            height: 30,
          ),
          const SizedBox(width: 20),
          Text(text , style: GoogleFonts.poppins(color: Colors.white, fontSize: 18)),
        ],
      ),
    );
  }
}
