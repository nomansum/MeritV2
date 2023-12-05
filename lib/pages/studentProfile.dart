import 'dart:convert';

import 'package:merit_tuition_v1/constants/colors.dart';
import 'package:merit_tuition_v1/pages/catchupLessons.dart';
import 'package:merit_tuition_v1/pages/fees_details.dart';
import 'package:merit_tuition_v1/pages/lessons_details_page.dart';
import 'package:merit_tuition_v1/utils/commonAppBar.dart';
import 'package:merit_tuition_v1/utils/widgets/student_lessons.dart';
import 'package:flutter/material.dart';
import 'package:merit_tuition_v1/utils/widgets/student_personal_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class StudentProfile extends StatefulWidget {
  final dynamic studentId;
  final dynamic name;
  final dynamic email;
  final dynamic branch;
  final dynamic yearGroup;
  const StudentProfile({
    required this.studentId,
    required this.name,
    required this.email,
    required this.branch,
    required this.yearGroup,
    super.key,
  });

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  var lessonCount = 0;
  var lessons = [];
  var feedbacks = [];
  var homeworks = [];

  var selectedLesson = 0;
  var selectedLessonId;
  bool feedbackLoading = true;
  bool homeworkLoading = true;
  bool lessonLoading = true;
  var homeworkCount = 0;
  var feedbackCount = 0;

  @override
  void initState() {
    _getLessonDetails().whenComplete(() => lessonCount > 0
        ? _getFeedback(lessons[0]['id'])
            .whenComplete(() => _getHomework(lessons[0]['id']))
        : () {});
    super.initState();
  }

  Future<void> _getHomework(lessonId) async {
    print(widget.studentId);
    setState(() {
      homeworkLoading = true;
    });
    // Simulated authentication logic - Replace with actual authentication
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    var url = Uri.parse(
        'http://35.176.201.155/api/homework/${widget.studentId}/$lessonId');
    http.Response response = await http.get(
      url,
      headers: {
        'Authorization': 'Token $token', // Add the authorization header
      },
    );

    if (response.statusCode == 200) {
      try {
        dynamic result = jsonDecode(response.body);
        print(result);

        setState(() {
          homeworks = result;
          homeworkCount = result.length;
          homeworkLoading = false;
        });
      } catch (e) {
        print(response);
      }
      return;
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something went wrong,please try again'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> _getLessonDetails() async {
    print(widget.studentId);
    setState(() {
      lessonLoading = true;
    });
    // Simulated authentication logic - Replace with actual authentication
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    var url = Uri.parse(
        'http://35.176.201.155/api/student-lessons/${widget.studentId}');
    http.Response response = await http.get(
      url,
      headers: {
        'Authorization': 'Token $token', // Add the authorization header
      },
    );

    if (response.statusCode == 200) {
      try {
        dynamic result = jsonDecode(response.body);
        print(result);
        var lessonDetails = [];
        for (int i = 0; i < result.length; i++) {
          lessonDetails.add(result[i]['lesson']);
        }

        setState(() {
          lessonCount = result.length;
          lessons = lessonDetails;
          selectedLessonId = result[0]['lesson']['id'];
          if (lessonCount <= 0) {
            feedbackCount = 0;
            homeworkCount = 0;
          }
          lessonLoading = false;
        });
      } catch (e) {
        print(response);
      }
      return;
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong,please try again'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _getFeedback(lessonId) async {
    setState(() {
      feedbackLoading = true;
    });
    print(widget.studentId);
    // Simulated authentication logic - Replace with actual authentication
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    var url = Uri.parse(
        'http://35.176.201.155/api/feedback/${widget.studentId}/$lessonId');
    http.Response response = await http.get(
      url,
      headers: {
        'Authorization': 'Token $token', // Add the authorization header
      },
    );

    if (response.statusCode == 200) {
      try {
        dynamic result = jsonDecode(response.body);
        print("feedback:");
        print(result);

        setState(() {
          feedbacks = result;
          feedbackCount = result.length;
          feedbackLoading = false;
        });
      } catch (e) {
        print(response);
      }
      return;
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something went wrong,please try again'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CommonAppBar(appBarText: "Student Profile"),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(11, 10, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            studentPersonalInfo(
              size: size,
              studentImagePath: 'assets/parent.png',
              studentName: widget.name,
              location: widget.branch,
              lessonCount: lessonCount,
              yearGroup: widget.yearGroup,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Lessons',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            lessonLoading
                ? const Center(child: CircularProgressIndicator())
                : lessonCount <= 0
                    ? const Center(
                        child: Text("No Lessons found"),
                      )
                    : Expanded(
                        child: ListView.separated(
                          itemCount: lessons.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: double.infinity,
                              decoration: ShapeDecoration(
                                color: const Color(0x35E8914F),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),

                              // color: Colors.green,
                              child: LessonsWidget(
                                lessonName: lessons[index]['name'],
                                weekDay: lessons[index]['week_day'],
                                onPress: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return LessonDetailsPage(
                                          studentId: widget.studentId,
                                          // lessonId: lessons[index]['id'],
                                          selectedLessonIndex: index,
                                          selectedLessonId: lessons[index]
                                              ['id'],
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      child: Image.asset('assets/parent.png'),
                      maxRadius: 50,
                    ),
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FeesDetails(
                      studentId: widget.studentId,
                    ),
                  ),
                );
              },
              leading: const Icon(
                Icons.currency_pound,
                color: primaryColor,
              ),
              title: const Text("Fees"),
              subtitle: const Text(
                "Tab To See Fees Details",
                style: TextStyle(overflow: TextOverflow.ellipsis),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CatchupLesson(
                      studentId: widget.studentId,
                    ),
                  ),
                );
              },
              leading: const Icon(
                Icons.book_sharp,
                color: primaryColor,
              ),
              title: const Text("Catch Up Lesson"),
              subtitle: const Text(
                "Tab For Adding a Future Lesson",
                style: TextStyle(overflow: TextOverflow.ellipsis),
              ),
            )
          ],
        ),
      ),
    );
  }
}
