import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';

class EmptyScreenPlaceholder extends StatelessWidget {
  const EmptyScreenPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "NONE",
        style: kContainerTextStyle.copyWith(
          fontSize: 25,
          color: secondaryThemeColorBlue.withAlpha(100),
        ),
      ),
    );
  }
}
