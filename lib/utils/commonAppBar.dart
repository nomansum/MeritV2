
import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarText;
  const CommonAppBar({
    super.key,
    required this.appBarText,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: GestureDetector(
      //   onTap: () {},
      //   child: const Icon(
      //     Icons.keyboard_arrow_left,
      //     color: Colors.black,
      //   ),
      // ),
      title: Text(
        appBarText,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(55);
}