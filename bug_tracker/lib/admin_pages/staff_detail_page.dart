import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bug_tracker/utilities/staff.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/models/tasks_update.dart';
import 'package:bug_tracker/models/staff_updates.dart';
import 'package:bug_tracker/utilities/load_tasks_source.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';
import 'package:bug_tracker/models/component_state_updates.dart';
import 'package:bug_tracker/ui_components/task_preview_card.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:bug_tracker/ui_components/empty_screen_placeholder.dart';
import 'package:bug_tracker/ui_components/custom_circular_progress_indicator.dart';

class StaffDetailPage extends StatefulWidget {
  const StaffDetailPage({super.key, required this.staff});

  final Staff staff;

  @override
  State<StaffDetailPage> createState() => _StaffDetailPageState();
}

class _StaffDetailPageState extends State<StaffDetailPage> {
  late String updatedEmail;
  late String updatedSurname;
  String? updatedFirstName;
  String? updatedMiddleName;

  //==========
  bool updateEmailIntent = false;
  bool updateNameIntent = false;

  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  // for managing retrieved tasks length
  ScrollController scrollController = ScrollController();

  // will be increased if scroll to end
  int limit = 10;

  // listens for if staff has scrolled to end and generates more
  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          limit += 5;
          setState(() {});
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // watch in case the task is removed or just updated
    context.watch<TasksUpdate>();

    // watch to rebuild as the task State progresses
    context.watch<TaskStateUpdates>();

    // watch in case the staff details are updated or
    // staff is deleted
    context.watch<StaffUpdates>();
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
                      onPress: () {
                        showDeletionWarningAlert(context);
                      },
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
                    if (updateEmailIntent == false)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: HeaderButton(
                          screenIsWide: true,
                          buttonText: "Update",
                          onPress: () {
                            updateEmailIntent = true;
                            setState(() {});
                          },
                        ),
                      ),
                  ],
                ),
              ),

              /// update staff email if intended
              if (updateEmailIntent) ...[
                Container(
                  height: 180,
                  width: 500,
                  decoration: BoxDecoration(
                    color: lightAshyNavyBlue,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Form(
                    key: formKeys.first,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration:
                                textFormFieldDecoration("Updated Email"),
                            style: kContainerTextStyle.copyWith(
                                color: Colors.white),
                            validator: (lUpdatedEmail) {
                              if (lUpdatedEmail == null ||
                                  lUpdatedEmail.isEmpty) {
                                return "Updated email can't be empty";
                              }
                              updatedEmail = lUpdatedEmail;
                              return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                HeaderButton(
                                  screenIsWide: true,
                                  buttonText: "Done",
                                  onPress: () {
                                    if (formKeys.first.currentState!
                                        .validate()) {
                                      updateEmailIntent = false;

                                      context
                                          .read<StaffUpdates>()
                                          .updateStaffEmail(
                                            staffID: widget.staff.id,
                                            newEmail: updatedEmail,
                                          );

                                      setState(() {});
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Email Updated Successfully!',
                                            style: kContainerTextStyle.copyWith(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                HeaderButton(
                                  screenIsWide: true,
                                  buttonText: "Cancel",
                                  onPress: () {
                                    updateEmailIntent = false;
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],

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
                    if (updateNameIntent == false)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: HeaderButton(
                          screenIsWide: true,
                          buttonText: "Update",
                          onPress: () {
                            updateNameIntent = true;
                            setState(() {});
                          },
                        ),
                      ),
                  ],
                ),
              ),

              /// update staff name
              if (updateNameIntent) ...[
                Container(
                  height: 370,
                  width: 500,
                  decoration: BoxDecoration(
                    color: lightAshyNavyBlue,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Form(
                    key: formKeys.last,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: TextFormField(
                              decoration: textFormFieldDecoration("Surname"),
                              style: kContainerTextStyle.copyWith(
                                  color: Colors.white),
                              validator: (lUpdatedSurname) {
                                if (lUpdatedSurname == null ||
                                    lUpdatedSurname.isEmpty) {
                                  return "Updated surname can't be empty";
                                }
                                updatedSurname = lUpdatedSurname;
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: TextFormField(
                              decoration: textFormFieldDecoration("First Name"),
                              style: kContainerTextStyle.copyWith(
                                  color: Colors.white),
                              validator: (lUpdatedFirstName) {
                                if (lUpdatedFirstName == null ||
                                    lUpdatedFirstName.isEmpty) {
                                  return "Updated first name can't be empty";
                                }
                                updatedFirstName = lUpdatedFirstName;
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: TextFormField(
                              decoration:
                                  textFormFieldDecoration("Middle Name"),
                              style: kContainerTextStyle.copyWith(
                                  color: Colors.white),
                              validator: (lUpdatedMiddleName) {
                                if (lUpdatedMiddleName == null ||
                                    lUpdatedMiddleName.isEmpty) {
                                  return "Updated middle name can't be empty";
                                }
                                updatedMiddleName = lUpdatedMiddleName;
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                HeaderButton(
                                  screenIsWide: true,
                                  buttonText: "Done",
                                  onPress: () {
                                    if (formKeys.last.currentState!
                                        .validate()) {
                                      updateNameIntent = false;

                                      context
                                          .read<StaffUpdates>()
                                          .updateStaffName(
                                            staffID: widget.staff.id,
                                            surname: updatedSurname,
                                            firstName: updatedFirstName,
                                            middleName: updatedMiddleName,
                                          );
                                      setState(() {});

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Name Updated Successfully!',
                                            style: kContainerTextStyle.copyWith(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                HeaderButton(
                                  screenIsWide: true,
                                  buttonText: "Cancel",
                                  onPress: () {
                                    updateNameIntent = false;
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],

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
                  child: FutureBuilder(
                    future: loadTasksSourceByStaff(
                      staffID: widget.staff.id,
                      limit: limit,
                    ),
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CustomCircularProgressIndicator(),
                        );
                      } else {
                        return tasksSource.isNotEmpty
                            ? ListView.builder(
                                controller: scrollController,
                                itemCount: tasksSource.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return TaskPreviewCard(
                                    task: tasksSource[index],
                                  );
                                },
                              )
                            : const EmptyScreenPlaceholder();
                      }
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

Future showDeletionWarningAlert(BuildContext context) async => await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Staff Deletion Confirmation'),
        titleTextStyle: kContainerTextStyle.copyWith(
          color: Colors.white,
          fontSize: 20.0,
        ),
        content: const Text('WARNING! This action is irreversible'),
        contentTextStyle: kContainerTextStyle.copyWith(
          color: Colors.white,
          fontSize: 16.0,
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Proceed',
              style: kContainerTextStyle.copyWith(
                  fontSize: 14.0, color: Colors.blue),
            ),
            onPressed: () {
              ///TODO: Remove from database / mark as disabled
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Staff deleted successfully!",
                    style: kContainerTextStyle.copyWith(color: Colors.black),
                  ),
                ),
              );
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              'Cancel',
              style: kContainerTextStyle.copyWith(
                  fontSize: 14.0, color: Colors.blue),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
