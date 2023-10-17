import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';

///Provides access to main work data
///Implemented as a container of fixed height and variable width
///Each container contains an appbar and Expanded body,
///Icons in the appbar adds functionality and the body contains the main data
class LargeContainer extends StatefulWidget {
  final String title;
  final List<IconData> icons;
  final Widget body;

  const LargeContainer({
    Key? key,
    required this.title,
    required this.icons,
    required this.body,
  }) : super(key: key);

  @override
  State<LargeContainer> createState() => _LargeContainerState();
}

class _LargeContainerState extends State<LargeContainer> {
  //===============VALUES FROM TESTING==========================================
  static const bigScreenMaxWidthLimit = 850;
  static const containerHeight = 400.0;
  //============================================================================

  //variable to show icons or not
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          ///Encompassing Wrap widget spaces them by 10 horizontally
          ///so the width is reduced by 10 so they can fit well
          var containerWidth = constraints.maxWidth <= bigScreenMaxWidthLimit
              ? constraints.maxWidth - 10.0
              : (constraints.maxWidth / 2) - 10.0;

          return DefaultTextStyle(
            style: kContainerTextStyle,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFF1e1e1e),
              ),
              height: containerHeight,
              width: containerWidth,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(Icons.close_sharp),
                      onPressed: () {
                        // Add your onPressed callback here
                      },
                    ),
                    title: Text(
                      widget.title,
                      style: kAppBarTextStyle,
                    ),
                    actions: _hover
                        ? widget.icons
                            .map(
                              (icon) => IconButton(
                                icon: Icon(icon),
                                onPressed: () {
                                  // Add your onPressed callback here
                                },
                              ),
                            )
                            .toList()
                        : [],
                  ),
                  Expanded(
                    child: Center(
                      child: widget.body,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
