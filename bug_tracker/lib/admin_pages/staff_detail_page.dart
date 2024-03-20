import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/staff.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/ui_components/task_overview_card.dart';
import 'package:bug_tracker/ui_components/task_preview_card.dart';
import 'package:bug_tracker/ui_components/header_button.dart';

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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ID: ${widget.staff.id}",
                      style: kContainerTextStyle.copyWith(
                        fontSize: 14.0,
                      ),
                    ),
                    HeaderButton(
                      screenIsWide: true,
                      buttonText: "Delete",
                      onPress: () {},
                    ),
                  ],
                ),
              ),

              /// Staff email and edit
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Text(
                      "Email: ${widget.staff.email}",
                      style: kContainerTextStyle.copyWith(
                        fontSize: 15.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: HeaderButton(
                        screenIsWide: true,
                        buttonText: "Edit",
                        onPress: () {},
                      ),
                    ),
                  ],
                ),
              ),

              /// Staff Name and edit
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Text(
                      'Name: ${widget.staff.surname} ${widget.staff.firstName ?? ""} ${widget.staff.middleName ?? ""}',
                      style: kContainerTextStyle.copyWith(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: HeaderButton(
                        screenIsWide: true,
                        buttonText: "Edit",
                        onPress: () {},
                      ),
                    ),
                  ],
                ),
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

              /// Current tasks list
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    color: lightAshyNavyBlue,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    itemCount: tasksSource.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TaskPreviewCard(
                        task: tasksSource[index],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
