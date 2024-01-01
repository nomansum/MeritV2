import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merit_tuition_v1/constants/colors.dart';
import 'package:merit_tuition_v1/constants/imageStrings.dart';

class TeacherDashboardAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const TeacherDashboardAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 15, 0),
          child: badges.Badge(
            badgeContent: const Text(
              '4',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            child: SvgPicture.asset(notificationIcon),
            position: badges.BadgePosition.topEnd(),
            badgeStyle: badges.BadgeStyle(
              badgeColor: notificationIconColor,
            ),
            onTap: () {},
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(55);
}