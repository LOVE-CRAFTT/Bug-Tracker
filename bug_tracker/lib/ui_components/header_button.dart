import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';

class HeaderButton extends StatelessWidget {
  const HeaderButton({
    super.key,
    required this.screenIsWide,
    required this.buttonText,
    required this.onPress,
  });

  final bool screenIsWide;
  final String buttonText;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      ///Implemented this way so the tooltip doesn't show up if the button text is already visible
      message: screenIsWide ? "" : buttonText,
      child: ElevatedButton(
        onPressed: onPress,
        style: TextButton.styleFrom(
          backgroundColor: secondaryThemeColor,
          textStyle: kContainerTextStyle,
        ),
        child: screenIsWide ? Text(buttonText) : const Text("+"),
      ),
    );
  }
}
