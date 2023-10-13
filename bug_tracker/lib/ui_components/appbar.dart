import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';

AppBar reusableAppBar = AppBar(
  // leadingWidth: 100.0,
  // leading: const IconButton(
  //   onPressed: null,
  //   tooltip: "Show panel",
  //   icon: Icon(Icons.view_agenda),
  // ),
  title: const Text(
    "Home",
    style: kAppBarTextStyle,
  ),
  backgroundColor: Colors.black,
  actions: const [
    IconButton(
      onPressed: null,
      tooltip: "Search",
      icon: Icon(
        Icons.search,
      ),
    ),
    IconButton(
      onPressed: null,
      tooltip: "Timer",
      icon: Icon(Icons.timer_sharp),
    ),
    IconButton(
      onPressed: null,
      tooltip: "Notifications",
      icon: Icon(Icons.notifications_none),
    ),
    IconButton(
      onPressed: null,
      tooltip: "Settings",
      icon: Icon(Icons.settings),
    ),
    IconButton(
      onPressed: null,
      tooltip: "Add",
      icon: Icon(
        Icons.add_circle,
        color: Color(0xFFFF6400),
      ),
    ),
    Material(
      shape: CircleBorder(),
      color: Colors.grey,
      child: IconButton(
        onPressed: null,
        tooltip: "ChukwuemekaChukwudi9",
        icon: Icon(Icons.account_circle_outlined),
      ),
    ),
    SizedBox(
      width: 10.0,
    )
  ],
);
