import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      strokeWidth: 2.0,
      color: secondaryThemeColor,
    );
  }
}
