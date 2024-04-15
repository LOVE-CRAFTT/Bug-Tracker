import 'package:flutter/material.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/admin_pages/new_staff_page.dart';
import 'package:bug_tracker/admin_pages/new_project_page.dart';
import 'package:bug_tracker/admin_pages/update_password_page.dart';

///AppBar at the top of every page
AppBar adminReusableAppBar(String pageName, BuildContext context) {
  return AppBar(
    title: Text(
      pageName,
      style: kAppBarTextStyle,
    ),
    backgroundColor: Colors.black,
    actions: [
      /// Add new project or staff
      buildMenuAnchor(
        context: context,
        isAddButton: true,
        menuChildren: createMenuChildren(
          context,
          [
            ["New Project", const NewProjectPage()],
            ["New Staff", const NewStaffPage()],
          ],
          isUpdatePasswordPage: false,
        ),
      ),

      /// Update password
      buildMenuAnchor(
        context: context,
        isAddButton: false,
        menuChildren: createMenuChildren(
          context,
          [
            ["Update Password", const UpdatePasswordPage()]
          ],
          isUpdatePasswordPage: true,
        ),
      ),
    ],
  );
}

MenuAnchor buildMenuAnchor({
  required BuildContext context,
  required bool isAddButton,
  required List<Widget> menuChildren,
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
                  message: globalActorName,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Text(
                      getInitialsFromName(fullName: globalActorName),
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
    BuildContext context, List<List> buttonContents,
    {required isUpdatePasswordPage}) {
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
              SideSheet.right(
                context: context,
                width: MediaQuery.of(context).size.width *
                    (isUpdatePasswordPage == true ? 0.3 : 0.7),
                sheetColor: lightAshyNavyBlue,
                sheetBorderRadius: 10.0,
                body: detail.last,
              );
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
