import 'package:flutter/material.dart';

class LessonsWidget extends StatelessWidget {
  const LessonsWidget({
    super.key,
    required this.lessonName,
    required this.weekDay,
    required this.onPress,
  });

  final String lessonName;
  final String weekDay;

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          // color: const Color(0xFFFB95E1),
          color: const Color(0xFFCBA3E5),

          borderRadius: BorderRadius.circular(100),
        ),
        child: const Icon(
          Icons.book_rounded,
          color: Colors.white,
        ),
      ),
      title: Text(
        lessonName,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Row(
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
              fontWeight: FontWeight.w400,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      trailing: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Icon(
          Icons.keyboard_arrow_right_outlined,
          color: Colors.black,
        ),
      ),
    );
  }
}
