import 'package:merit_tuition_v1/constants/imageStrings.dart';
import 'package:flutter/material.dart';

Map<int, String> subjectImages = {
  1: mathsPic,
  2: sciencePic,
  3: biologyPic,
  4: mathematicsPic,
  5: physicsPic,
};

class currentLessonCard extends StatelessWidget {
  final String lessonName;
  final String week_day;
  final int duration;
  final bool isSelected;
  final int idx;

  const currentLessonCard({
    super.key,
    required this.size,
    required this.lessonName,
    required this.week_day,
    required this.duration,
    required this.idx,
    required this.isSelected
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    String subjectImage = subjectImages[idx % 5] ?? sciencePic;
    return Container(
      decoration: ShapeDecoration(
        color: isSelected ? Color(0x35E8914F) : Color(0x35FB95E1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  subjectImage,
                  height: size.height * 0.08,
                  width: size.width * 0.08,
                ),
                Padding(
              padding: const EdgeInsets.only(left: 3.0),
              child: Text(
                'Day: $week_day',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                lessonName,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                '${duration/60} hours',
                style: TextStyle(
                  color: idx % 2 == 0 ? Color(0xFFE8914F) : Color(0xFFFB95E1),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}