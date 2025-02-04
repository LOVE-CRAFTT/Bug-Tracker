import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/staff.dart';
import 'package:bug_tracker/admin_pages/staff_detail_page.dart';

/// Naming convention in this project dictates a difference between overview and preview cards
/// Overview cards are for when the card contents are the "main focus" of that view/context
/// For example [TaskOverviewCard] is what staff sees however, the admin sees the [TaskPreviewCard] in the bug_detail_page
///
/// Preview cards are the opposite of Overview cards
class StaffOverviewCard extends StatelessWidget {
  const StaffOverviewCard({
    super.key,
    required this.staff,
  });

  final Staff staff;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
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
                'Name: ${staff.surname} ${staff.firstName ?? ""} ${staff.middleName ?? ""}',
              ),
              Text(
                'Email: ${staff.email}',
              ),
            ],
          ),
          titleTextStyle: kContainerTextStyle.copyWith(fontSize: 12.0),
          subtitleTextStyle: kContainerTextStyle.copyWith(fontSize: 18.0),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StaffDetailPage(
                  staff: staff,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
