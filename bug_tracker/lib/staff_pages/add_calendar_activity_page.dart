import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:bug_tracker/database/db.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/calendar_utils.dart';
import 'package:bug_tracker/ui_components/header_button.dart';

class AddCalendarActivityPage extends StatefulWidget {
  const AddCalendarActivityPage({
    super.key,
    required this.redrawParent,
  });

  final VoidCallback redrawParent;

  @override
  State<AddCalendarActivityPage> createState() =>
      _AddCalendarActivityPageState();
}

class _AddCalendarActivityPageState extends State<AddCalendarActivityPage> {
  final formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  String? activity;
  TextEditingController activityTextController = TextEditingController();

  //=======
  bool noDateError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Form(
              key: formKey,
              child: SizedBox(
                height: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              HeaderButton(
                                screenIsWide: true,
                                buttonText: 'Choose date',
                                onPress: () async {
                                  final date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: kFirstDay,
                                    lastDate: kLastDay,
                                  );
                                  if (date != null) {
                                    setState(
                                      () {
                                        selectedDate = date;
                                        noDateError = false;
                                      },
                                    );
                                  }
                                },
                              ),
                              if (noDateError)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10.0,
                                  ),
                                  child: Text(
                                    "Please enter a date!",
                                    style: kContainerTextStyle.copyWith(
                                      color: Colors.red,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          if (selectedDate != null)
                            Text(
                              ' : ${DateFormat('yyyy-MM-dd').format(selectedDate!)}',
                              style: kContainerTextStyle,
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          controller: activityTextController,
                          decoration: textFormFieldDecoration('Activity'),
                          expands: true,
                          maxLines: null,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter activity!';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            activity = value;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: HeaderButton(
                  screenIsWide: true,
                  buttonText: "Add activity",
                  onPress: () async {
                    if (formKey.currentState!.validate() &&
                        selectedDate != null) {
                      formKey.currentState!.save();

                      // attempt to add activity
                      bool success = await db.addCalendarActivity(
                        staffID: globalActorID,
                        date: selectedDate!,
                        title: activity!,
                      );

                      // if successful, redraw parent to show new activity
                      // if necessary then notify user
                      if (success) {
                        widget.redrawParent();
                        if (context.mounted) {
                          activityTextController.clear();
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Activity added successfully',
                                style: kContainerTextStyle.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        }
                      }
                      // else failure, notify user
                      else {
                        if (context.mounted) {
                          activityTextController.clear();
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Activity addition failed! Try again Later',
                                style: kContainerTextStyle.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        }
                      }
                    } else if (selectedDate == null) {
                      noDateError = true;
                      setState(() {});
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
