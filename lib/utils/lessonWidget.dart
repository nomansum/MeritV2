import 'package:flutter/material.dart';
import 'package:merit_tuition_v1/constants/imageStrings.dart';

class lessonsWidget extends StatelessWidget {
  final String subjectName;
  final classTime;
  final lessonName;
  final Map<String, String> subjectImages = {
    'MATHS': mathsPic,
    'SCIENCE': sciencePic,
    'BIOLOGY': biologyPic,
    'MATHEMATICS': mathematicsPic,
    'PHYSICS': physicsPic,
  };

  lessonsWidget({
    super.key,
    required this.size,
    required this.subjectName,
    required this.classTime,
    required this.lessonName,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    print(subjectName);
    return Container(
      height: size.height * 0.095,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: Colors.black.withOpacity(0.30),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Container(
                height: size.height * 0.073,
                width: size.width * 0.140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color(0x2821D8DE),
                ),
                child: Image.asset(subjectImages[subjectName] ?? mathsPic),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    lessonName.length > 22 ?
                    lessonName.substring(0,22) + ".."
                    : lessonName,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.timer,
                      color: Color(0xFF898989),
                      size: 18,
                    ),
                    Text(
                      classTime,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF898989),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.keyboard_arrow_right,
                color: Color(0xFF898989),
              ),
            )
          ],
        ),
      ),
    );
  }
}