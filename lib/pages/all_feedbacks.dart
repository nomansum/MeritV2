import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:merit_tuition_v1/utils/widgets/feedback_details.dart';
import 'package:merit_tuition_v1/utils/widgets/feedback_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllFeedbacks extends StatefulWidget {
  final dynamic studentId;
  final dynamic selectedLessonId;

  const AllFeedbacks({
    super.key,
    required this.studentId,
    required this.selectedLessonId,
  });

  @override
  State<AllFeedbacks> createState() => _AllFeedbacksState();
}

class _AllFeedbacksState extends State<AllFeedbacks> {
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

  @override
  void initState() {
    _getFeedback(widget.selectedLessonId);
    super.initState();
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
        'http://admin.merittutors.co.uk/api/feedback/${widget.studentId}/$lessonId');
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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'All Feedbacks',
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
        padding: const EdgeInsets.fromLTRB(15, 1, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Expanded(
              child: ListView.separated(
                itemCount: feedbackCount,
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
                    child: FeedbackWidget(
                      isPositive: feedbacks[index]['score'] >= 0 ? true : false,
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
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
