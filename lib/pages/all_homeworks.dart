import 'package:flutter/material.dart';
import 'package:merit_tuition_v1/utils/widgets/homework_widget.dart';
import 'package:merit_tuition_v1/utils/widgets/hw_details.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class AllHomeworks extends StatefulWidget {
  final dynamic studentId;
  final dynamic selectedLessonId;
  const AllHomeworks({
    super.key,
    required this.studentId,
    required this.selectedLessonId,
  });

  @override
  State<AllHomeworks> createState() => _AllFeedbacksState();
}

class _AllFeedbacksState extends State<AllHomeworks> {
  @override
  void initState() {
    _getHomework(widget.selectedLessonId);
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'All Homeworks',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Expanded(
              child: ListView.separated(
                itemCount: homeworkCount,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 05,
                  );
                },
                itemBuilder: (context, index) {
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
                          homeworks[index]['homework'],
                        );
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
