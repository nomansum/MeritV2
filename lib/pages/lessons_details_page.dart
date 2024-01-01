import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:merit_tuition_v1/constants/colors.dart';
import 'package:merit_tuition_v1/pages/all_feedbacks.dart';
import 'package:merit_tuition_v1/pages/all_homeworks.dart';
import 'package:merit_tuition_v1/utils/widgets/feedback_details.dart';
import 'package:merit_tuition_v1/utils/widgets/feedback_widget.dart';
import 'package:merit_tuition_v1/utils/widgets/homework_widget.dart';
import 'package:merit_tuition_v1/utils/widgets/hw_details.dart';
import 'package:merit_tuition_v1/utils/widgets/lesson_introduction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LessonDetailsPage extends StatefulWidget {
  final dynamic studentId;
  final dynamic selectedLessonId;
  final dynamic selectedLessonIndex;
  const LessonDetailsPage({
    super.key,
    required this.studentId,
    required this.selectedLessonId,
    required this.selectedLessonIndex,
  });

  @override
  State<LessonDetailsPage> createState() => _LessonDetailsPageState();
}

class _LessonDetailsPageState extends State<LessonDetailsPage> {
  var lessonCount = 0;
  List<Map<String, dynamic>> lessons = [];
  var feedbacks = [];
  var homeworks = [];

  var selectedLesson = 0;
  var selectedLessonIdd;
  bool feedbackLoading = true;
  bool homeworkLoading = true;
  bool lessonLoading = true;
  var homeworkCount = 0;
  var feedbackCount = 0;
  bool isLoading = true;
  List<Map<String, dynamic>> lessonsDetails = [];

  Future<void> _fetchData() async {
    await _getLessonDetails();
    if (lessonCount > 0) {
      await _getFeedback(widget.selectedLessonId);
      await _getHomework(widget.selectedLessonId);
    }
  }

  @override
  void initState() {
    _getLessonDetails().whenComplete(() => lessonCount > 0
        ? _getFeedback(widget.selectedLessonId).whenComplete(() {
            _getHomework(widget.selectedLessonId).whenComplete(() {
              isLoading = false;
              setState(() {});
            });
          })
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
        print('lesson Details:');
        print(result);

        for (int i = 0; i < result.length; i++) {
          lessonsDetails.add(result[i]['lesson']);
        }

        print('Now i am printing');
        //  print(lessonDetails);
        setState(() {
          lessonCount = result.length;
          lessons = lessonsDetails;

          selectedLessonIdd = result[0]['lesson']['id'];
          if (lessonCount <= 0) {
            feedbackCount = 0;
            homeworkCount = 0;
          }
          lessonLoading = false;
        });
        print('Lessons::::');
        print(lessons);
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
        'http://35.176.201.155/api/feedback/${widget.studentId}/${widget.selectedLessonId}');
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
    // int lessonIndex = lessonDetails.indexWhere((lesson) => lesson['id'] == 49);
    // String lessonName = lessons[lessonIndex]['name'];
    // print('Lesson Name: $lessonName');

    // print(widget.studentId);
    // print(widget.selectedLessonIndex);

    // print(widget.selectedLessonId);
    final size = MediaQuery.of(context).size;
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: primaryColor,
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.keyboard_arrow_left,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LessonIntroduction(
                  lessonName: lessons[widget.selectedLessonIndex]['name'],
                  level: lessons[widget.selectedLessonIndex]['level'],
                  classroom: lessons[widget.selectedLessonIndex]['classroom'],
                  weekDay: lessons[widget.selectedLessonIndex]['week_day'],
                  time: lessons[widget.selectedLessonIndex]['start_time'],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Feedbacks',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                feedbackCount == 0
                    ? const Center(
                        child: Text(
                          'No Feedback Found',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : Container(
                        // height: 185,
                        height: size.height * 0.250,
                        //  decoration: const BoxDecoration(color: Colors.blue),
                        child: ListView.separated(
                          itemCount: feedbackCount > 5 ? 6 : feedbackCount,
                          // itemCount: items.length > 5 ? 6 : items.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 03,
                            );
                          },
                          itemBuilder: (context, index) {
                            if (index < 5) {
                              return Container(
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  color: Colors.grey.shade400,
                                ),
                                child: FeedbackWidget(
                                  //checking if feedback is positive or negative

                                  isPositive: feedbacks[index]['score'] >= 0
                                      ? true
                                      : false,
                                  //will find out using score value of api call.
                                  score: feedbacks[index]['score'],

                                  onPress: () {
                                    feedbackDetails(
                                      context,
                                      size,
                                      feedbacks[index]['score'],
                                      feedbacks[index]['remarks'],
                                    );
                                  },
                                ),
                              );
                            } else if (index == 6) {
                              //IF Feedback item count is more than 5 ,then see more button will arise
                              return ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return AllFeedbacks(
                                          studentId: widget.studentId,
                                          selectedLessonId:
                                              widget.selectedLessonId,
                                        );
                                      },
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                ),
                                child: const Text('See More'),
                              );
                            }
                            return Container();
                          },
                        ),
                      ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Homeworks',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                homeworkCount == 0
                    ? const Center(
                        child: Text(
                          'No Homework Found',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : Container(
                        // height: 185,
                        height: size.height * 0.390,
                        //  decoration: const BoxDecoration(color: Colors.blue),
                        child: ListView.separated(
                          itemCount: homeworkCount > 5 ? 6 : homeworkCount,
                          // itemCount: items.length > 5 ? 6 : items.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 03,
                            );
                          },
                          itemBuilder: (context, index) {
                            if (index < 5) {
                              return Container(
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  color: Colors.grey.shade400,
                                ),
                                child: HomeworkWidget(
                                  size: size,
                                  hwText: homeworks[index]['homework'],
                                  dateTime: homeworks[index]['due_date'],
                                  onPress: () {
                                    homeworkDetails(
                                      context,
                                      size,

                                      homeworks[index]['due_date'], //dueDate
                                      homeworks[index]['homework'], //hw Text
                                    );
                                  },
                                ),
                              );
                            } else if (index == 6) {
                              //IF Feedback item count is more than 5 ,then see more button will arise
                              return ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return AllHomeworks(
                                          studentId: widget.studentId,
                                          selectedLessonId:
                                              widget.selectedLessonId,
                                        );
                                      },
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                ),
                                child: const Text('See More'),
                              );
                            }
                            return Container();
                          },
                        ),
                      )
              ],
            ),
          ),
        ),
      );
    }
  }
}
