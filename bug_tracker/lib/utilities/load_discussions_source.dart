import 'package:mysql1/mysql1.dart';
import 'package:bug_tracker/database/db.dart';
import 'package:bug_tracker/utilities/staff.dart';
import 'package:bug_tracker/utilities/discuss.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';

Future<void> loadDiscussionsSource({
  required int staffID,
  required int limit,
}) async {
  // to be populated
  List<Discuss> processedDiscussions = [];

  // helper function to get the discussion title
  Future<String?> getTitle({required int discussionID}) async {
    Results? result = await db.getDiscussionTitle(discussionID: discussionID);

    // if a title could be gotten
    if (result != null) {
      return result.first['title'];
    } else {
      return null;
    }
  }

  // helper function to get the staff
  Future<List<Staff>> getStaff({required int discussionID}) async {
    List<Staff> processedStaff = [];

    Results? results = await db.getAllParticipantsInDiscussion(
      discussionID: discussionID,
    );

    // if there are participants
    if (results != null) {
      // for each staff id get staff data, create staff
      // and add to the processed staff
      for (ResultRow staffIDRow in results) {
        Results? staffData = await db.getStaffDataUsingID(
          staffIDRow['staff_id'],
        );
        processedStaff.add(Staff.fromResultRow(staffRow: staffData!.first));
      }

      return processedStaff;
    }
    // else no participants return empty list
    else {
      processedStaff = [];
      return processedStaff;
    }
  }

  // =====BEGIN FUNCTION=======
  // get the id of all discussions that have staffID as participant
  Results? results = await db.getStaffDiscussions(
    staffID: staffID,
    limit: limit,
  );

  // if there are any discussions proceed
  if (results != null) {
    // for each gotten ID
    for (ResultRow idRow in results) {
      // get the discussion title
      String? title = await getTitle(discussionID: idRow['conversation_id']);

      //get all participants
      List<Staff> participants = await getStaff(
        discussionID: idRow['conversation_id'],
      );

      // create a new discuss object with the values
      // and populate the processedDiscussions list
      processedDiscussions.add(
        Discuss(
          id: idRow['conversation_id'],
          title: title!,
          participants: participants,
        ),
      );
    }

    discussionsSource = processedDiscussions;
  }
  // else not a participant in any discussions
  else {
    discussionsSource = [];
  }
}
