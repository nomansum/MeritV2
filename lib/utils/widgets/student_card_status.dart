import 'package:flutter/material.dart';

class StudentCardDetails extends StatelessWidget {
  final String heading;
  final String status;
  const StudentCardDetails(
      {super.key, required this.heading, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            heading,
            style: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
          ),
          Text(
            status,
            style: TextStyle(
                color: const Color(0xFF898989),
                fontSize: 12,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
