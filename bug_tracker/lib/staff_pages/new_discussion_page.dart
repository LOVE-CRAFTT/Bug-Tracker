import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bug_tracker/utilities/staff.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';
import 'package:bug_tracker/utilities/load_staff_source.dart';
import 'package:bug_tracker/models/discussion_updates.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:bug_tracker/ui_components/custom_circular_progress_indicator.dart';

class NewDiscussion extends StatefulWidget {
  const NewDiscussion({super.key, required this.constraints});
  final BoxConstraints constraints;

  @override
  State<NewDiscussion> createState() => _NewDiscussionState();
}

class _NewDiscussionState extends State<NewDiscussion> {
  /// Topic text controller
  TextEditingController topicController = TextEditingController();

  ///
  String? topic;

  // If a participant is selected
  bool participantChoiceError = false;

  ///
  final formKey = GlobalKey<FormState>();

  ///
  List<Staff> selectedStaff = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// select topic
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TextFormField(
                decoration: textFormFieldDecoration("Topic"),
                style: kContainerTextStyle.copyWith(color: Colors.white),
                controller: topicController,
                validator: (lTopic) {
                  if (lTopic == null || lTopic.trim().isEmpty) {
                    return "Topic can't be empty";
                  }
                  topic = lTopic;
                  return null;
                },
              ),
            ),

            /// Select participants
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                "Select Participants",
                style: kContainerTextStyle.copyWith(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
            Container(
              height: widget.constraints.maxHeight - 300,
              decoration: BoxDecoration(
                border: Border.all(
                  color: secondaryThemeColor.withAlpha(100),
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: FutureBuilder(
                future: loadStaffSource(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CustomCircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: staffSource.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CheckboxListTile(
                          value: selectedStaff.contains(staffSource[index]),
                          onChanged: (value) {
                            if (value == true) {
                              selectedStaff.add(staffSource[index]);
                            } else {
                              selectedStaff.remove(staffSource[index]);
                            }
                            setState(() {});
                          },
                          hoverColor: Colors.green.withAlpha(40),
                          title: Text(
                            getFullNameFromNames(
                              surname: staffSource[index].surname,
                              firstName: staffSource[index].firstName,
                              middleName: staffSource[index].middleName,
                            ),
                            style: checkboxTextStyle,
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            if (participantChoiceError) ...[
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Select at least two participants yourself included!",
                  style: kContainerTextStyle.copyWith(
                    color: Colors.red,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: HeaderButton(
                  screenIsWide: true,
                  buttonText: "Start",
                  onPress: () async {
                    if (formKey.currentState!.validate()) {
                      // if less than 2 staff is chosen
                      // or current staff is not chosen, error
                      if (selectedStaff.length < 2 ||
                          selectedStaff.every(
                            (staff) => staff.id != globalActorID,
                          )) {
                        // no staff selected
                        participantChoiceError = true;
                        setState(() {});
                      } else {
                        // attempt to start the new discussion
                        await context.read<DiscussionUpdates>().startDiscussion(
                              topic: topic!,
                              participants: selectedStaff,
                            );

                        //reset values and notify user
                        if (context.mounted) {
                          topicController.clear();
                          selectedStaff = [];
                          topic = null;
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Conversation started",
                                style: kContainerTextStyle.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        }
                      }
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
