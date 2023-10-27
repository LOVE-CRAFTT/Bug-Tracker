import 'package:bug_tracker/utilities/constants.dart';
import 'package:flutter/material.dart';

class DiscussionTextField extends StatelessWidget {
  const DiscussionTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15, right: 20),
          child: Material(
            shape: CircleBorder(),
            color: Colors.grey,
            child: IconButton(
              onPressed: null,
              tooltip: "ChukwuemekaChukwudi9",
              icon: Icon(Icons.account_circle_outlined),
            ),
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              var rightPadding = constraints.maxWidth > 550 ? 150.0 : 50.0;
              return Padding(
                padding: EdgeInsets.only(right: rightPadding),
                child: TextField(
                  style: kContainerTextStyle.copyWith(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: "Start a discussion",
                    hintStyle:
                        kContainerTextStyle.copyWith(color: Colors.black45),
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white70,
                  ),
                  onChanged: (text) {},
                  onSubmitted: (submitText) {},
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
