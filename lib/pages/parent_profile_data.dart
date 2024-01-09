import 'package:flutter/material.dart';
import 'package:merit_tuition_v1/constants/colors.dart';

class parentProfileData extends StatelessWidget {
  final data;
  const parentProfileData({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(width: 1, color: primaryColor),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(data),
      ),
    );
  }
}
