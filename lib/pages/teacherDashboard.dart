import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import the http package.
import 'package:merit_tuition_v1/constants/text.dart';
import 'package:merit_tuition_v1/constants/colors.dart';
import 'package:merit_tuition_v1/utils/appBar.dart';
import 'package:merit_tuition_v1/utils/lessonWidget.dart';
import 'package:merit_tuition_v1/utils/wallet.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import for JSON parsing.

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  List<bool> isSelected = [true, false];
  String name = "";
  var isLoading = false;
  List<dynamic> lessons = [];

  Future<List<dynamic>> fetchLessons(String date) async {
    setState(() {
      isLoading = true;
    });
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');
      print(token);
      final url = date.isEmpty
          ? 'http://35.176.201.155/api/teacher-lessons'
          : 'http://35.176.201.155/api/teacher-lessons?date=$date';
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Token $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        setState(() {
          isLoading = false;
          lessons = jsonData;
        });
        return jsonData;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error i guess: $e');
      return [];
      // Return an empty list in case of an error.
    }
  }

  Future<void> _getName() async {
    // Simulated authentication logic - Replace with actual authentication
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    var url = Uri.parse('http://35.176.201.155/api/profile?userType=teacher');
    http.Response response = await http.get(
      url,
      headers: {
        'Authorization': 'Token $token', // Add the authorization header
      },
    );

    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> result = jsonDecode(response.body);

        setState(() {
          var user = result['user'];
          name = user['first_name'];
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
  void initState() {
    _getName();
    fetchLessons(DateTime.now().toString().split(" ")[0]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const TeacherDashboardAppbar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 15, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              welcomeText,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 22,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            //Wallet Widget
            walletWidget(size: size),

            ///toggle Buttons

            ToggleButtons(
              selectedColor: primaryColor,
              selectedBorderColor: primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              isSelected: isSelected,
              onPressed: (index) {
                setState(
                  () {
                    if (index == 0) {
                      isSelected[0] = true;
                      isSelected[1] = false;
                    } else {
                      isSelected[1] = true;
                      isSelected[0] = false;
                    }
                  },
                );
                final date = isSelected[0]
                    ? DateTime.now().toString().split(" ")[0]
                    : '';
                fetchLessons(date);
              },
              children: [
                Container(
                  width: size.width * .445,
                  //  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      todaysLesson,
                      style: TextStyle(
                        fontWeight:
                            isSelected[0] ? FontWeight.w700 : FontWeight.w400,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: size.width * .445,
                  //width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      allLesson,
                      style: TextStyle(
                        fontWeight:
                            isSelected[1] ? FontWeight.w700 : FontWeight.w400,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
            ),

            //Lesson List
            SingleChildScrollView(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var lesson in lessons)
                          Column(
                            children: [
                              lessonsWidget(
                                  size: size,
                                  subjectName: lesson["subject"]["name"],
                                  classTime: lesson["start_time"],
                                  lessonName: lesson["name"]),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          )
                      ],
                    ),
            ),
          ],
        ),
      ),
      drawer: const Drawer(),
    );
  }
}
