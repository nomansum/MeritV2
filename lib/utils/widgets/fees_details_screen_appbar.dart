import 'package:flutter/material.dart';

class FeesAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final void Function() onTap;
  const FeesAppBar({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      elevation: 0.0,
      leading: GestureDetector(
        onTap: onTap,
        child: Icon(
          Icons.keyboard_arrow_left,
          size: 24,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Color(0xFF000000)),
      ),
      centerTitle: true,
      // actions: [
      //   GestureDetector(
      //       onTap: () {
      //         //filter button code
      //       },                          ///commented on 2 DEC
      //       child: Icon(Icons.filter_alt_outlined)),
      //   SizedBox(
      //     width: 5,
      //   )
      // ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50);
}
