import 'dart:collection';
import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';
import 'package:bug_tracker/database/db.dart';
import 'package:bug_tracker/utilities/calendar_utils.dart';
import 'package:table_calendar/table_calendar.dart';

// linked hash map for ordered retrieval of events
LinkedHashMap calendarEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
);

Future<void> loadCalendarEvents({required int staffID}) async {
  // To be returned containing the processedEvents
  Map<DateTime, List<Event>> processedEvents = {};

  // get the events from the database
  Results? results = await db.getCalendarEvents(staffID: staffID);

  // helper function to get the date
  DateTime getDate({required DateTime dateTime}) {
    return DateTime.parse(DateFormat('yyyy-MM-dd').format(dateTime.toLocal()));
  }

  // if there are associated events
  if (results != null) {
    // process into events class
    for (ResultRow eventRow in results) {
      // dateTime without time
      DateTime date = getDate(dateTime: eventRow['date']);

      // if key i.e date is already in the map
      // then create a new event and add to the list of related events
      if (processedEvents.containsKey(date)) {
        processedEvents[date]?.add(
          Event(
            eventRow['id'],
            eventRow['event_title'],
          ),
        );
      }
      // else create a new key with the a new event
      else {
        processedEvents[date] = [
          Event(
            eventRow['id'],
            eventRow['event_title'],
          ),
        ];
      }
    }

    // clear calendar events then
    // create a linkedHashMap from processed event
    // and make that calendar events
    calendarEvents.clear();
    calendarEvents.addAll(processedEvents);
  }
  // else none return make calendarEvents empty map
  else {
    calendarEvents = LinkedHashMap.from({});
  }
}
