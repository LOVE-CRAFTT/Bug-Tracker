import 'package:flutter/material.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/admin_pages/update_password_page.dart';

///AppBar at the top of every page
AppBar staffReusableAppBar(String pageName, BuildContext context) {
  return AppBar(
    title: Text(
      pageName,
      style: kAppBarTextStyle,
    ),
    backgroundColor: Colors.black,
    actions: [
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
                SideSheet.right(
                  context: context,
                  width: MediaQuery.of(context).size.width * 0.3,
                  sheetColor: lightAshyNavyBlue,
                  sheetBorderRadius: 10.0,
                  body: const UpdatePasswordPage(),
                );
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
                message: globalActorName,
                textStyle: kContainerTextStyle.copyWith(
                  color: Colors.black,
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Text(
                    getInitialsFromName(fullName: globalActorName),
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
