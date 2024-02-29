import 'package:flutter/material.dart';

ListView buildMilestones({required bool isUpdate}) {
  bool isChecked = true;

  void Function(bool?)? setOnChangedIfIsUpdate() {
    return isUpdate
        ? (bool? value) {
            isChecked = value!;
          }
        : null;
  }

  List<CheckboxListTile> mileStoneSource = [
    CheckboxListTile(
      value: isChecked,
      onChanged: setOnChangedIfIsUpdate(),
      title: const Text("data"),
    ),
    CheckboxListTile(
      value: isChecked,
      onChanged: setOnChangedIfIsUpdate(),
      title: const Text("data"),
    ),
    CheckboxListTile(
      value: isChecked,
      onChanged: setOnChangedIfIsUpdate(),
      title: const Text("data"),
    ),
  ];

  return ListView.builder(
    itemCount: mileStoneSource.length,
    itemBuilder: (BuildContext context, int index) {
      return mileStoneSource[index];
    },
  );
}
