import 'dart:async';
import 'package:mysql1/mysql1.dart';
import 'package:flutter/material.dart';
import 'package:bug_tracker/database/db.dart';
import 'package:bug_tracker/utilities/constants.dart';

Future<ComplaintState> getCurrentComplaintState(
    {required int complaintID}) async {
  // to be returned
  ComplaintState complaintState;

  await db.connect();

  Results? result = await db.getComplaintData(complaintID);

  // if there is such a complaint
  if (result != null) {
    complaintState = ComplaintState.values.firstWhere(
      (state) => state.title == result.first['complaint_state'],
    );
  }
  // error retrieving the state return pending and debugPrint error
  else {
    debugPrint("Error getting state");
    complaintState = ComplaintState.pending;
  }

  await db.close();
  return complaintState;
}
