import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merit_tuition_v1/constants/colors.dart';
import 'package:merit_tuition_v1/constants/imageStrings.dart';
import 'package:badges/badges.dart' as badges;

import '../svg_to_icon.dart';

class ParentsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool notificationAvailable;
  final int notificationCount;
  const ParentsAppBar(
      {super.key,
      required this.notificationAvailable,
      required this.notificationCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: [
          // Stack(
          //   children: [
          //     IconButton(
          //       icon: const SvgIcon(path: notificationIcon),
          //       onPressed: () {
          //         // NOTIFICATIN CODE
          //       },
          //     ),
          //     notificationAvailable
          //         ? Positioned(
          //             right: 8,
          //             top: 0,
          //             child: Container(
          //               padding: const EdgeInsets.all(3),
          //               decoration: const BoxDecoration(
          //                 shape: BoxShape.circle,
          //                 color: Color(notificationColor),
          //               ),
          //               constraints: const BoxConstraints(
          //                   minWidth: 0,
          //                   minHeight: 0,
          //                   maxHeight: 25,             ///commented at 2 DEC client does not need notification.
          //                   maxWidth: 25),
          //               child: Padding(
          //                 padding: const EdgeInsets.all(1.0),
          //                 child: Text(
          //                   notificationCount
          //                       .toString(), // Number of notifications
          //                   style: const TextStyle(
          //                     color: Colors.white,
          //                     fontSize: 8,
          //                   ),
          //                   textAlign: TextAlign.center,
          //                 ),
          //               ),
          //             ),
          //           )
          //         : const SizedBox()
          //   ],
          // ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}
