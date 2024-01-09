// ignore: file_names
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:merit_tuition_v1/pages/UserType.dart';
import 'package:merit_tuition_v1/pages/loginPage.dart';
import 'package:merit_tuition_v1/utils/modifiedTextFieldForDate.dart';
import 'package:merit_tuition_v1/utils/widgets/custom_dropdown_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:merit_tuition_v1/constants/textstyles.dart';
import 'package:merit_tuition_v1/utils/modifiedTextField.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emgencyPhoneController = TextEditingController();
  final TextEditingController _postCodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();
  final TextEditingController _profController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _userTypeController = TextEditingController();
  final TextEditingController _referCodeController = TextEditingController();

  bool _isAuthenticated = false; // Simulated authentication status
  DateTime dobDate = DateTime.now();
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

  List<String> users = ['Teacher', 'Parent'];
  Future<void> _login() async {
    // Simulated authentication logic - Replace with actual authentication
    final String password = _passwordController.text;
    final String firstName = _firstNameController.text;
    final String lastname = _lastNameController.text;
    final String name = firstName + " " + lastname;
    final String email = _emailController.text;
    print("SIGN UP TILL HERE");

    List<String> dateOfBirth = _dobController.text.toString().split('-');
    print(dateOfBirth);

    final String dob =
        dateOfBirth[2] + "-" + dateOfBirth[1] + "-" + dateOfBirth[0];
    final String phone = _phoneController.text;
    final String emergencyPhone = _emgencyPhoneController.text;
    final String postCode = _postCodeController.text;
    final String address = _addressController.text;
    final String relationShip = _relationshipController.text;
    final String profession = _profController.text;
    final String designation = _designationController.text;
    final String userType = _userTypeController.text.toLowerCase();
    final String referCode = _referCodeController.text;
    DateTime dobDate = DateTime.now();
    var url = Uri.parse('http://35.176.201.155/api/sign-up');
    http.Response response = await http.post(url, body: {
      'email': email,
      'password': password,
      'userType': userType,
      'name': name,
      'phone': phone,
      'address': address,
      'postcode': postCode,
      'dob': dob,
      'emergency_phone': emergencyPhone,
      'relationship': relationShip,
      'profession': profession,
      'designation': designation,
      'userType': userType,
      'refer_code': referCode
    });
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> result = jsonDecode(response.body);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Successfully Signed Up'),
          backgroundColor: Colors.green,
        ));
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const LoginPage(
                      userType: 'parent',
                    )));

        print(result);
      } catch (e) {
        print(response);
      }
      return;
    } else {
      // ignore: use_build_context_synchronously
      print(jsonDecode(response.body));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something went wrong,please try again'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userTypeController.text = "Teacher";
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register Yourself!',
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
                  'Enter your all the manadatory details to get registered',
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
                  icon: const Icon(Icons.email_outlined),
                  controller: _emailController,
                  obscureText: false,
                  header: 'Email Address',
                ),
                ModifiedTextField(
                  icon: const Icon(Icons.phone),
                  controller: _phoneController,
                  obscureText: false,
                  header: 'Phone Number',
                ),
                ModifiedTextField(
                  icon: const Icon(Icons.password),
                  controller: _passwordController,
                  obscureText: true,
                  header: 'Password',
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

                          _dobController.text = dobDate
                                  .toString()
                                  .split(" ")[0]
                                  .split("-")[2] +
                              " " +
                              monthName +
                              " " +
                              dobDate.toString().split(" ")[0].split("-")[0];

                          print("DOBCONTROLLER " + _dobController.text);
                          print("DOBDATE " + dobDate.toString().split(" ")[0]);
                        });
                      },
                    ));
                  },
                  child: ModifiedTextFieldForDate(
                    icon: const Icon(Icons.calendar_month),
                    controller: _dobController,
                    obscureText: false,
                    enabled: false,
                    header: 'Date of birth',
                  ),
                ),
                ModifiedTextField(
                  icon: const Icon(Icons.phone),
                  controller: _emgencyPhoneController,
                  obscureText: false,
                  header: 'Emergency Phone',
                ),
                ModifiedTextField(
                  icon: const Icon(Icons.person),
                  controller: _relationshipController,
                  obscureText: false,
                  header: 'RelationShip',
                ),
                ModifiedTextField(
                  icon: const Icon(Icons.badge),
                  controller: _profController,
                  obscureText: false,
                  header: 'Profession',
                ),
                ModifiedTextField(
                  icon: const Icon(Icons.badge),
                  controller: _designationController,
                  obscureText: false,
                  header: 'Designation',
                ),

                CustomDropDownList(
                    header: "User-Type",
                    onChanged: (value) {
                      _userTypeController.text = value;
                    },
                    data: users),
                ModifiedTextField(
                  icon: const Icon(Icons.room_preferences),
                  controller: _referCodeController,
                  obscureText: false,
                  header: 'Refer Code',
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 72),
                Container(
                  width: screenWidth,
                  height: screenHeight / 15,
                  //  heightFactor: 1.0,
                  child: ElevatedButton(
                    onPressed: () {
                      _dobController.text = dobDate.toString().split(" ")[0];
                      _login();
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
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                    child: Text(
                  "Already have a account?",
                  style: normalTextStyle,
                )),
                Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserType()));
                      },
                      child: const Text(
                        "Log into your account",
                        style: nyonTextStyle,
                      )),
                )
              ]),
        ),
      ]),
    );
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
}
