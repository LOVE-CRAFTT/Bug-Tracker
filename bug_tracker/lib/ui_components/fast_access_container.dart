import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///Provides a quick overview of open bugs, closed bugs,
///open milestones or closed milestones.
///Can appear in a row of 4 or two rows of 2 depending on screen dimensions
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
    fontSize: 16,
    color: const Color(0xFFb6b8aa),
  );

//============ SCREEN WIDTH GOTTEN FROM TESTING ================================
  static const bigScreenMaxWidthLimit = 500;
  static const smallScreenContainerHeight = 120.0;
  static const bigScreenContainerHeight = 90.0;
//============ CONTAINER DIMENSIONS GOTTEN FROM TESTING ========================

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        ///Reducing the width by 8 since the higher wrap widget
        ///spaces them by 8 so, they just fit the screen
        var (containerHeight, containerWidth) =
            constraints.maxWidth <= bigScreenMaxWidthLimit
                ? (smallScreenContainerHeight, (constraints.maxWidth / 2) - 8)
                : (bigScreenContainerHeight, (constraints.maxWidth / 4) - 8);
        return Container(
          height: containerHeight,
          width: containerWidth,
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
        );
      },
    );
  }
}
