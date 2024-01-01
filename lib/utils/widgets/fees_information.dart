import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FeesInformation extends StatelessWidget {
  final String heading;
  final String details;
  final bool isDue;
  final double dueBill;

  FeesInformation(
      {super.key,
      required this.heading,
      required this.details,
      required this.isDue,
      required this.dueBill});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: 40,
        width: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              heading,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: !isDue
                      ? (dueBill <= 0.0 ? Colors.black : Colors.red)
                      : (dueBill <= 0.001 ? Colors.black : Colors.red),
                  fontSize: 12,
                  fontWeight: FontWeight.w800),
            ),
            Text(
              details,
              style: TextStyle(
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                  color: isDue
                      ? (dueBill <= 0.001 ? Colors.black : Colors.red)
                      : Colors.black,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
