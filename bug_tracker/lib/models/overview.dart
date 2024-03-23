import 'package:flutter/material.dart';
import 'package:bug_tracker/ui_components/custom_navigation_rail.dart';

class Overview extends ChangeNotifier {
  void switchToBug() {
    selectedIndex = 4;
    notifyListeners();
  }

  void switchToMilestone() {
    selectedIndex = 6;
    notifyListeners();
  }
}
