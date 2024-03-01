import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';

///AppBar at the top of every page
AppBar staffReusableAppBar(String pageName) {
  return AppBar(
    title: Text(
      pageName,
      style: kAppBarTextStyle,
    ),
    backgroundColor: Colors.black,
    actions: [
      Tooltip(
        message: "Search",
        textStyle: kAppBarTooltipTextStyle,
        child: const IconButton(
          onPressed: null,
          icon: Icon(
            Icons.search,
          ),
        ),
      ),
      Tooltip(
        message: "Timer",
        textStyle: kAppBarTooltipTextStyle,
        child: const IconButton(
          onPressed: null,
          icon: Icon(Icons.timer_sharp),
        ),
      ),
      Tooltip(
        message: "Notifications",
        textStyle: kAppBarTooltipTextStyle,
        child: const IconButton(
          onPressed: null,
          icon: Icon(Icons.notifications_none),
        ),
      ),
      Tooltip(
        message: "Settings",
        textStyle: kAppBarTooltipTextStyle,
        child: const IconButton(
          onPressed: null,
          icon: Icon(Icons.settings),
        ),
      ),
      GestureDetector(
        child: Tooltip(
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
        onTap: () {},
      ),
      const SizedBox(
        width: 10.0,
      )
    ],
  );
}
