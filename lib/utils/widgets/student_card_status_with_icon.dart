import 'package:flutter/material.dart';
import 'package:merit_tuition_v1/utils/svg_to_icon.dart';

class StudentCardDetailsWithIcon extends StatelessWidget {
  final String heading;
  final String status;
  final String path;
  const StudentCardDetailsWithIcon(
      {super.key,
      required this.heading,
      required this.status,
      required this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            heading,
            style: const TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              SvgIcon(path: path),
              const SizedBox(
                width: 3,
              ),
              Text(
                status,
                style: const TextStyle(
                    color: Color(0xFF898989),
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
