import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/appbar.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reusableAppBar("Feed"),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "Here, depending on the specific project, you can see discussions made by people"),
            Text(
              "Example would be like discussions regarding clarity on approach to a problem",
            ),
            Text(
              "General milestone completion",
            ),
            Text(
              "Other colleagues activities",
            ),
            Text(
              "Announcements",
            )
          ],
        ),
      ),
    );
  }
}
