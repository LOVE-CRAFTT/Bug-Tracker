import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/build_add_new_staff_page.dart';
import 'package:bug_tracker/utilities/build_add_new_project_page.dart';
import 'package:bug_tracker/utilities/build_update_password_page.dart';

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

      /// Add new project or staff
      buildMenuAnchor(
        context: context,
        isAddButton: true,
        menuChildren: createMenuChildren(
          context,
          [
            ["New Project", buildNewProjectPage],
            ["New Staff", buildNewStaffPage],
          ],
        ),
      ),

      /// Update password
      buildMenuAnchor(
        context: context,
        isAddButton: false,
        menuChildren: createMenuChildren(
          context,
          [
            ["Update Password", buildUpdatePasswordPage]
          ],
        ),
        username: "ChukwuemekaChukwudi9",
        userInitials: "BC",
      ),
    ],
  );
}

MenuAnchor buildMenuAnchor({
  required BuildContext context,
  required bool isAddButton,
  required List<Widget> menuChildren,
  String username = "",
  String userInitials = "",
}) {
  return MenuAnchor(
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
    menuChildren: menuChildren,
    builder: (BuildContext context, MenuController controller, Widget? child) {
      return isAddButton
          ? IconButton(
              onPressed: () =>
                  controller.isOpen ? controller.close() : controller.open(),
              tooltip: "Add",
              iconSize: 40.0,
              icon: const Icon(
                Icons.add_circle,
                color: Color(0xFFFF6400),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: InkWell(
                onTap: () =>
                    controller.isOpen ? controller.close() : controller.open(),
                child: Tooltip(
                  message: username,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Text(
                      userInitials,
                      style: kContainerTextStyle.copyWith(color: Colors.black),
                    ),
                  ),
                ),
              ),
            );
    },
  );
}

List<Padding> createMenuChildren(
    BuildContext context, List<List> buttonContents) {
  return buttonContents
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
