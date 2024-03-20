import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/staff.dart';
import 'package:bug_tracker/utilities/constants.dart';

class StaffDetailPage extends StatefulWidget {
  const StaffDetailPage({super.key, required this.staff});

  final Staff staff;

  @override
  State<StaffDetailPage> createState() => _StaffDetailPageState();
}

class _StaffDetailPageState extends State<StaffDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: genericTaskBar("Staff Details"),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// staff ID
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "ID: ${widget.staff.id}",
                  style: kContainerTextStyle.copyWith(
                    fontSize: 14.0,
                  ),
                ),
              ),

              /// Staff email
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Email: ${widget.staff.email}",
                  style: kContainerTextStyle.copyWith(
                    fontSize: 15.0,
                  ),
                ),
              ),

              /// Staff Name
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                    'Name: ${widget.staff.surname} ${widget.staff.firstName ?? ""} ${widget.staff.middleName ?? ""}',
                    style: kContainerTextStyle.copyWith(
                      fontSize: 25.0,
                      color: Colors.white,
                    )),
              ),

              /// List of tasks the staff currently has
              ///
              /// Title
              const Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 20.0,
                ),
                child: Text(
                  "Current Tasks: ",
                  style: kContainerTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
