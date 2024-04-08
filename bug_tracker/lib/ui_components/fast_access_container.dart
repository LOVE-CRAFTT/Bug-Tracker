import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/models/overview.dart';
import 'package:bug_tracker/utilities/load_complaints_source.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';
import 'package:bug_tracker/ui_components/custom_circular_progress_indicator.dart';

///Provides a quick overview of open bugs, closed bugs,
///open milestones or closed milestones.
///Can appear in a row of 4 or two rows of 2 depending on screen dimensions
class FastAccessContainer extends StatelessWidget {
  final FastAccessContainerTypes type;

  const FastAccessContainer({
    Key? key,
    required this.type,
  }) : super(key: key);

//============ SCREEN WIDTH GOTTEN FROM TESTING ================================
  static const bigScreenMaxWidthLimit = 500;
  static const smallScreenContainerHeight = 110.0;
  static const bigScreenContainerHeight = 90.0;
//============ CONTAINER DIMENSIONS GOTTEN FROM TESTING ========================

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        ///Reducing the width by 8 since the higher wrap widget
        ///spaces them by 8 so, they just fit the screen
        var (containerHeight, containerWidth) =
            (bigScreenContainerHeight, (constraints.maxWidth / 2) - 8);
        return InkWell(
          onTap: () {
            context.read<Overview>().switchToBug();
          },
          child: Container(
            height: containerHeight,
            width: containerWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFF1e1e1e),
            ),
            padding: const EdgeInsets.all(8),
            child: FutureBuilder(
              future: getBugNumbers(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CustomCircularProgressIndicator(),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            type == FastAccessContainerTypes.openBugs
                                ? snapshot.data!.first.toString()
                                : snapshot.data!.last.toString(),
                            style: kContainerTextStyle,
                          ),
                          const Icon(Icons.bug_report_outlined),
                        ],
                      ),
                      Text(
                        type.title,
                        style: kContainerTextStyle,
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}

// function to retrieve actual bug numbers
Future<List<int>> getBugNumbers() async {
  // impossibly high numbers as workaround
  await loadComplaintsSource(limit: impossiblyLargeNumber);

  int openBugsLength = complaintsSource
      .where(
        (complaint) => complaint.complaintState != ComplaintState.completed,
      )
      .length;

  int closedBugsLength = complaintsSource
      .where(
        (complaint) => complaint.complaintState == ComplaintState.completed,
      )
      .length;

  return [openBugsLength, closedBugsLength];
}

enum FastAccessContainerTypes {
  openBugs(title: "Open Bugs"),
  closedBugs(title: "Closed Bugs");

  const FastAccessContainerTypes({
    required this.title,
  });
  final String title;
}
