// ignore: file_names
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:merit_tuition_v1/components/branch.dart';
import 'package:merit_tuition_v1/components/levels.dart';
import 'package:merit_tuition_v1/components/schools.dart';
import 'package:merit_tuition_v1/components/student.dart';
import 'package:merit_tuition_v1/constants/colors.dart';
import 'package:merit_tuition_v1/pages/loginPage.dart';
import 'package:merit_tuition_v1/pages/parents_dashboard.dart';
import 'package:merit_tuition_v1/utils/modifiedTextFieldForDate.dart';
import 'package:merit_tuition_v1/utils/widgets/custom_dropdown_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:merit_tuition_v1/constants/textstyles.dart';
import 'package:merit_tuition_v1/utils/modifiedTextField.dart';

class AddStudentPage extends StatefulWidget {
  final User user;

  const AddStudentPage({super.key, required this.user});

  @override
  // ignore: library_private_types_in_public_api
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();
  final TextEditingController _postCodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _assessmentDateController =
      TextEditingController();
  DateTime dobDate = DateTime.now();
  DateTime assesmentDate = DateTime.now();
  Dio dio = Dio();
  List<String>? branches;
  List<String>? levels;
  List<String>? schools;
  List<Branch> fetchedBranches = [];
  List<School> fetchedSchools = [];

  List<Level> fetchedLevels = [];
  static const List<String> fetchedAddresses = <String>[
    "1 The Warren, , , , , London, ",
    "10 The Warren, , , , , London, ",
    "11 The Warren, , , , , London, ",
    "12 The Warren, , , , , London, ",
    "13 The Warren, , , , , London, ",
    "14 The Warren, , , , , London, ",
    "15 The Warren, , , , , London, ",
    "16 The Warren, , , , , London, ",
    "17 The Warren, , , , , London, ",
    "17A The Warren, , , , , London, ",
    "18 The Warren, , , , , London, ",
    "19 The Warren, , , , , London, ",
    "2 The Warren, , , , , London, ",
    "20 The Warren, , , , , London, ",
    "20A The Warren, , , , , London, ",
    "20b The Warren, , , , , London, ",
    "20c The Warren, , , , , London, ",
    "21 The Warren, , , , , London, ",
    "22 The Warren, , , , , London, ",
    "23 The Warren, , , , , London, ",
    "24 The Warren, , , , , London, ",
    "25 The Warren, , , , , London, ",
    "26 The Warren, , , , , London, ",
    "27 The Warren, , , , , London, ",
    "28 The Warren, , , , , London, ",
    "28A The Warren, , , , , London, ",
    "28B The Warren, , , , , London, ",
    "3 The Warren, , , , , London, ",
    "399 A Katherine Road, , , , , London, ",
    "4 The Warren, , , , , London, ",
    "4a The Warren, , , , , London, ",
    "4b The Warren, , , , , London, ",
    "4c The Warren, , , , , London, ",
    "5 The Warren, , , , , London, ",
    "6 The Warren, , , , , London, ",
    "7 The Warren, , , , , London, ",
    "8 The Warren, , , , , London, ",
    "9 The Warren, , , , , London, ",
    "Assurance Guarding Ltd, 399 A Katherine Road, , , , London, ",
    "C B Memorials, 20a The Warren, , , , London, ",
    "Ground Floor Flat, 2 The Warren, , , , London, ",
    "Picture Frame Maker, 1 The Warren, , , , London, ",
    "Poldek Ltd, 20 B The Warren, , , , London, "
  ];

  String? branchValue;
  String? levelValue;
  String? schoolValue;
  FToast toast = FToast();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _postCodeController.text = widget.user.postcode;
    _phoneController.text = widget.user.phone ?? "";
    _addressController.text = widget.user.address;
    _getBranchesName();
    _getLevelNames();
    _getSchoolNames();
    print("ADDDDDDDDDDDDDDDDDDd");
    toast.init(context);

    var monthName = _getMonthName(
        int.parse(dobDate.toString().split(" ")[0].split('-')[1]));

    _dateController.text = dobDate.toString().split(" ")[0].split("-")[2] +
        " " +
        monthName +
        " " +
        dobDate.toString().split(" ")[0].split("-")[0];
    _assessmentDateController.text = _dateController.text;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register Student!',
          style: headerStyle,
        ),
      ),
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Enter student's all the manadatory details to get registered",
                  style: disabledTextStyle,
                ),
                const SizedBox(
                  height: 32,
                ),
                ModifiedTextField(
                  icon: const Icon(Icons.person_outlined),
                  controller: _firstNameController,
                  obscureText: false,
                  header: 'First Name',
                ),
                ModifiedTextField(
                  icon: const Icon(Icons.person_outlined),
                  controller: _lastNameController,
                  obscureText: false,
                  header: 'Last Name',
                ),
                ModifiedTextField(
                  icon: const Icon(Icons.phone),
                  controller: _phoneController,
                  obscureText: false,
                  header: 'Phone Number',
                ),
                ModifiedTextField(
                  icon: const Icon(Icons.place),
                  controller: _postCodeController,
                  obscureText: false,
                  header: 'Post Code',
                ),
                Text("Address"),

                Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == "") {
                    return const Iterable<String>.empty();
                  }
                  return fetchedAddresses.where((element) => element
                      .toString()
                      .contains(textEditingValue.text.toLowerCase()));
                }, onSelected: (value) {
                  _addressController.text = value.toString();
                  print("PRINTING THE ADDRESS");
                  print(value);
                }, fieldViewBuilder: ((context, textEditingController,
                        focusNode, onFieldSubmitted) {
                  return TextFormField(
                    focusNode: focusNode,
                    controller: textEditingController,
                    onFieldSubmitted: (String value) {
                      _addressController.text = value;
                      print(value);
                    },
                    decoration: InputDecoration(
                        prefixIcon:
                            Opacity(opacity: 0.3, child: Icon(Icons.place)),
                        border: const OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required Entry';
                      }
                      return null;
                    },
                    maxLength: 100,
                  );
                })),

                // ModifiedTextField(
                //     icon: const Icon(Icons.place),
                //     controller: _addressController,
                //     obscureText: false,
                //     header: 'Address',
                //   ),
                GestureDetector(
                  onTap: () {
                    _showDialog(CupertinoDatePicker(
                      initialDateTime: dobDate,
                      mode: CupertinoDatePickerMode.date,
                      use24hFormat: true,
                      // This shows day of week alongside day of month
                      showDayOfWeek: true,
                      // This is called when the user changes the date.
                      onDateTimeChanged: (DateTime newDate) {
                        setState(() {
                          dobDate = newDate;
                          var monthName = _getMonthName(int.parse(
                              dobDate.toString().split(" ")[0].split('-')[1]));

                          _dateController.text = dobDate
                                  .toString()
                                  .split(" ")[0]
                                  .split("-")[2] +
                              " " +
                              monthName +
                              " " +
                              dobDate.toString().split(" ")[0].split("-")[0];
                        });
                      },
                    ));
                  },
                  child: ModifiedTextFieldForDate(
                    icon: const Icon(Icons.calendar_month),
                    controller: _dateController,
                    obscureText: false,
                    enabled: false,
                    header: 'Date of birth',
                  ),
                ),
                branches == null
                    ? CircularProgressIndicator(
                        color: primaryColor,
                      )
                    : CustomDropDownList(
                        header: "Branches",
                        onChanged: (value) {
                          branchValue = value;
                          print("INSIDE ADD STU BY PAR@");
                          print(branchValue);
                        },
                        data: branches!),
                levels == null
                    ? CircularProgressIndicator(
                        color: primaryColor,
                      )
                    : CustomDropDownList(
                        header: "Levels",
                        onChanged: (value) {
                          levelValue = value;
                        },
                        data: levels!),
                schools == null
                    ? CircularProgressIndicator(
                        color: primaryColor,
                      )
                    : CustomDropDownList(
                        header: "Schools",
                        onChanged: (value) {
                          schoolValue = value;
                          print("INSIDE ADD STU BY PAR@");
                          print(schoolValue);
                        },
                        data: schools!),
                GestureDetector(
                  onTap: () {
                    _showDialog(CupertinoDatePicker(
                      initialDateTime: assesmentDate,
                      mode: CupertinoDatePickerMode.date,
                      use24hFormat: true,
                      // This shows day of week alongside day of month
                      showDayOfWeek: true,
                      // This is called when the user changes the date.
                      onDateTimeChanged: (DateTime newDate) {
                        setState(() {
                          assesmentDate = newDate;
                          var monthName = _getMonthName(int.parse(assesmentDate
                              .toString()
                              .split(" ")[0]
                              .split('-')[1]));

                          _assessmentDateController.text = assesmentDate
                                  .toString()
                                  .split(" ")[0]
                                  .split("-")[2] +
                              " " +
                              monthName +
                              " " +
                              assesmentDate
                                  .toString()
                                  .split(" ")[0]
                                  .split("-")[0];
                        });
                      },
                    ));
                  },
                  child: ModifiedTextFieldForDate(
                    enabled: false,
                    icon: const Icon(Icons.badge),
                    controller: _assessmentDateController,
                    obscureText: false,
                    header: 'Assessment Date',
                  ),
                ),
                // ModifiedTextField(
                //   icon: const Icon(Icons.verified_user),
                //   controller: _timeController,
                //   obscureText: false,             //commented on 3 DEC
                //   header: 'Assessment Time',
                // ),
                const SizedBox(height: 20),
                Container(
                  width: screenWidth,
                  height: screenHeight / 15,
                  //  heightFactor: 1.0,
                  child: ElevatedButton(
                    onPressed: () {
                      _addStudent();
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
                      "ADD STUDENT",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ]),
        ),
      ]),
    );
  }

  Future<List<String>> _getAddresses() async {
    Response response = await dio.get(
        "https://api.getaddress.io/v2/uk/e12%205hy?api-key=3Ihph0lYAU6P1llsphU68Q5211");
    List<String> addresses = [];
    for (var address in response.data['Addresses']) {
      addresses.add(address);
    }
    print(addresses);

    return addresses;
  }

  Future<void> _getBranchesName() async {
    Response response = await dio.get("http://35.176.201.155/api/branches");

    List<String> branchNames = [];
    for (var data in response.data) {
      branchNames.add(data['name']);
      // fetchedBranches.add(Branch(
      //     id: data['id'],
      //     name: data['name'],
      //     phone: data['phone'],
      //     address: data['address'],
      //     slug: data['slug'],
      //     is_active: data['is_active']));
      fetchedBranches.add(Branch.fromMap(data));
    }
    branches = branchNames;
    setState(() {});
  }

  Future<void> _getSchoolNames() async {
    Response response = await dio.get("http://35.176.201.155/api/schools");

    List<String> schoolNames = [];
    for (var data in response.data) {
      schoolNames.add(data['name']);
      // fetchedSchools.add(School.fromMap(data));
      fetchedSchools.add(School.fromMap(data));
    }
    schools = schoolNames;
    setState(() {});
  }

  Future<void> _getLevelNames() async {
    Response response = await dio.get("http://35.176.201.155/api/levels");

    List<String> levelNames = [];
    for (var data in response.data) {
      levelNames.add(data['name']);
      fetchedLevels.add(Level.fromMap(data));
    }
    levels = levelNames;
    setState(() {});
  }

  String _getMonthName(int a) {
    switch (a) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "INVALID";
    }
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  Future<void> _addStudent() async {
    final String firstName = _firstNameController.text.trim();
    final String lastName = _lastNameController.text.trim();
    List<String> dateOfBirth = dobDate.toString().split(' ')[0].split('-');
    final String dob =
        dateOfBirth[2] + "-" + dateOfBirth[1] + "-" + dateOfBirth[0];

    final assessment_date = assesmentDate.toString().split(' ')[0];
    final int branch = _getId(branchValue ?? "", fetchedBranches);
    final int level = _getId(levelValue ?? "", fetchedLevels);
    final int school = _getId(schoolValue ?? "", fetchedSchools);
    final String phone = _phoneController.text.trim();
    final String postcode = _postCodeController.text.trim();
    final String address = _addressController.text.trim();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = await sharedPreferences.getString("token");

    dio.options.headers['Authorization'] = "Token $token";
    dio.options.contentType = 'text/html; charset=utf-8';
    print("INSERTING DATA");
    print("Token $token");
    Response result;
    final formData = FormData.fromMap({
      "branch": branch,
      "level": level,
      "school": school,
      "firstName": firstName,
      "lastName": lastName,
      "phone": phone,
      "address": address,
      "postcode": postcode,
      "dob": dob,
      "assessment_date": assessment_date,
      "assessment_time": "12:00"
    });
    print(token);
    try {
      result = await dio.post("http://35.176.201.155/api/parent-student",
          data: formData);
      print(result.data);
      if (result.statusCode == 200) {
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
                      "Student Added Successfully.",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                )),
              ),
            ),
            toastDuration: Duration(seconds: 1),
            gravity: ToastGravity.BOTTOM);

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ParentsHome()));
        // Future.wait(11)
      }
    } on DioException catch (e, _) {
      toast.showToast(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
                color: (Colors.red), borderRadius: BorderRadius.circular(4)),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check,
                  color: Colors.black,
                ),
                Text(
                  "Check All Fields & Internet Connection",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            )),
          ),
          toastDuration: Duration(seconds: 2),
          gravity: ToastGravity.BOTTOM);
    }
  }

  int _getId(String name, List<dynamic> data) {
    //int i=0;
    for (var value in data) {
      if (value.name == name.trim()) return value.id;
    }
    return 1;
  }
}
