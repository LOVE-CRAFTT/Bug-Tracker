import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/staff.dart';

class StaffPreviewCard extends StatelessWidget {
  const StaffPreviewCard({
    super.key,
    required this.staff,
  });

  final Staff staff;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: secondaryThemeColor,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 30,
            child: Text(
              staff.initials,
              style: kContainerTextStyle.copyWith(
                color: Colors.black,
              ),
            ),
          ),
          title: Text('ID: ${staff.id}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Name: ${staff.surname + (staff.firstName ?? "") + (staff.middleName ?? "")}'),
              Text('Email: ${staff.email}'),
            ],
          ),
          titleTextStyle: kContainerTextStyle.copyWith(fontSize: 12.0),
          subtitleTextStyle: kContainerTextStyle.copyWith(fontSize: 18.0),
          onTap: () {},
        ),
      ),
    );
  }
}
