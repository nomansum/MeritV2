import 'package:merit_tuition_v1/constants/colors.dart';

import 'package:flutter/material.dart';
import 'package:merit_tuition_v1/pages/fees_details.dart';

class studentBasicAcademicInfo extends StatelessWidget {
  final String selectedLessonName;
  final String lessonCount;
  final dynamic studentId;

  const studentBasicAcademicInfo(
      {super.key,
      required this.size,
      required this.selectedLessonName,
      required this.lessonCount,
      required this.studentId});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FeesDetails(
                            studentId: studentId,
                          )));
            },
            child: Container(
              // height: size.height * 0.04,
              // width: size.width * 0.25,
              decoration: ShapeDecoration(
                color: Color(0xFFE8914F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(7.5),
                child: Center(
                  child: Text(
                    "Fees",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
            ),
          ),
          Container(
            // height: size.height * 0.04,
            // width: size.width * 0.25,
            decoration: ShapeDecoration(
              color: Color(0xFFE8914F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(7.5),
              child: Center(
                child: Text(
                  selectedLessonName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ),
          Container(
            // height: size.height * 0.055,
            // width: size.width * 0.32,
            decoration: ShapeDecoration(
              color: Color(0xFFFB95E1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(7.5),
              child: Text(
                lessonCount,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
