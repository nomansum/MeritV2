import 'package:flutter/material.dart';
import 'package:merit_tuition_v1/utils/svg_to_icon.dart';

class ParentsBottomNavigationItem extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconPath;

  const ParentsBottomNavigationItem(
      {super.key, required this.onPressed, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPressed, icon: SvgIcon(path: iconPath));
  }
}
