import 'package:bug_tracker/utilities/constants.dart';
import 'package:flutter/material.dart';

List<bool> isChecked = [true, false, true];

ListView buildMilestones({
  required bool isUpdatePage,
  required VoidCallback redraw,
}) {
  void Function(bool?)? setOnChangedIfIsUpdate(int index) {
    return isUpdatePage
        ? (bool? value) {
            isChecked[index] = value!;
            redraw();
          }
        : null;
  }

  TextStyle checkboxTextStyle =
      kContainerTextStyle.copyWith(color: Colors.white);

  List<CheckboxListTile> mileStoneSource = [
    CheckboxListTile(
      value: isChecked[0],
      onChanged: setOnChangedIfIsUpdate(0),
      title: Text(
        "Lorem ipsum dolor sit amet",
        style: checkboxTextStyle,
      ),
    ),
    CheckboxListTile(
      value: isChecked[1],
      onChanged: setOnChangedIfIsUpdate(1),
      title: Text(
        "Curability aliquot interpellates diam",
        style: checkboxTextStyle,
      ),
    ),
    CheckboxListTile(
      value: isChecked[2],
      onChanged: setOnChangedIfIsUpdate(2),
      title: Text(
        "Suspense lectures tort, dissimilar sit amet",
        style: checkboxTextStyle,
      ),
    ),
  ];

  return ListView.builder(
    itemCount: mileStoneSource.length,
    itemBuilder: (BuildContext context, int index) {
      return mileStoneSource[index];
    },
  );
}
