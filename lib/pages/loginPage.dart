// ignore: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:merit_tuition_v1/constants/colors.dart';
import 'package:merit_tuition_v1/pages/SignUpPage.dart';
import 'package:merit_tuition_v1/pages/parents_dashboard.dart';
import 'package:merit_tuition_v1/pages/teacherDashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:merit_tuition_v1/constants/textstyles.dart';

class LoginPage extends StatefulWidget {
  final String userType;
  const LoginPage({required this.userType, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isAuthenticated = false; // Simulated authentication status

  Future<void> _login(BuildContext context) async {
    // Simulated authentication logic - Replace with actual authentication
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(color: primaryColor),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Loading...",
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          );
        });

    final String username = _usernameController.text;
    final String password = _passwordController.text;
    var url = Uri.parse('http://35.176.201.155/api/sign-in');
    http.Response response = await http.post(url, body: {
      'email': username,
      'password': password,
      'userType': widget.userType
    });

    Navigator.of(context).pop();

    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> result = jsonDecode(response.body);
        print(result);
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('token', result['response']);
        sharedPreferences.setString('userType', widget.userType);
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => widget.userType == 'parent'
                ? const ParentsHome()
                : const TeacherDashboard(),
          ),
        );
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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Welcome Back',
          style: headerStyle,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Enter your email address and password.',
                  style: disabledTextStyle,
                ),
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  'Enter Email Address',
                  style: normalTextStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    prefixIcon: Opacity(
                      opacity: 0.3,
                      child: Icon(Icons.email_outlined),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                const Text(
                  'Enter Password',
                  style: normalTextStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      prefixIcon:
                          Opacity(opacity: 0.3, child: Icon(Icons.lock)),
                      border: OutlineInputBorder()),
                  obscureText: true, // Hide password characters
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot Password?',
                    style: smallerDisabledTextStyle,
                  ),
                ),
                const SizedBox(height: 72),
                Container(
                  width: screenWidth,
                  height: screenHeight / 15,
                  //  heightFactor: 1.0,
                  child: ElevatedButton(
                    onPressed: () {
                      _login(context);
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
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    "Don't have a account?",
                    style: normalTextStyle,
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()));
                    },
                    child: const Text(
                      "Create an account",
                      style: nyonTextStyle,
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
}
