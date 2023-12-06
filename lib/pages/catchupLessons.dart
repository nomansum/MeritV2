// ignore: file_names
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:merit_tuition_v1/components/lesson.dart';
import 'package:merit_tuition_v1/components/lesson_response_model.dart';
import 'package:merit_tuition_v1/constants/colors.dart';
import 'package:merit_tuition_v1/utils/commonAppBar.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:merit_tuition_v1/constants/textstyles.dart';

class CatchupLesson extends StatefulWidget {
  final dynamic studentId;
  const CatchupLesson({required this.studentId, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CatchupLessonState createState() => _CatchupLessonState();
}

class _CatchupLessonState extends State<CatchupLesson> {
  final Dio dio = Dio();
  FToast toast = FToast();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController changedLessonDate = TextEditingController();
  final TextEditingController dateInput = TextEditingController();
  final TextEditingController dateInput1 = TextEditingController();
  Lesson? selectedDropDownItem;
  String selectedDropDownItemCatchUp = "";
  List<Lesson> list = [];
  List<LessonModel> allLessons = [];
  LessonModel? chosedLesson;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toast.init(context);
  }

  bool _isAuthenticated = false; // Simulated authentication status

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const CommonAppBar(appBarText: 'Catchup Lesson'),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Please Enter Necessary Information',
                  style: disabledTextStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  //  padding: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.width / 3,
                  child: Center(
                    child: TextField(
                      controller: dateInput,
                      //editing controller of this TextField
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.calendar_today),
                          labelText: "Enter Actual Date" //label text of field
                          ),
                      readOnly: true,
                      //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            dateInput.text =
                                formattedDate; //set output date to TextField value.
                          });
                          _getStudentLessonByDate();
                        } else {}
                      },
                    ),
                  ),
                ),
                list.length > 0
                    ? Container(
                        height: 150,
                        child: ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Icon(
                                  Icons.book,
                                  color: primaryColor,
                                ),
                                title: Text(
                                  list[index].name,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Start Time: ${list[index].start_time}",
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    Text(
                                      "Week Day: ${list[index].week_day}",
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ],
                                ),
                                trailing: Radio<Lesson>(
                                  value: list[index],
                                  groupValue: selectedDropDownItem,
                                  onChanged: (Lesson? value) {
                                    setState(() {
                                      selectedDropDownItem = value;
                                      print(selectedDropDownItem);
                                    });
                                  },
                                ),
                              );
                            }))
                    : const SizedBox(
                        height: 5,
                      ),

                // list.length > 0
                //     ? DropdownButton<Lesson>(
                //         value: selectedDropDownItem,
                //         icon: const Icon(Icons.arrow_downward_rounded),
                //         isExpanded: true,
                //         elevation: 16,
                //         style: const TextStyle(
                //             color: Color.fromARGB(255, 118, 114, 124)),
                //         underline: Container(
                //           height: 2,
                //           color: const Color.fromARGB(255, 133, 130, 143),
                //         ),
                //         onChanged: (Lesson? value) {
                //           print("Changed here");
                //           print(value);
                //           // This is called when the user selects an item.
                //           setState(() {
                //             selectedDropDownItem = value!;
                //           });
                //         },
                //         items:
                //             list.map<DropdownMenuItem<Lesson>>((Lesson value) {
                //           return DropdownMenuItem<Lesson>(
                //             value: value,
                //             child: Text(value.name),
                //           );
                //         }).toList(),
                //       )
                //     : const SizedBox(
                //         height: 5,
                //       ),
                Container(
                    //  padding: EdgeInsets.all(15),
                    height: MediaQuery.of(context).size.width / 3,
                    child: Center(
                        child: TextField(
                      controller: dateInput1,
                      //editing controller of this TextField
                      decoration: const InputDecoration(
                          border: const OutlineInputBorder(),
                          prefixIcon:
                              Icon(Icons.calendar_today), //icon of text field
                          labelText: "Enter Modified Date" //label text of field
                          ),
                      readOnly: true,
                      //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          setState(() {
                            dateInput1.text =
                                formattedDate; //set output date to TextField value.
                          });
                          await _getAllLessonByDate(
                              subjectId: selectedDropDownItem!.subject);
                          setState(() {});
                        } else {}
                      },
                    ))),

                allLessons.length > 0
                    ? Container(
                        height: 150,
                        child: ListView.builder(
                            itemCount: allLessons.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Icon(
                                  Icons.book,
                                  color: primaryColor,
                                ),
                                title: Text(
                                  allLessons[index].name,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Start Time: ${allLessons[index].start_time}",
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    Text(
                                      "Week Day: ${allLessons[index].week_day}",
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ],
                                ),
                                trailing: Radio<LessonModel>(
                                  value: allLessons[index],
                                  groupValue: chosedLesson,
                                  onChanged: (LessonModel? value) {
                                    setState(() {
                                      chosedLesson = value;
                                    });
                                  },
                                ),
                              );
                            }))
                    : const SizedBox(
                        height: 5,
                      ),

                // list.length > 0
                //     ? DropdownButton<String>(
                //         value: selectedDropDownItem,
                //         icon: const Icon(Icons.arrow_downward_rounded),
                //         isExpanded: true,
                //         elevation: 16,
                //         style: const TextStyle(
                //             color: Color.fromARGB(255, 118, 114, 124)),
                //         underline: Container(
                //           height: 2,
                //           color: const Color.fromARGB(255, 133, 130, 143),
                //         ),
                //         onChanged: (String? value) {
                //           // This is called when the user selects an item.
                //           setState(() {
                //             selectedDropDownItem = value!;
                //           });
                //         },
                //         items:
                //             list.map<DropdownMenuItem<String>>((String value) {
                //           return DropdownMenuItem<String>(
                //             value: value,
                //             child: Text(value),
                //           );
                //         }).toList(),
                //       )
                //     : SizedBox(
                //         height: 10,
                //       ),
                const SizedBox(height: 72),
                Container(
                  width: screenWidth,
                  height: screenHeight / 15,
                  //  heightFactor: 1.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (chosedLesson != null &&
                          selectedDropDownItem != null) {
                        _addCatchupLesson(selectedDropDownItem!, chosedLesson!);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary:
                          const Color(0xFF3AD4E1), // Background color (#3AD4E1)
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(5.0), // Border radius (5px)
                      ), // Button color
                    ),
                    child: const Text(
                      "Confirm Lesson Makeup",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addCatchupLesson(
      Lesson actualLesson, LessonModel modifiedLesson) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = await sharedPreferences.getString('token');

    dio.options.headers['Authorization'] = "Token $token";

    final formData = FormData.fromMap({
      "student": widget.studentId,
      "actual_lesson": actualLesson.id,
      "modified_lesson": modifiedLesson.id,
      "actual_date": dateInput.text,
      "modified_date": dateInput1.text,
    });

    try {
      Response response = await dio
          .post("http://35.176.201.155/api/add-catchup", data: formData);

      if (response.statusCode == 200) {
        toast.showToast(
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                  color: (Colors.greenAccent),
                  borderRadius: BorderRadius.circular(4)),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Center(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.black,
                    ),
                    Text(
                      "Catch Up Added Successfully.",
                      style: TextStyle(
                          color: Colors.black, overflow: TextOverflow.ellipsis),
                    ),
                  ],
                )),
              ),
            ),
            toastDuration: Duration(seconds: 1),
            gravity: ToastGravity.BOTTOM);
      }
    } on DioException catch (e, _) {
      toast.showToast(
          child: Container(
            height: 80,
            decoration: BoxDecoration(
                color: (Colors.red), borderRadius: BorderRadius.circular(4)),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Center(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cancel,
                    color: Colors.black,
                  ),
                  Text(
                    "Catch Up Failed.",
                    style: TextStyle(
                        color: Colors.black, overflow: TextOverflow.ellipsis),
                  ),
                ],
              )),
            ),
          ),
          toastDuration: Duration(seconds: 1),
          gravity: ToastGravity.BOTTOM);
    }
  }

  Future<void> _getStudentLessonByDate() async {
    print("STUDENT ID $widget.studentId");
    print(widget.studentId);

    // Simulated authentication logic - Replace with actual authentication

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = await sharedPreferences.getString('token');

    dio.options.headers['Authorization'] = "Token $token";

    Response response = await dio.get(
        'http://35.176.201.155/api/student-lessons/${widget.studentId}?date=${dateInput.text}');

    if (response.statusCode == 200) {
      dynamic result = response.data;
      list.clear();
      for (int i = 0; i < result.length; i++) {
        list.add(Lesson.fromMap(result[i]['lesson']));
      }
      selectedDropDownItem = list.first;
      setState(() {});

      return;
    } else {
      // ignore: use_build_context_synchronously
      // print(response.data);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something went wrong,please try again'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> _getAllLessonByDate({required int subjectId}) async {
    // Simulated authentication logic - Replace with actual authentication

    if (subjectId == null) {
      toast.showToast(
          child: Container(
            height: 80,
            decoration: BoxDecoration(
                color: (Colors.red), borderRadius: BorderRadius.circular(4)),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Center(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cancel,
                    color: Colors.black,
                  ),
                  Text(
                    "Looks Like Lesson Details Missing.",
                    style: TextStyle(
                        color: Colors.black, overflow: TextOverflow.ellipsis),
                  ),
                ],
              )),
            ),
          ),
          toastDuration: Duration(seconds: 1),
          gravity: ToastGravity.BOTTOM);
      return;
    }

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = await sharedPreferences.getString('token');

    dio.options.headers['Authorization'] = "Token $token";

    Response response = await dio.get(
        "http://35.176.201.155/api/lessons?date=${dateInput1.text}&subject=${subjectId}");

    if (response.statusCode == 200) {
      try {
        dynamic result = response.data;

        allLessons.clear();
        for (int i = 0; i < result.length; ++i) {
          allLessons.add(LessonModel(
              id: result[i]['id'],
              name: result[i]['name'],
              week_day: result[i]['week_day'],
              start_time: result[i]['start_time'],
              teacherId: 1));
        }
        chosedLesson = allLessons.first;

        return;
      } catch (e) {
        toast.showToast(
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                  color: (Colors.red), borderRadius: BorderRadius.circular(4)),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Center(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cancel,
                      color: Colors.black,
                    ),
                    Text(
                      "Looks Like Lesson Details Missing.",
                      style: TextStyle(
                          color: Colors.black, overflow: TextOverflow.ellipsis),
                    ),
                  ],
                )),
              ),
            ),
            toastDuration: Duration(seconds: 1),
            gravity: ToastGravity.BOTTOM);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something went wrong,please try again'),
        backgroundColor: Colors.red,
      ));
    }
  }
}
