import 'package:flutter/material.dart';

class feesOverview extends StatelessWidget {
  final amount;
  final String descText;
  final Color color;
  const feesOverview(
      {super.key, this.amount, required this.descText, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 103,
      height: 90,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            width: 1.5,
            color: Color(0x33A9ABAC),
          ),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(05, 20, 0, 0),
            child: Text(
              '£$amount',
              style: TextStyle(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              '$descText',
              style: TextStyle(
                color: Color(0xFF898989),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
