import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:merit_tuition_v1/constants/colors.dart';
import 'package:merit_tuition_v1/pages/edit_parent_profile.dart';
import 'package:merit_tuition_v1/pages/parent_profile_data.dart';
import 'package:merit_tuition_v1/pages/parent_profile_title.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ParentProfile extends StatefulWidget {
  const ParentProfile({super.key});

  @override
  State<ParentProfile> createState() => _ParentProfileState();
}

class _ParentProfileState extends State<ParentProfile> {
  late Future<void> _profileData;
  String firstName = '';

  String lastName = '';
  String email = '';
  String phoneNumber = '';
  String emergencyPhoneNumber = '';
  String postCode = '';
  String address = '';

  Future<void> _getName() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    var url = Uri.parse('http://35.176.201.155/api/profile?userType=parent');
    http.Response response = await http.get(
      url,
      headers: {
        'Authorization': 'Token $token',
      },
    );

    String TAG = "response";

    print("Printing Parent's information");
    print("$TAG: ${response.body}");

    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> result = jsonDecode(response.body);

        setState(() {
          var user = result['user'];
          firstName = user['first_name'];
          lastName = user['last_name'];
          email = user['email'] ?? '';
          phoneNumber = user['phone'] ?? '';
          emergencyPhoneNumber = user['emergency_phone'] ?? 'Not Given';
          postCode = user['postcode'] ?? 'Not Given';
          address = user['address'] ?? 'Not Given';
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
    // TODO: implement initState
    _profileData = _getName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Parent Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<void>(
        future: _profileData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const parentProfileTitle(
                        titleIcon: Icons.person,
                        titleName: 'First Name',
                      ),
                      const SizedBox(
                        height: 05,
                      ),
                      parentProfileData(
                        data: firstName,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const parentProfileTitle(
                        titleIcon: Icons.person,
                        titleName: 'Last Name',
                      ),
                      const SizedBox(
                        height: 05,
                      ),
                      parentProfileData(
                        data: lastName,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const parentProfileTitle(
                        titleIcon: Icons.email,
                        titleName: 'Email',
                      ),
                      const SizedBox(
                        height: 05,
                      ),
                      parentProfileData(
                        data: email,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const parentProfileTitle(
                        titleIcon: Icons.phone_android,
                        titleName: 'Phone Number',
                      ),
                      const SizedBox(
                        height: 05,
                      ),
                      parentProfileData(
                        data: phoneNumber,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const parentProfileTitle(
                        titleIcon: Icons.phone_android,
                        titleName: 'Emergency Phone Number',
                      ),
                      const SizedBox(
                        height: 05,
                      ),
                      parentProfileData(
                        data: emergencyPhoneNumber,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const parentProfileTitle(
                        titleIcon: Icons.travel_explore,
                        titleName: 'Postcode',
                      ),
                      const SizedBox(
                        height: 05,
                      ),
                      parentProfileData(
                        data: postCode,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const parentProfileTitle(
                        titleIcon: Icons.location_city,
                        titleName: 'Address',
                      ),
                      const SizedBox(
                        height: 05,
                      ),
                      parentProfileData(
                        data: address,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 50,
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return EditParentProfile();
                                  },
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              foregroundColor: Colors.white,
                              backgroundColor: primaryColor,
                            ),
                            child: const Text('Edit Profile'),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
