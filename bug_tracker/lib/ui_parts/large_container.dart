import 'package:flutter/material.dart';

// class LargeContainer extends StatelessWidget {
//   final String title;
//   final List<IconData> icons;
//
//   const LargeContainer({
//     Key? key,
//     required this.title,
//     required this.icons,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         color: const Color(0xFF1e1e1e),
//       ),
//       padding: const EdgeInsets.all(10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.close),
//                 onPressed: () {
//                   // Add your onPressed callback here
//                 },
//               ),
//               Text(title),
//               Row(
//                 children: icons
//                     .map(
//                       (icon) => IconButton(
//                         icon: Icon(icon),
//                         onPressed: () {
//                           // Add your onPressed callback here
//                         },
//                       ),
//                     )
//                     .toList(),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
class LargeContainer extends StatefulWidget {
  final String title;
  final List<IconData> icons;
  final Widget body;

  const LargeContainer({
    Key? key,
    required this.title,
    required this.icons,
    required this.body,
  }) : super(key: key);

  @override
  State<LargeContainer> createState() => _LargeContainerState();
}

class _LargeContainerState extends State<LargeContainer> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFF1e1e1e),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  // Add your onPressed callback here
                },
              ),
              title: Text(widget.title),
              actions: _hover
                  ? widget.icons
                      .map(
                        (icon) => IconButton(
                          icon: Icon(icon),
                          onPressed: () {
                            // Add your onPressed callback here
                          },
                        ),
                      )
                      .toList()
                  : [],
            ),
            Expanded(child: widget.body),
          ],
        ),
      ),
    );
  }
}
