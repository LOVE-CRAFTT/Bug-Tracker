import 'package:flutter/material.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:bug_tracker/utilities/constants.dart';

Future buildNewComplaintForm({
  required BuildContext context,
  required BoxConstraints constraints,
}) {
  return SideSheet.right(
    context: context,
    width: constraints.maxWidth * 0.9,
    sheetColor: lightAshyNavyBlue,
    sheetBorderRadius: 10.0,
    body: Center(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.green,
        ),
        height: 200.0,
        width: 200.0,
      ),
    ),
  );
}
