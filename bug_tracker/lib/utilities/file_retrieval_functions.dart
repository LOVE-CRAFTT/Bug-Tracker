import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bug_tracker/database/db.dart';
import 'package:mysql1/mysql1.dart';
import 'package:bug_tracker/ui_components/file_preview_card.dart';

/// Get files related to a complaint
Future<List<File>> getFiles({required int complaintID}) async {
  List<File> complaintFiles;

  await db.connect();

  Results? results = await db.getComplaintFiles(complaintID: complaintID);

  // if there are any files
  if (results != null) {
    // clear files list
    complaintFiles = [];

    // convert them to file objects and put in list
    for (var fileRow in results) {
      complaintFiles.add(File(fileRow['file_path'].toString()));
    }
  }
  // else no files
  else {
    complaintFiles = [];
  }

  await db.close();

  return complaintFiles;
}

// Build the complaint files
FutureBuilder<List<File>> buildComplaintFiles({required int complaintID}) {
  // for sizing the file preview card
  // each is allotted 35
  int filePreviewSize = 35;

  return FutureBuilder(
    future: getFiles(complaintID: complaintID),
    builder: (BuildContext context, AsyncSnapshot<List<File>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      } else {
        int fileCount = snapshot.data!.length;
        return SizedBox(
          height: (filePreviewSize * fileCount).toDouble(),
          child: ListView.builder(
            itemCount: fileCount,
            itemBuilder: (BuildContext context, int index) {
              return FilePreviewCard(
                file: snapshot.data![index],
                // on delete doesn't apply
                // since not selecting files
                onDelete: null,
                isSelectingFiles: false,
              );
            },
          ),
        );
      }
    },
  );
}
