import 'package:bug_tracker/utilities/constants.dart';
import 'package:flutter/material.dart';

///Contains the text field for starting conversations in the feed page
///Implemented as a row consisting of a circle avatar and a text field
class DiscussionTextField extends StatelessWidget {
  const DiscussionTextField({
    super.key,
    required this.constraints,
  });

  final BoxConstraints constraints;
  final _iconLeftPadding = 15.0;
  final _iconRightPadding = 20.0;
  _rightPadding(constraints) => constraints.maxWidth > 600 ? 150.0 : 50.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: _iconLeftPadding, right: _iconRightPadding),
          child: GestureDetector(
            child: const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Text("BC"),
            ),
            onTap: () {},
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: _rightPadding(constraints)),
            child: TextField(
              style: kContainerTextStyle.copyWith(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: "Start a discussion",
                hintStyle: kContainerTextStyle.copyWith(color: Colors.black45),
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white70,
              ),
              onChanged: (text) {},
              onSubmitted: (submitText) {},
            ),
          ),
        ),
      ],
    );
  }
}
