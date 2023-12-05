// ignore: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:merit_tuition_v1/pages/UserType.dart';
import 'package:merit_tuition_v1/pages/loginPage.dart';
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

  Future<void> _login() async {
    // Simulated authentication logic - Replace with actual authentication
    final String password = _passwordController.text;
    final String firstName = _firstNameController.text;
    final String lastname = _lastNameController.text;
    final String name = firstName + " " + lastname;
    final String email = _emailController.text;
    final String dob = _dobController.text;
    final String phone = _phoneController.text;
    final String emergencyPhone = _emgencyPhoneController.text;
    final String postCode = _postCodeController.text;
    final String address = _addressController.text;
    final String relationShip = _relationshipController.text;
    final String profession = _profController.text;
    final String designation = _designationController.text;
    final String userType = _userTypeController.text;
    final String referCode = _referCodeController.text;
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
                  header: 'Post Code ',
                ),
                ModifiedTextField(
                  icon: const Icon(Icons.place),
                  controller: _addressController,
                  obscureText: false,
                  header: 'Address',
                ),
                ModifiedTextField(
                  icon: const Icon(Icons.calendar_month),
                  controller: _dobController,
                  obscureText: false,
                  header: 'Date of birth',
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
                  header: 'RelatonShip',
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
                ModifiedTextField(
                  icon: const Icon(Icons.verified_user),
                  controller: _userTypeController,
                  obscureText: false,
                  header: 'User type',
                ),
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
                    onPressed: _login,
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
}
