import 'dart:ffi';

import 'package:merit_tuition_v1/constants/colors.dart';
import 'package:merit_tuition_v1/constants/imageStrings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeworkCard extends StatelessWidget {
  final String descText;
  final String lessonName;
  final String date;
  const HomeworkCard({
    super.key,
    required this.descText,
    required this.lessonName,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        // padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        height: 75,
        width: double.infinity,
        decoration: ShapeDecoration(
          // color: Colors.grey.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side:const BorderSide(
              width: 1.5,
              color: Color(0x33A9ABAC),
            ),
          ),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                physicsPic,
                height: 75,
                width: 80,
                fit: BoxFit.cover,
              ),
             const SizedBox(
                width: 5,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      descText,
                      maxLines: 2, // Set the maximum number of lines

                      overflow: TextOverflow
                          .ellipsis, // Optional: You can use other values like TextOverflow.fade or TextOverflow.visible
                      style:const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  const  SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          sciencePic,
                          height: 13,
                          width: 13,
                        ),
                      const  SizedBox(
                          width: 3,
                        ),
                        Text(
                          "${lessonName} Lesson",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
             const SizedBox(
                width: 2,
              ),
              Column(
                children: [
                  // Spacer(),
                  Padding(
                    padding:const EdgeInsets.fromLTRB(2, 5, 2, 0),
                    child: Text(
                      date,
                      style:const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}