import 'dart:io';
import 'package:file_picker/file_picker.dart';

Future<List<File>?> selectFiles() async {
  FilePickerResult? result =
      await FilePicker.platform.pickFiles(allowMultiple: true);

// The result will be null, if the user aborted the dialog
  if (result != null) {
    return result.paths.map((path) => File(path!)).toList();
  } else {
    return null;
  }
}
