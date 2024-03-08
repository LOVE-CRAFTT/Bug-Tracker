import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';

///Provides a quick overview of open bugs, closed bugs,
///open milestones or closed milestones.
///Can appear in a row of 4 or two rows of 2 depending on screen dimensions
class FastAccessContainer extends StatelessWidget {
  final int number;
  final String text;
  final IconData icon;
  final void Function() onTapped;

  const FastAccessContainer({
    Key? key,
    required this.number,
    required this.text,
    required this.icon,
    required this.onTapped,
  }) : super(key: key);

//============ SCREEN WIDTH GOTTEN FROM TESTING ================================
  static const bigScreenMaxWidthLimit = 500;
  static const smallScreenContainerHeight = 110.0;
  static const bigScreenContainerHeight = 90.0;
//============ CONTAINER DIMENSIONS GOTTEN FROM TESTING ========================

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        ///Reducing the width by 8 since the higher wrap widget
        ///spaces them by 8 so, they just fit the screen
        var (containerHeight, containerWidth) =
            (bigScreenContainerHeight, (constraints.maxWidth / 2) - 8);
        return InkWell(
          onTap: onTapped,
          child: Container(
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
                      style: kContainerTextStyle,
                    ),
                    Icon(icon),
                  ],
                ),
                Text(
                  text,
                  style: kContainerTextStyle,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
