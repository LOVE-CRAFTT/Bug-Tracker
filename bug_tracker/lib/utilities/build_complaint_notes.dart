import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';

/// Notes from staff
ListView buildNotes() {
  return ListView.builder(
    itemCount: noteSource.length,
    itemBuilder: (BuildContext context, int index) {
      var note = noteSource[index];
      return Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          bottom: 8.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: secondaryThemeColorGreen,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(
              note,
              style: kContainerTextStyle.copyWith(
                color: Colors.white70,
              ),
            ),
          ),
        ),
      );
    },
  );
}

/// Lorem ipsum notes
List<String> noteSource = [
  "ACTION PLAN \n"
      "Step 1: \n"
      "Step 2: \n",
  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
  "Cras justo odio, dapibus ac facilisis in, egestas eget quam. Maecenas faucibus mollis interdum. Curabitur blandit tempus porttitor. Donec id elit ut sapien sagittis rhoncus vitae malesuada quam. Sed posuere consectetur est at lobortis.",
  "Nulla vitae elit libero, a pharetra augue. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Curabitur blandit tempus porttitor. Nullam quis risus eget urna mollis ornare vel eu leo. Donec id elit ut sapien sagittis rhoncus.",
  "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Pellentesque in ipsum id orci porta dapibus. Proin eget tortor risus. Aliquam malesuada diam in augue luctus ullamcorper.",
  "Quisque porta lorem ipsum, quis blandit leo vehicula et. Phasellus sit amet libero velit. Maecenas faucibus mollis interdum. Praesent sapien massa, convallis a pharetra vel, euismod ac dui. Donec rutrum congue leo eget malesuada.",
  "Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Vestibulum id ligula porta felis euismod semper. Pellentesque in ipsum id orci porta dapibus.",
  "Nulla mollis aliquam sem quis laoreet. Curabitur blandit tempus porttitor. Donec id elit ut sapien sagittis rhoncus vitae malesuada quam. Nunc pulvinar leo augue, quis molestie tortor tincidunt eget. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.",
  "Sed posuere consectetur est at lobortis. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Nam eget mauris eu odio laoreet malesuada. Phasellus sit amet ipsum id orci porta dapibus. In hac habitasse platea dictumst.",
  "Nam eget mauris eu odio laoreet malesuada. Praesent sapien massa, convallis a pharetra vel, euismod ac dui. Donec rutrum congue leo eget malesuada. Praesent commodo cursus magna, vel scelerisque nisl consectetur a.",
  "Pellentesque in ipsum id orci porta dapibus. Cras mattis consectetur purus sit amet fermentum. Proin eget tortor risus. Integer posuere erat a ante blandit tincidunt. Nullam quis risus eget urna mollis ornare vel eu leo.",
  "Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Vivamus sagittis lacus vel augue laoreet rutrum.",
  "Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Curabitur blandit tempus porttitor. Vestibulum id ligula porta felis euismod semper. Phasellus sit amet ipsum id orci porta dapibus. Pellentesque in ipsum id orci porta dapibus.",
  "Nulla mollis aliquam sem quis laoreet. Nullam quis risus eget urna mollis ornare vel eu leo. Donec id elit ut sapien sagittis rhoncus vitae malesuada quam. Nunc pulvinar leo augue, quis molestie tortor tincidunt eget.",
  "Suspendisse potenti. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Donec quis odio dui. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat"
];
