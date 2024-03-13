import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/build_update_password_page.dart';

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
        menuChildren: [
          Padding(
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
                buildUpdatePasswordPage(context: context);
              },
              child: const Text(
                "Update Password",
                style: kContainerTextStyle,
              ),
            ),
          )
        ],
        builder:
            (BuildContext context, MenuController controller, Widget? child) {
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: InkWell(
              onTap: () =>
                  controller.isOpen ? controller.close() : controller.open(),
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
            ),
          );
        },
      ),
    ],
  );
}
