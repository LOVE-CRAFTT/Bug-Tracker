import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/appbar.dart';

class DiscussPage extends StatefulWidget {
  const DiscussPage({super.key});

  @override
  State<DiscussPage> createState() => _DiscussPageState();
}

class _DiscussPageState extends State<DiscussPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reusableAppBar("Discuss"),
      body: const Center(
        child: Text("Discuss contents"),
      ),
    );
  }
}
