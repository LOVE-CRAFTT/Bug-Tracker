import 'package:bug_tracker/utilities/constants.dart';
import 'package:flutter/material.dart';

List<String?> choices = ["All Projects", "Project 1", "Project 2"];

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

  static Container noUnderline = Container(
    decoration: const BoxDecoration(border: Border()),
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white12,
          ),
          width: constraints.maxWidth,
          height: 50.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 10),
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
            underline: noUnderline,
            focusColor: Colors.transparent,
            style: kContainerTextStyle.copyWith(color: const Color(0xFFFF6400)),
          ),
        ),
      ],
    );
  }
}
