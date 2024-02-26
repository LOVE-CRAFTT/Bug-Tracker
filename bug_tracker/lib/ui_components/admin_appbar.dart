import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';

///AppBar at the top of every page
AppBar adminReusableAppBar(String pageName) {
  return AppBar(
    title: Text(
      pageName,
      style: kAppBarTextStyle,
    ),
    backgroundColor: Colors.black,
    actions: [
      const IconButton(
        onPressed: null,
        tooltip: "Search",
        icon: Icon(
          Icons.search,
        ),
      ),
      const IconButton(
        onPressed: null,
        tooltip: "Timer",
        icon: Icon(Icons.timer_sharp),
      ),
      const IconButton(
        onPressed: null,
        tooltip: "Notifications",
        icon: Icon(Icons.notifications_none),
      ),
      const IconButton(
        onPressed: null,
        tooltip: "Settings",
        icon: Icon(Icons.settings),
      ),
      const IconButton(
        onPressed: null,
        tooltip: "Add",
        icon: Icon(
          Icons.add_circle,
          color: Color(0xFFFF6400),
        ),
      ),
      GestureDetector(
        child: const Tooltip(
          message: "ChukwuemekaChukwudi9",
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Text("BC"),
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
