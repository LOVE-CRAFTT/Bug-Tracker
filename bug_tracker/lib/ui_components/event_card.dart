import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/calendar_utils.dart';

///Event card for when a day is selected/focused on in the calendar page
class EventCard extends StatefulWidget {
  const EventCard({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: secondaryThemeColor,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        onTap: () => debugPrint(widget.event.toString()),
        title: Text('${widget.event}'),
        titleTextStyle: kContainerTextStyle,
      ),
    );
  }
}
