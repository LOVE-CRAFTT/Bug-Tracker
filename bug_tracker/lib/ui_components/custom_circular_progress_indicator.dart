import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        color: secondaryThemeColor,
      ),
    );
  }
}
