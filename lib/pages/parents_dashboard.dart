import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:merit_tuition_v1/constants/colors.dart';
import 'package:merit_tuition_v1/constants/icons.dart';
import 'package:merit_tuition_v1/constants/text.dart';
import 'package:merit_tuition_v1/pages/addStudentByParent.dart';
import 'package:merit_tuition_v1/utils/svg_to_icon.dart';
import 'package:merit_tuition_v1/utils/widgets/parent_appbar.dart';
import 'package:merit_tuition_v1/utils/widgets/parents_bottom_navbar.dart';
import 'package:merit_tuition_v1/utils/widgets/students_list_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParentsHome extends StatefulWidget {
  const ParentsHome({super.key});

  @override
  State<ParentsHome> createState() => _ParentsHomeState();
}

class _ParentsHomeState extends State<ParentsHome> {
  List<String> items = ['1', '2', '3', '5'];
  bool isNewNotification = true;
  bool isListEmpty = false;
  int notificationCount = 3;
  String name = '';

  Future<void> _getName() async {
    // Simulated authentication logic - Replace with actual authentication
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    var url = Uri.parse('http://35.176.201.155/api/profile?userType=parent');
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

  Future<void> _logOut() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.clear();
    Navigator.of(context).popUntil((route) => route.settings.name == '/');
  }

  @override
  void initState() {
    _getName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ParentsAppBar(
        notificationAvailable:
            true, //commented at 2 DEC 2023 for design purposes
        notificationCount: 5,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - 20,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
          child: Column(
            children: [
              const SizedBox(
                height: 2,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(2, 0, 0, 0),
                    child: Text(
                      "STUDENTS",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
              Students(rootcontext: context),
              //  ElevatedButton(onPressed: (){}, child: child)
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: Text("LogOut"),
              onTap: () {
                _logOut();
              },
            )
          ],
        ),
      ),
      //  bottomNavigationBar: ParentsBottomNavBar(context),
    );
  }
}
