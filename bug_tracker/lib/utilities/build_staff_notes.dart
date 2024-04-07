import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';
import 'package:bug_tracker/utilities/load_staff_notes_source.dart';
import 'package:bug_tracker/ui_components/custom_circular_progress_indicator.dart';

/// Notes from staff
FutureBuilder buildStaffNotes({required int complaintID}) {
  return FutureBuilder(
    future: loadStaffNotesSource(complaintID: complaintID),
    builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CustomCircularProgressIndicator();
      } else {
        return ListView.builder(
          itemCount: staffNotesSource.length,
          itemBuilder: (BuildContext context, int index) {
            var note = staffNotesSource[index];
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
    },
  );
}
