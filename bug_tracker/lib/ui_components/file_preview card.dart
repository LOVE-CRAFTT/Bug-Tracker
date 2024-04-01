import 'package:flutter/material.dart';
import 'package:bug_tracker/utilities/constants.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

class FilePreviewCard extends StatelessWidget {
  const FilePreviewCard({
    super.key,
    required this.file,
    required this.onDelete,
    required this.isSelectingFiles,
  });

  final File file;
  final void Function() onDelete;

  /// so the user can only delete file when selecting and not when viewing
  final bool isSelectingFiles;

  String getFileName() {
    return file.path.split("\\").last;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // open/ start playing the file
        final openResult = await OpenFile.open(file.path);
        if (openResult.type != ResultType.done) {
          // Handle the error here
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Error opening file!',
                  style: kContainerTextStyle.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
            );
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        padding: const EdgeInsets.only(left: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.blueGrey.withAlpha(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getFileName(),
              style: kContainerTextStyle.copyWith(fontSize: 14),
            ),

            // if is selecting files the able to delete files
            if (isSelectingFiles)
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete),
              )
          ],
        ),
      ),
    );
  }
}
