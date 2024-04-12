import 'package:mysql1/mysql1.dart';
import 'package:bug_tracker/database/db.dart';
import 'package:bug_tracker/utilities/project.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';

Future<void> loadProjectsSource({required int limit}) async {
  List<Project> processedProjects = [];

  //get all projects
  Results? results = await db.getAllProjects(limit: limit);

  //if there are projects
  if (results != null) {
    // process into project class
    for (ResultRow projectRow in results) {
      processedProjects.add(
        Project.fromResultRow(
          projectRow: projectRow,
        ),
      );
    }
    projectsSource = processedProjects;
  }
  // else no projects make projects source empty
  else {
    projectsSource = [];
  }
}
