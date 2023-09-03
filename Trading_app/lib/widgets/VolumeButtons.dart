import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trading/constants.dart';

class VolumeButtons extends StatelessWidget {
  const VolumeButtons({
    Key? key,
    required this.volume,
    required this.onVolumeSelected,
  }) : super(key: key);

  final int volume;
  final Function(int) onVolumeSelected;

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
            backgroundColor: volume == 100000 ? const Color(0xFFb6c4ca) : darkTheme.colorScheme.secondary,
          ),
          onPressed: () {
            onVolumeSelected(100000);
          },
          child: Text(
            'Over 100K',
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
            backgroundColor: volume == 1000000 ? const Color(0xFFb6c4ca) : darkTheme.colorScheme.secondary,
          ),
          onPressed: () {
            onVolumeSelected(1000000);
          },
          child: Text(
            'Over 1M',
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
            backgroundColor: volume == 10000000 ? const Color(0xFFb6c4ca) : darkTheme.colorScheme.secondary,
          ),
          onPressed: () {
            onVolumeSelected(10000000);
          },
          child: Text(
            'Over 10M',
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
            backgroundColor: volume == 1 ? const Color(0xFFb6c4ca) : darkTheme.colorScheme.secondary,
          ),
          onPressed: () {
            onVolumeSelected(1);
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
