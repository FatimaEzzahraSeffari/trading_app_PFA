import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class MarketCapButtons extends StatelessWidget {
  const MarketCapButtons({
    Key? key,
    required this.marketCap,
    required this.onMarketCapSelected,
  }) : super(key: key);

  final int marketCap;
  final Function(int) onMarketCapSelected;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double btnWidth = screenWidth*0.22;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            fixedSize: Size(btnWidth, 35),
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
            backgroundColor: marketCap == 99999999 ? const Color(0xFFb6c4ca) : darkTheme.colorScheme.secondary,
          ),
          onPressed: () {
            onMarketCapSelected(99999999);
          },
          child: Text(
            'Under 100M',
            style: GoogleFonts.poppins(fontSize: 12.0 , color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 2),
        TextButton(
          style: TextButton.styleFrom(
            fixedSize: Size(btnWidth, 35),
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
            backgroundColor: marketCap == 499999999 ? const Color(0xFFb6c4ca) : darkTheme.colorScheme.secondary ,
          ),
          onPressed: () {
            onMarketCapSelected(499999999);
          },
          child: Text(
            'Under 500M',
            style: GoogleFonts.poppins(fontSize: 12.0 , color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 2),
        TextButton(
          style: TextButton.styleFrom(
            fixedSize: Size(btnWidth, 35),
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
            backgroundColor: marketCap == 999999999 ? const Color(0xFFb6c4ca) : darkTheme.colorScheme.secondary,
          ),
          onPressed: () {
            onMarketCapSelected(999999999);
          },
          child: Text(
            'Under 1B',
            style: GoogleFonts.poppins(fontSize: 12.0 , color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 2),
        TextButton(
          style: TextButton.styleFrom(
            fixedSize: Size(btnWidth, 35),
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
            backgroundColor: marketCap == 99999999999999 ? const Color(0xFFb6c4ca) : darkTheme.colorScheme.secondary,
          ),
          onPressed: () {
            onMarketCapSelected(99999999999999);
          },
          child: Text(
            'All',
            style: GoogleFonts.poppins(fontSize: 12.0 , color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
