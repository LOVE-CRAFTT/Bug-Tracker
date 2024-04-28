import 'package:mysql1/mysql1.dart';
import 'package:bug_tracker/database/db.dart';
import 'package:bug_tracker/utilities/tools.dart';
import 'package:bug_tracker/ui_components/message_bubble.dart';

Future<List<MessageBubble>> retrieveMessages({
  required int discussionID,
}) async {
  // to be populated
  List<MessageBubble> processedMessages = [];

  Results? results = await db.getMessages(
    discussionID: discussionID,
  );

  // there are messages
  if (results != null) {
    // process each into messageBubbles
    for (ResultRow messageRow in results) {
      // get staff data here since can't get in constructor
      Results? result = await db.getStaffDataUsingID(messageRow['staff_id']);
      ResultRow staffRow = result!.first;

      processedMessages.add(
        MessageBubble(
          sender: getFullNameFromNames(
            surname: staffRow['surname'],
            firstName: staffRow['first_name'],
            middleName: staffRow['middle_name'],
          ),
          senderID: messageRow['staff_id'],
          text: messageRow['message'].toString(),
        ),
      );
    }

    return processedMessages;
  }
  // no messages return an empty list
  else {
    return [];
  }
}
