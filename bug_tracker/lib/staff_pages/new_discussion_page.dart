import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';
import 'package:bug_tracker/ui_components/header_button.dart';

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
  bool noParticipantError = false;

  ///
  List<bool> selectedStaff = List.filled(staffSource.length, false);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
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
              child: ListView.builder(
                itemCount: staffSource.length,
                itemBuilder: (BuildContext context, int index) {
                  return CheckboxListTile(
                    value: selectedStaff[index],
                    onChanged: (bool? value) {
                      selectedStaff[index] = value!;
                      setState(() {});
                    },
                    hoverColor: Colors.green,
                    title: Text(
                      "${staffSource[index].surname} ${staffSource[index].firstName ?? ""} ${staffSource[index].middleName ?? ""}",
                      style: checkboxTextStyle,
                    ),
                  );
                },
              ),
            ),
            if (noParticipantError) ...[
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Select at least one participant !",
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
                  onPress: () {
                    if (formKey.currentState!.validate()) {
                      if (selectedStaff.every((element) => element == false)) {
                        // no staff selected
                        noParticipantError = true;
                        setState(() {});
                      } else {
                        topicController.clear();
                        Navigator.pop(context);
                        //reset values
                        selectedStaff = List.filled(staffSource.length, false);
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
                        topic = null;
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
