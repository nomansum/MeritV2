import 'package:flutter/material.dart';

class LessonIntroduction extends StatelessWidget {
  const LessonIntroduction({
    super.key,
    required this.lessonName,
    required this.level,
    required this.classroom,
    required this.weekDay,
    required this.time,
  });
  final String lessonName;
  final int level;
  final int classroom;

  final String weekDay;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 79, 203, 214),
        border: Border.all(
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                lessonName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const SizedBox(
            height: 05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.stairs,
                    color: Colors.black,
                    size: 16,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Level:$level',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.domain,
                    color: Colors.black,
                    size: 16,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Room:$classroom',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    color: Colors.black,
                    size: 16,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    weekDay,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    color: Colors.black,
                    size: 16,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    time,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 05,
          ),
        ],
      ),
    );
  }
}
