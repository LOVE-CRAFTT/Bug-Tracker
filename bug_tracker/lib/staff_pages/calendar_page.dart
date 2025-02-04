import 'package:flutter/material.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:bug_tracker/ui_components/staff_appbar.dart';
import 'package:bug_tracker/ui_components/event_card.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/calendar_utils.dart';
import 'package:bug_tracker/utilities/load_calendar_events.dart';
import 'package:bug_tracker/staff_pages/add_calendar_activity_page.dart';
import 'package:bug_tracker/ui_components/custom_circular_progress_indicator.dart';

/// Contains a calendar with tags showing events if available
/// User can select multiple days at once and set events for any day
/// Toggle select range by long pressing
/// Once a day is selected, If there are events to be shown a list of [EventCard]s with details is shown
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final ValueNotifier<List<Event>> _selectedEvents = ValueNotifier([]);
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return calendarEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: staffReusableAppBar("Calendar", context),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.0,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0,
                    left: 15.0,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      SideSheet.right(
                        context: context,
                        width: constraints.maxWidth * 0.7,
                        sheetColor: lightAshyNavyBlue,
                        sheetBorderRadius: 10.0,
                        body: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: AddCalendarActivityPage(
                            redrawParent: () {
                              setState(() {});
                            },
                          ),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: secondaryThemeColor,
                      textStyle: kContainerTextStyle,
                    ),
                    child: const Text("Add activity"),
                  ),
                ),
              ),
              FutureBuilder(
                future: loadCalendarEvents(staffID: globalActorID),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CustomCircularProgressIndicator(),
                    );
                  } else {
                    return TableCalendar<Event>(
                        firstDay: kFirstDay,
                        lastDay: kLastDay,
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedDay, day),
                        rangeStartDay: _rangeStart,
                        rangeEndDay: _rangeEnd,
                        calendarFormat: _calendarFormat,
                        rangeSelectionMode: _rangeSelectionMode,
                        eventLoader: _getEventsForDay,
                        startingDayOfWeek: StartingDayOfWeek.sunday,
                        calendarStyle: kCalendarStyle,
                        headerStyle: kCalendarHeaderStyle,
                        daysOfWeekStyle: kCalendarDOWStyle,
                        onDaySelected: _onDaySelected,
                        onRangeSelected: _onRangeSelected,
                        onFormatChanged: (format) {
                          if (_calendarFormat != format) {
                            setState(() {
                              _calendarFormat = format;
                            });
                          }
                        },
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        });
                  }
                },
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: ValueListenableBuilder<List<Event>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return EventCard(
                          event: value[index],
                          redraw: () => setState(() {}),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
