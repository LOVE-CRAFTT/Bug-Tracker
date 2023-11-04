import 'package:bug_tracker/utilities/constants.dart';
import 'package:flutter/material.dart';

List<String?> choices = ["All Projects", "Project 1", "Project 2"];

/// Dropdown button below the appbar on the feed page
/// For switching between multiple projects
/// Implemented as a dropdown button stacked on top of a lighter background
class FeedChoiceButton extends StatelessWidget {
  const FeedChoiceButton({
    super.key,
    required this.dropDownValue,
    required this.onChanged,
    required this.constraints,
  });

  final String? dropDownValue;
  final BoxConstraints constraints;
  final void Function(dynamic)? onChanged;

  ///Implemented this way to replace the default border with nothing
  static final Container _noUnderline = Container(
    decoration: const BoxDecoration(border: Border()),
  );

  final _leftPadding = 16.0;
  final _rightPadding = 10.0;
  final _lightBackgroundHeight = 50.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white12,
          ),
          width: constraints.maxWidth,
          height: _lightBackgroundHeight,
        ),
        Padding(
          padding: EdgeInsets.only(left: _leftPadding, right: _rightPadding),
          child: DropdownButton(
            value: dropDownValue,
            items: choices
                .map(
                  (value) => DropdownMenuItem(
                    value: value,
                    child: Text(value!),
                  ),
                )
                .toList(),
            onChanged: onChanged,
            underline: _noUnderline,
            focusColor: Colors.transparent,
            style: kContainerTextStyle.copyWith(color: const Color(0xFFFF6400)),
          ),
        ),
      ],
    );
  }
}
