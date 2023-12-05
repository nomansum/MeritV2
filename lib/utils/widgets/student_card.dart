import 'package:flutter/material.dart';
import 'package:merit_tuition_v1/components/student.dart';
import 'package:merit_tuition_v1/constants/colors.dart';
import 'package:merit_tuition_v1/constants/icons.dart';
import 'package:merit_tuition_v1/pages/studentProfile.dart';
import 'package:merit_tuition_v1/utils/widgets/student_card_status.dart';
import 'package:merit_tuition_v1/utils/widgets/student_card_status_with_icon.dart';

class StudentCard extends StatelessWidget {
  final Student student;

  const StudentCard({super.key, required this.student});
  dynamic _getImage() {
    if (this.student.user.photo != null) {
      return NetworkImage(this.student.user.photo);
    }
    return AssetImage('assets/parent.png');
  }

  dynamic _getId() {
    return student.id;
  }

  dynamic _getStudentDueFee() {
    return student.due.toString();
  }

  dynamic _getStudentsYearGroup() {
    return student.yearGroup;
  }

  dynamic _getStudentBranch() {
    return student.branch;
  }

  dynamic _getStudentMeritScore() {
    return student.score;
  }

  @override
  Widget build(BuildContext context) {
    print(this.student.id);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StudentProfile(
                      studentId: _getId(),
                      name:
                          '${student.user.firstName}  ${student.user.lastName}',
                      email: student.user.email,
                      branch: student.branch,
                      yearGroup: student.yearGroup,
                    )));
      },
      child: Card(
        color: primaryColor,
        elevation: 0.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: [
            Container(
              height: 81,
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                          child: CircleAvatar(
                            backgroundImage: _getImage(),
                            radius: 26,
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 40,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${student.user.firstName} ${student.user.lastName}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 70,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "\£${_getStudentDueFee()}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Text(
                            "Due Fee",
                            style: TextStyle(
                                color: const Color(0xFF898989),
                                fontSize: 11,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                    child: StudentCardDetails(
                        heading: "YEAR-GROUP",
                        status: "${_getStudentsYearGroup()}")),
                Flexible(
                    child: StudentCardDetails(
                        heading: "BRANCH", status: "${_getStudentBranch()}")),
                Flexible(
                    child: StudentCardDetails(
                        heading: "MERIT SCORE",
                        status: "${_getStudentMeritScore()}"))
              ],
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}
