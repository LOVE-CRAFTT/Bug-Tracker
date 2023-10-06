import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FastAccessContainer extends StatelessWidget {
  final int number;
  final String text;
  final IconData icon;

  FastAccessContainer({
    Key? key,
    required this.number,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final TextStyle fastAccessTextStyle = GoogleFonts.nunito(
    fontSize: 18,
    color: const Color(0xFFb6b8aa),
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFF1e1e1e),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  number.toString(),
                  style: fastAccessTextStyle,
                ),
                Icon(icon),
              ],
            ),
            Text(
              text,
              style: fastAccessTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
