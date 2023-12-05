import 'package:flutter/material.dart';
import 'package:merit_tuition_v1/constants/colors.dart';

Future<dynamic> homeworkDetails(
    BuildContext context, Size size, String dateTime, String hwText) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return SizedBox(
        height: size.height * 0.43,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Homework',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  color: Colors.grey.shade400,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'Due Date:$dateTime ',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Text:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
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
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
