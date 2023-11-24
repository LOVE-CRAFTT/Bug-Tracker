import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/appbar.dart';

class BugsPage extends StatefulWidget {
  const BugsPage({super.key});

  @override
  State<BugsPage> createState() => _BugsPageState();
}

class _BugsPageState extends State<BugsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reusableAppBar("Bugs"),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // var screenIsWide = constraints.maxWidth > 400;
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: const [
                Placeholder(),
              ],
            ),
          );
        },
      ),
    );
  }
}
