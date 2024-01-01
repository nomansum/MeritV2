import 'package:flutter/material.dart';
import 'package:merit_tuition_v1/constants/imageStrings.dart';


class HomeworkWidget extends StatelessWidget {
  const HomeworkWidget({
    super.key,
    required this.hwText,
    required this.onPress,
    required this.dateTime,
    required this.size,
  });

  final String hwText;

  final String dateTime;
  final VoidCallback onPress;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(02, 03, 03, 02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 3.0, right: 5),
              child: Container(
                height: 25,
                width: 27,
                decoration: const BoxDecoration(
                  color: Color(0x35E8914F),

                  // borderRadius: BorderRadius.circular(100),
                ),
                child: Image.asset(hw2),
              ),
            ),
            const SizedBox(
              width: 05,
            ),
            Container(
              width: size.width * 0.55,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: hwText,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                //  textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                color: const Color(0x35E8914F),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                dateTime,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}