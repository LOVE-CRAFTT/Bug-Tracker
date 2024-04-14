import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/fast_access_container.dart';
import 'package:bug_tracker/ui_components/large_container.dart';
import 'package:table_calendar/table_calendar.dart';

/// Set at sign in and shouldn't change
late int globalActorID;
late String globalActorName;
bool actorIsAdmin = false;
bool actorIsStaff = false;
bool actorIsUser = false;

///Width of a big screen, gotten from testing
///If screen goes lower than this, screen layout changes to accommodate
///[containerHeight] reduces, [FastAccessContainer]s realigns to have 3 maximum on a row
const bigScreenWidth = 712.0;

/// impossibly large number
int impossiblyLargeNumber = 9223372036854775807;

///TextStyle for the [reusableAppBar]
const kAppBarTextStyle = TextStyle(
  fontSize: 20.0,
  fontFamily: "Nunito",
  color: Color(0xFF979c99),
);

///TextStyle for checkboxes
TextStyle checkboxTextStyle = kContainerTextStyle.copyWith(color: Colors.white);

///TextStyle for [FastAccessContainer] and [LargeContainer]
const TextStyle kContainerTextStyle = TextStyle(
  fontSize: 16,
  fontFamily: "Nunito",
  color: Color(0xFFb6b8aa),
);

///TextStyle for each cell in the calendar except done/stated otherwise
const TextStyle kCalendarCellTextStyle = TextStyle(
  color: Color(0xFFFAFAFA),
  fontSize: 16.0,
  fontFamily: "Nunito",
);

///TextStyle for appbar tooltips
TextStyle kAppBarTooltipTextStyle = kContainerTextStyle.copyWith(
  color: Colors.black,
  fontSize: 14.0,
);

/// Decoration for all text form fields
InputDecoration textFormFieldDecoration(String hintText) => InputDecoration(
      border: const OutlineInputBorder(),
      hintText: hintText,
      hintStyle: kContainerTextStyle,
      isCollapsed: false,
      errorStyle: kContainerTextStyle.copyWith(
        color: Colors.red,
        fontSize: 15,
      ),
    );

/// Appbar for non "major" pages
AppBar genericTaskBar(String title) => AppBar(
      title: Text(
        title,
        style: kAppBarTextStyle,
      ),
      backgroundColor: Colors.black,
    );

CalendarStyle kCalendarStyle = CalendarStyle(
  outsideDaysVisible: false,
  defaultTextStyle: kContainerTextStyle,
  todayTextStyle: kCalendarCellTextStyle,
  selectedTextStyle: kCalendarCellTextStyle,
  rangeStartTextStyle: kCalendarCellTextStyle,
  rangeEndTextStyle: kCalendarCellTextStyle,
  weekendTextStyle: kCalendarCellTextStyle,
  markerDecoration: const BoxDecoration(
    color: Color(0xFFFF7F7F),
    shape: BoxShape.circle,
  ),
  todayDecoration: BoxDecoration(
    color: const Color(0xFFFF9B44),
    borderRadius: BorderRadius.circular(11.0),
  ),
  selectedDecoration: BoxDecoration(
    color: secondaryThemeColor,
    borderRadius: BorderRadius.circular(11.0),
  ),
  rangeStartDecoration: const BoxDecoration(
    color: Color(0xFFFF9B44),
    shape: BoxShape.circle,
  ),
  rangeEndDecoration: const BoxDecoration(
    color: Color(0xFFFF9B44),
    shape: BoxShape.circle,
  ),
  rangeHighlightColor: const Color(0xFFFFC05C),
  defaultDecoration: BoxDecoration(
    borderRadius: BorderRadius.circular(11.0),
  ),
  weekendDecoration: BoxDecoration(
    borderRadius: BorderRadius.circular(11.0),
  ),
);

HeaderStyle kCalendarHeaderStyle = const HeaderStyle(
  titleCentered: true,
  titleTextStyle: TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontFamily: "Nunito",
  ),
  formatButtonTextStyle: TextStyle(
    color: Colors.white,
    fontSize: 14.0,
    fontFamily: "Nunito",
  ),
  formatButtonDecoration: BoxDecoration(
    border: Border.fromBorderSide(
      BorderSide(
        color: secondaryThemeColor,
      ),
    ),
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
);

DaysOfWeekStyle kCalendarDOWStyle = const DaysOfWeekStyle(
  weekdayStyle: TextStyle(
    fontFamily: "Nunito",
    fontSize: 14.0,
    color: Color(0xFF6E6E6E),
  ),
  weekendStyle: TextStyle(
    fontFamily: "Nunito",
    fontSize: 14.0,
    color: Color(0xFF7F7F7F),
  ),
);

///Used as the secondary theme color to contrast from the grey/black background
const Color secondaryThemeColor = Color(0xFFFF6400);
const Color secondaryThemeColorGreen = Color(0xFF99FF00);
const Color secondaryThemeColorBlue = Color(0xFFADD8E6);
const Color lightAshyNavyBlue = Color(0xFF3D4042);

Map<String, Icon> navRailData = {
  'Home': const Icon(Icons.home),
  // 'Feed': const Icon(Icons.feed),
  'Discuss': const Icon(Icons.chat_outlined),
  'Calendar': const Icon(Icons.calendar_month),
  'Projects': const Icon(Icons.work_outline),
  'Bugs': const Icon(Icons.bug_report),
  'Tasks': const Icon(Icons.task_outlined),
  'Staff': const Icon(Icons.people_outlined),
};

List<NavigationRailDestination> kMainNavigationRailDestinations = [
  for (var value in navRailData.entries)
    NavigationRailDestination(
      icon: Tooltip(
        message: value.key,
        textStyle: kContainerTextStyle.copyWith(
          fontSize: 14.0,
          color: Colors.black,
        ),
        child: value.value,
      ),
      label: Text(
        value.key,
        style: const TextStyle(fontFamily: "Nunito"),
      ),
    ),
];

List<NavigationRailDestination> staffNavigationRailDestinations = [
  for (var value in [
    //task
    navRailData.entries.elementAt(6),
    //discuss
    navRailData.entries.elementAt(1),
    //calendar
    navRailData.entries.elementAt(2),
  ])
    NavigationRailDestination(
      icon: Tooltip(
        message: value.key,
        textStyle: kContainerTextStyle.copyWith(
          fontSize: 14.0,
          color: Colors.black,
        ),
        child: value.value,
      ),
      label: Text(
        value.key,
        style: const TextStyle(fontFamily: "Nunito"),
      ),
    ),
];

enum ProjectState {
  closed(title: "Closed", associatedColor: Colors.red),
  open(title: "Open", associatedColor: Colors.green),
  postponed(title: "Postponed", associatedColor: Colors.orange),
  cancelled(title: "Cancelled", associatedColor: Colors.grey);

  const ProjectState({required this.title, required this.associatedColor});
  final String title;
  final Color associatedColor;
}

enum ComplaintState {
  pending(title: "Pending", associatedColor: Colors.grey),
  acknowledged(title: "Acknowledged", associatedColor: Colors.lime),
  inProgress(title: "In Progress", associatedColor: Colors.blue),
  completed(title: "Completed", associatedColor: Colors.green);

  const ComplaintState({required this.title, required this.associatedColor});
  final String title;
  final Color associatedColor;
}

enum TaskState {
  fresh(title: "New", associatedColor: Colors.orange),
  inProgress(title: "In Progress", associatedColor: Colors.blue),
  transferred(title: "Transferred", associatedColor: Colors.deepPurple),
  received(title: "Received", associatedColor: Colors.pink),
  updated(title: "Updated", associatedColor: Colors.deepOrange),
  dueToday(title: "Due Today", associatedColor: Colors.yellow),
  completed(title: "Completed", associatedColor: Colors.green),
  overdue(title: "Overdue", associatedColor: Colors.red);

  const TaskState({required this.title, required this.associatedColor});
  final String title;
  final Color associatedColor;
}

enum Tags {
  ui(title: "UI", associatedColor: Colors.pink),
  functionality(title: "Functionality", associatedColor: Colors.brown),
  performance(title: "Performance", associatedColor: Colors.cyan),
  security(title: "Security", associatedColor: customMaroon),
  database(title: "Database", associatedColor: customOlive),
  network(title: "Network", associatedColor: Colors.lime);

  const Tags({required this.title, required this.associatedColor});
  final String title;
  final Color associatedColor;

  static const Color customMaroon = Color(0xFF800000);
  static const Color customOlive = Color(0xFF808000);
}

String complaintNotesPlaceholder =
    "Lorem ipsum dolor sit amet, consecrate disciplining elite. "
    "Sed non rises. Suspense lectures tortor, dissimilar sit amet, adipiscing nec, sultriness sed, dolor. "
    "Crash elementum ult-rices diam. Nascence gulag mass, various a, sempre tongue, modernism non, mi. "
    "Pron portion, orc nec nonhuman molest, enum est effendi mi, non ferment diam nil sit amet erat. "
    "Dis sempre. Dis arc mass, squelchier vitae, consequent in, premium a, enum. Interpellates tongue. "
    "Ut in rises volute libero pharaoh temper. Crash vestibule biennium argue. Present gestates leo in peed. "
    "Present bandit Podio eu enum. Interpellates sed dui ut argue bandit sodales. "
    "Vestibule ante ipsum primes in faucets orc quits et ult-rices exposure cub ilia Curae; Aliquot nib. "
    "Maris ac Lauris sed peed interpellates ferment. Nascence adipiscing ante non diam sodales ditherer.\n"
    "\nUt veldt Lauris, gestates sed, gravid nec, ornate ut, mi. Aeneas ut orc vel mass suspicious pulmonary. "
    "Null sollicitudin. Fuse various, gulag non tempus aliquam, nun turps ullamcorper nib, in tempus sapiens eros vitae gulag. "
    "Interpellates rhonchus nun et argue. Integer id fells. "
    "Curability aliquot interpellates diam. "
    "Integer quits metes vitae elite lobotomist gestates. "
    "Lorem ipsum dolor sit amet, consecrate adipiscing elite. "
    "Morbid vel erat non Lauris collision vehicular. Null et sapiens. "
    "Integer tortor tells, aliquot faucets, collision id, tongue eu, qualm. "
    "Maris ullamcorper fells vitae erat. "
    "Pron fugitive, argue non elementum exposure, metes purus oculist lectures, et critique gulag justo vitae magna.";

String projectDetailsPlaceHolder =
    "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, "
    "and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. "
    "No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, "
    "but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. "
    "Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, "
    "but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. "
    "To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? "
    "But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, "
    "or one who avoids a pain that produces no resultant pleasure?";
