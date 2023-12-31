import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:bug_tracker/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:bug_tracker/models/overview.dart';
import 'package:bug_tracker/pages/sign_in.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Overview()),
      ],
      child: const MyApp(),
    ),
  );
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
      home: SignInPage(),
    );
  }
}
