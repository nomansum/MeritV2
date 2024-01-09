import 'package:flutter/material.dart';
import 'package:merit_tuition_v1/constants/colors.dart';

class parentProfileTitle extends StatelessWidget {
  final titleName;
  final IconData titleIcon;
  const parentProfileTitle({
    super.key,
    required this.titleName,
    required this.titleIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          titleName,
          style: TextStyle(color: primaryColor),
        ),
        Icon(
          titleIcon,
          color: primaryColor,
        ),
      ],
    );
  }
}
