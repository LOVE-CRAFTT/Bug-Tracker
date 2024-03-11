import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/build_add_new_staff_page.dart';

///AppBar at the top of every page
AppBar adminReusableAppBar(String pageName, BuildContext context) {
  return AppBar(
    title: Text(
      pageName,
      style: kAppBarTextStyle,
    ),
    backgroundColor: Colors.black,
    actions: [
      IconButton(
        onPressed: () {},
        tooltip: "Notifications",
        icon: const Icon(Icons.notifications_none),
      ),
      MenuAnchor(
        style: MenuStyle(
          backgroundColor: const MaterialStatePropertyAll(
            lightAshyNavyBlue,
          ),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        menuChildren: [...createMenuChildren(context)],
        builder:
            (BuildContext context, MenuController controller, Widget? child) {
          return IconButton(
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
            tooltip: "Add",
            iconSize: 40.0,
            icon: const Icon(
              Icons.add_circle,
              color: Color(0xFFFF6400),
            ),
          );
        },
      ),
      Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Tooltip(
          message: "ChukwuemekaChukwudi9",
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Text(
              "BC",
              style: kContainerTextStyle.copyWith(color: Colors.black),
            ),
          ),
        ),
      ),
    ],
  );
}

List createMenuChildren(BuildContext context) {
  List<List> buttonStrings = [
    [
      "New Project",
      buildNewStaffPage,
    ],
    [
      "New Staff",
      buildNewStaffPage,
    ],
  ];

  return buttonStrings
      .map(
        (detail) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: MenuItemButton(
            style: TextButton.styleFrom(
              side: const BorderSide(
                color: secondaryThemeColorBlue,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            onPressed: () {
              detail.last(context: context);
            },
            child: Text(
              detail.first,
              style: kContainerTextStyle,
            ),
          ),
        ),
      )
      .toList();
}
