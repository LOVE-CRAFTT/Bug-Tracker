import 'package:bug_tracker/utilities/constants.dart';
import 'package:flutter/material.dart';

class DiscussionTextField extends StatelessWidget {
  const DiscussionTextField({
    super.key,
    required this.constraints,
  });

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    var rightPadding = constraints.maxWidth > 550 ? 150.0 : 50.0;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 20),
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
            padding: EdgeInsets.only(right: rightPadding),
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
