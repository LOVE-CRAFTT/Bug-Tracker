import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bug_tracker/models/overview.dart';
import 'package:bug_tracker/models/component_state_updates.dart';
import 'package:bug_tracker/models/staff_notes_updates.dart';
import 'package:bug_tracker/models/tasks_update.dart';
import 'package:bug_tracker/database/db.dart';
import 'package:bug_tracker/sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // in case of hot restart always check if already connected
  // and close before connecting so as to
  // prevent multiple connection attempts
  if (db.isConnected()) {
    await db.close();
  }
  await db.connect();

  // now check if our new connection attempt was successful
  if (db.isConnected()) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Overview()),
          ChangeNotifierProvider(create: (_) => ComplaintStateUpdates()),
          ChangeNotifierProvider(create: (_) => TaskStateUpdates()),
          ChangeNotifierProvider(create: (_) => TasksUpdate()),
          ChangeNotifierProvider(create: (_) => StaffNotesUpdates()),
        ],
        child: const MyApp(),
      ),
    );
  }
  // else error
  else {
    debugPrint("Error connecting to database");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        useMaterial3: false,
      ),
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      title: 'Bug tracker',
      home: const SignInPage(),
    );
  }
}
