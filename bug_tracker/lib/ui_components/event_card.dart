import 'package:flutter/material.dart';
import 'package:bug_tracker/database/db.dart';
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
          onTap: () => debugPrint(widget.event.toString()),
          leading: _hover
              ? IconButton(
                  onPressed: () async {
                    // attempt to delete event
                    bool success = await db.deleteCalendarActivity(
                      id: widget.event.id,
                    );

                    // if successful then notify user
                    if (success) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Activity deleted successfully",
                              style: kContainerTextStyle.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      }
                    }
                    // else notify user of failure
                    else {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Couldn't delete activity! Try again Later",
                              style: kContainerTextStyle.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      }
                    }
                  },
                  splashRadius: 20.0,
                  icon: const Icon(Icons.close),
                )
              : null,
          title: Text('${widget.event}'),
          titleTextStyle: kContainerTextStyle,
        ),
      ),
    );
  }
}
