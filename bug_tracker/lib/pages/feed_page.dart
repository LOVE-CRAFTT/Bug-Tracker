import 'package:bug_tracker/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/appbar.dart';

List<String?> choices = ["All Projects", "Project 1", "Project 2"];

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  String? dropDownValue = choices.first;

  Container noUnderline = Container(
    decoration: const BoxDecoration(border: Border()),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reusableAppBar("Feed"),
      body: ListView(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.white12,
                        ),
                        width: constraints.maxWidth,
                        height: 50.0,
                      );
                    },
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
                      onChanged: (selected) {
                        setState(() {
                          dropDownValue = selected;
                        });
                      },
                      underline: noUnderline,
                      focusColor: Colors.transparent,
                      style: kContainerTextStyle.copyWith(
                          color: const Color(0xFFFF6400)),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
