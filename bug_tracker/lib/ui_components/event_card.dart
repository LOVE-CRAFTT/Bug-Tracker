import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/calendar_utils.dart';

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
  bool _hover = false;

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
      child: MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: ListTile(
          onTap: () => print(widget.event),
          leading: _hover
              ? IconButton(
                  onPressed: () {},
                  splashRadius: 20.0,
                  icon: const Icon(Icons.close),
                )
              : null,
          title: Text('${widget.event}'),
        ),
      ),
    );
  }
}
