import 'package:flutter/material.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:provider/provider.dart';
import 'package:bug_tracker/models/discussion_updates.dart';
import 'package:bug_tracker/staff_pages/new_discussion_page.dart';
import 'package:bug_tracker/ui_components/staff_appbar.dart';
import 'package:bug_tracker/ui_components/header_button.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:bug_tracker/utilities/discuss.dart';
import 'package:bug_tracker/utilities/core_data_sources.dart';
import 'package:bug_tracker/utilities/load_discussions_source.dart';
import 'package:bug_tracker/utilities/build_discuss_page_table_row.dart';
import 'package:bug_tracker/ui_components/empty_screen_placeholder.dart';
import 'package:bug_tracker/ui_components/custom_circular_progress_indicator.dart';

/// The discuss page is for starting conversations with individuals say for switching tasks between teams/individuals
/// Contains a button for starting new conversations and a search button
class DiscussPage extends StatefulWidget {
  const DiscussPage({super.key});

  @override
  State<DiscussPage> createState() => _DiscussPageState();
}

class _DiscussPageState extends State<DiscussPage> {
  // controller to manage list of discussions
  ScrollController scrollController = ScrollController();

  String searchBarString = '';

  int limit = 30;

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          limit += 10;
          setState(() {});
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // watch for when new discussions are added
    context.watch<DiscussionUpdates>();
    return Scaffold(
      appBar: staffReusableAppBar("Discuss", context),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var screenIsWide = constraints.maxWidth > 400;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeaderButton(
                      screenIsWide: screenIsWide,
                      buttonText: "New Discussion",
                      onPress: () {
                        SideSheet.right(
                          context: context,
                          width: constraints.maxWidth * 0.7,
                          sheetColor: lightAshyNavyBlue,
                          sheetBorderRadius: 10.0,
                          body: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: NewDiscussion(
                              constraints: constraints,
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 10.0,
                      ),
                      child: SearchBar(
                        leading: const Icon(Icons.search),
                        padding: const MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        ),
                        constraints: BoxConstraints(
                          maxHeight: 56.0,

                          /// The width is 40% of the screen is the screen is "wide"
                          /// Else it takes up 65%
                          maxWidth: screenIsWide
                              ? constraints.maxWidth * 0.4
                              : constraints.maxWidth * 0.65,
                        ),
                        hintText: "Search Discussions",
                        hintStyle: const MaterialStatePropertyAll<TextStyle>(
                          kContainerTextStyle,
                        ),
                        textStyle: MaterialStatePropertyAll<TextStyle>(
                          kContainerTextStyle.copyWith(color: Colors.white),
                        ),
                        onChanged: (input) {
                          searchBarString = input;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                FutureBuilder(
                  future: loadDiscussionsSource(
                    staffID: globalActorID,
                    limit: limit,
                  ),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CustomCircularProgressIndicator(),
                      );
                    } else {
                      // sort discussion titles source by searchbar string
                      List<Discuss> localDiscussionsSource = discussionsSource
                          .where((discussion) => discussion.title
                              .toUpperCase()
                              .contains(searchBarString.toUpperCase()))
                          .toList();
                      return localDiscussionsSource.isNotEmpty
                          ? SingleChildScrollView(
                              controller: scrollController,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: DefaultTextStyle(
                                  style: kContainerTextStyle.copyWith(
                                      fontSize: 14.0),
                                  child: Table(
                                    border: const TableBorder(
                                      horizontalInside: BorderSide(
                                        color: Color(0xFF979c99),
                                      ),
                                    ),
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    children: [
                                      TableRow(
                                        children: [...buildTableHeaders()],
                                      ),
                                      for (Discuss discussion
                                          in localDiscussionsSource)
                                        buildTableRow(
                                          discussion: discussion,
                                          context: context,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : const EmptyScreenPlaceholder();
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
