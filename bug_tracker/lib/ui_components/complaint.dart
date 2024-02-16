import 'package:flutter/material.dart';

class Complaint extends StatelessWidget {
  const Complaint({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
        bottom: 15.0,
      ),
      child: InkWell(
        onTap: () {},
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("#7633449872"),
            Text("COMPLAINT"),
            Text("Project Name"),
          ],
        ),
      ),
    );
  }
}
