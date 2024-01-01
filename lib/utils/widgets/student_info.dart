import 'package:merit_tuition_v1/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:merit_tuition_v1/pages/fees_details.dart';

class studentPersonalInfo extends StatelessWidget {
  final String studentImagePath;
  final String studentName;
  final String location;
  final int lessonCount;
  final String yearGroup;
  final int stdId;

  const studentPersonalInfo({
    super.key,
    required this.size,
    required this.studentImagePath,
    required this.studentName,
    required this.location,
    required this.lessonCount,
    required this.yearGroup,
    required this.stdId,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.085,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size.height * 0.085,
            width: size.width * 0.170,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Image.asset(studentImagePath, fit: BoxFit.fill),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                studentName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FeesDetails(studentId: stdId),
                        ),
                      );
                    },
                    child: Container(
                      width: size.width * 0.22,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFE8914F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(03),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: 10,
                          child: Center(
                            child: Text(
                              'Fees',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  const Text('|'),
                  const SizedBox(
                    width: 2,
                  ),
                  Container(
                    width: size.width * 0.207,
                    decoration: ShapeDecoration(
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: FittedBox(
                        child: Text(
                          "$lessonCount Lessons",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 1,
                  ),
                  const Text('|'),
                  const SizedBox(
                    width: 1,
                  ),
                  Container(
                    width: size.width * 0.275,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFB95E1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: FittedBox(
                        child: Text(
                          "Year Group:$yearGroup",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
          // Container(
          //   height: size.height * 0.072,
          //   //width: size.width * 0.439,
          //   width: double.infinity,
          //   color: Colors.blue,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         studentName,
          //         style: const TextStyle(
          //           fontSize: 20,
          //           fontWeight: FontWeight.w700,
          //         ),
          //         overflow: TextOverflow.ellipsis,
          //         maxLines: 1,
          //         softWrap: false,
          //       ),
          //       Text(
          //         studentEmail,
          //         style: const TextStyle(
          //           color: Color(0xFF898989),
          //           fontSize: 16,
          //           fontWeight: FontWeight.w500,
          //           overflow: TextOverflow.ellipsis,
          //         ),
          //         overflow: TextOverflow.ellipsis,
          //         maxLines: 1,
          //         softWrap: false,
          //       )
          //     ],
          //   ),
          // ),
          // const Spacer(),
          // Container(
          //   width: size.width * 0.192,
          //   height: size.height * 0.036,
          //   decoration: ShapeDecoration(
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(05),
          //     ),
          //     color: primaryColor.withOpacity(0.2),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.all(3.0),
          //     child: Text(
          //       enrolledStatus,
          //       style: const TextStyle(
          //         color: primaryColor,
          //         fontWeight: FontWeight.w700,
          //         fontSize: 15,
          //       ),
          //       textAlign: TextAlign.center,
          //       maxLines: 1,
          //       overflow: TextOverflow.ellipsis,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
