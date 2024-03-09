import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';

///AppBar at the top of every page
AppBar staffReusableAppBar(String pageName, BuildContext context) {
  return AppBar(
    title: Text(
      pageName,
      style: kAppBarTextStyle,
    ),
    backgroundColor: Colors.black,
    actions: [
      Tooltip(
        message: "Notifications",
        textStyle: kAppBarTooltipTextStyle,
        child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none),
        ),
      ),
      Tooltip(
        message: "Bill Gates",
        textStyle: kContainerTextStyle.copyWith(
          color: Colors.black,
        ),
        child: CircleAvatar(
          backgroundColor: Colors.grey,
          child: Text(
            "BG",
            style: kContainerTextStyle.copyWith(
              color: Colors.black,
            ),
          ),
        ),
      ),
      const SizedBox(
        width: 10.0,
      )
    ],
  );
}
