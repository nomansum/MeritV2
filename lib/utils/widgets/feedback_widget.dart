import 'package:flutter/material.dart';
import 'package:merit_tuition_v1/constants/imageStrings.dart';

class FeedbackWidget extends StatelessWidget {
  const FeedbackWidget({
    super.key,
    required this.isPositive,
    required this.onPress,
    required this.score,
  });

  final int score;
  final bool isPositive;

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(02, 03, 03, 02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 3.0, right: 5),
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  // color: const Color(0xFFFB95E1),
                  color: const Color(0xFFCBA3E5),

                  borderRadius: BorderRadius.circular(100),
                ),
                child: isPositive
                    ? Image.asset(happyEmoji)
                    : Image.asset(sadEmoji),
              ),
            ),
            const SizedBox(
              width: 05,
            ),
            Text.rich(
              TextSpan(
                children: [
                  //"Received a rating of +3."
                  TextSpan(
                    text:
                        'Earned ${isPositive ? "$score Positive Point.(Click to See Remarks)" : "$score Negative Point.(Click to See Remarks)"}  ',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              //  textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],

          // title: Text(
          //   '${isPositive ? "+1" : "-1"} was given by $teacherName',
          //   style: const TextStyle(
          //     fontSize: 18,
          //     color: Colors.black,
          //     fontWeight: FontWeight.w600,
          //   ),
          // ),

          // trailing: Container(
          //   height: 30,
          //   width: 30,
          //   decoration: BoxDecoration(
          //     color: Colors.black.withOpacity(0.2),
          //     borderRadius: BorderRadius.circular(100),
          //   ),
          //   child: const Icon(
          //     Icons.keyboard_arrow_right_outlined,
          //     color: Colors.black,
          //   ),
          // ),
        ),
      ),
    );
  }
}
/*
dget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your List Page'),
      ),
      body: ListView.builder(
        itemCount: items.length > 5 ? 6 : items.length,
        itemBuilder: (BuildContext context, int index) {
          if (index < 5) {
            // Display the first 5 items using ListTile
            return ListTile(
              title: Text(items[index]),
              // Add other content of your ListTile as needed
            );
          } else if (index == 5) {
            // Display the button for more items
            return ListTile(
              title: ElevatedButton(
                onPressed: () {
                  // Navigate to another page when the button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AnotherPage(items: items)),
                  );
                },
                child: Text('Click Here for More'),
              ),
            );
          }
          return Container(); // Return an empty container for other indices (should not be reached)
        },
      ),
    );
*/
