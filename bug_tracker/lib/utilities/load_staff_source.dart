import 'package:mysql1/mysql1.dart';
import 'package:bug_tracker/database/db.dart';
import 'package:bug_tracker/utilities/staff.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';

Future<void> loadStaffSource() async {
  List<Staff> processedStaff = [];

  // get all staff from database
  Results? results = await db.getAllStaff();

  //if there are staff
  if (results != null) {
    // process into staff classes
    for (ResultRow staffRow in results) {
      processedStaff.add(
        Staff(
          id: staffRow['id'],
          surname: staffRow['surname'],
          firstName: staffRow['first_name'],
          middleName: staffRow['middle_name'],
          email: staffRow['email'],
        ),
      );
    }
    staffSource = processedStaff;
  }
  // else no staff
  else {
    staffSource = [];
  }
}

Future<List<Staff>> retrieveStaff() async {
  await loadStaffSource();
  return staffSource;
}
