import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:merit_tuition_v1/constants/colors.dart';
import 'package:merit_tuition_v1/pages/parents_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditParentProfile extends StatefulWidget {
  const EditParentProfile({super.key});

  @override
  State<EditParentProfile> createState() => _EditParentProfileState();
}

class _EditParentProfileState extends State<EditParentProfile> {
  late Future<void> _profileData;
  Dio dio = Dio();
  late FToast toast;
  String? relationship;
  String? profession;
  String? designation;
  // String firstName = '';
  //
  // String lastName = '';
  // String email = '';
  // String phoneNumber = '';
  // String emergencyPhoneNumber = '';
  // String postCode = '';
  // String address = '';

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
          profession = user['profession'];
          relationship = user['relationship'];
          designation = user['designation'];
          firstNameEditingController =
              TextEditingController(text: user['first_name']);
          lastNameEditingController =
              TextEditingController(text: user['last_name']);
          emailEditingController = TextEditingController(text: user['email']);
          phoneEditingController = TextEditingController(text: user['phone']);
          emergencyPhoneEditingController =
              TextEditingController(text: user['emergency_phone'] ?? '');
          postcodeEditingController =
              TextEditingController(text: user['postcode'] ?? '');
          addressEditingController =
              TextEditingController(text: user['address'] ?? '');
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

  late TextEditingController firstNameEditingController;
  late TextEditingController lastNameEditingController;
  late TextEditingController emailEditingController;
  late TextEditingController phoneEditingController;
  late TextEditingController emergencyPhoneEditingController;
  late TextEditingController addressEditingController;
  late TextEditingController postcodeEditingController;

  @override
  void initState() {
    _profileData = _getName();
    toast = FToast();
    toast.init(context);
    super.initState();
  }

  /*
   Printing Parent's information
I/flutter ( 6246): response: {"id": 3, "user": {"first_name": "MR AVIJIT", "last_name": "GOMES", "email": "avigomes@hotmail.com", "phone": "07342986120", "address": null, "postcode": null, "photo": null}, "designation": null, "emergency_phone": "", "relationship": "Other", "profession": null, "balance": "0.00", "refer_code": "VYGY1F", "is_active": true, "created_at": "2023-07-02T20:01:56.770406", "updated_at": "2023-07-02T20:01:56.770421", "referred_by": null}
   */

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Parent Profile",
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
              padding: const EdgeInsets.all(0),
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextFormField(
                                  controller: firstNameEditingController,
                                  // inputFormatters: [
                                  //   LengthLimitingTextInputFormatter(50),
                                  // ],
                                  decoration: InputDecoration(
                                    labelText: 'First Name',
                                    hintText: 'First Name',
                                    hintStyle: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 1,
                                        style: BorderStyle.none,
                                        color: primaryColor,
                                      ),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: lastNameEditingController,
                                  // inputFormatters: [
                                  //   LengthLimitingTextInputFormatter(50),
                                  // ],
                                  decoration: InputDecoration(
                                    hintText: 'Last Name',
                                    labelText: 'Last Name',
                                    hintStyle: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 1,
                                        style: BorderStyle.none,
                                        color: primaryColor,
                                      ),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: emailEditingController,
                                  // inputFormatters: [
                                  //   LengthLimitingTextInputFormatter(50),
                                  // ],
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    labelText: 'Email',
                                    hintStyle: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 1,
                                        style: BorderStyle.none,
                                        color: primaryColor,
                                      ),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: phoneEditingController,
                                  // inputFormatters: [
                                  //   LengthLimitingTextInputFormatter(50),
                                  // ],
                                  decoration: InputDecoration(
                                    hintText: 'Phone Number',
                                    labelText: 'Phone Number',
                                    hintStyle: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 1,
                                        style: BorderStyle.none,
                                        color: primaryColor,
                                      ),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.phone_android,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: emergencyPhoneEditingController,
                                  decoration: InputDecoration(
                                    hintText: 'Emergency Phone Number',
                                    labelText: 'Emergency Phone Number',
                                    hintStyle: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 1,
                                        style: BorderStyle.none,
                                        color: primaryColor,
                                      ),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.phone_android,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: postcodeEditingController,
                                  decoration: InputDecoration(
                                    labelText: 'Post Code',
                                    hintText: 'Post Code',
                                    hintStyle: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 1,
                                        style: BorderStyle.none,
                                        color: primaryColor,
                                      ),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.travel_explore,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // TextFormField(
                                //   controller: addressEditingController,
                                //   // inputFormatters: [
                                //   //   LengthLimitingTextInputFormatter(50),
                                //   // ],
                                //   decoration: InputDecoration(
                                //     hintText: 'Address',
                                //     labelText: 'Address',
                                //     hintStyle: const TextStyle(
                                //       color: Colors.grey,
                                //     ),
                                //     filled: true,
                                //     fillColor: Colors.grey.shade200,
                                //     border: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(10),
                                //       borderSide: const BorderSide(
                                //         width: 1,
                                //         style: BorderStyle.none,
                                //         color: primaryColor,
                                //       ),
                                //     ),
                                //     prefixIcon: const Icon(
                                //       Icons.location_city,
                                //       color: Colors.grey,
                                //     ),
                                //   ),
                                // ),

                                Autocomplete<String>(
                                  optionsBuilder:
                                      (TextEditingValue textEditingValue) {
                                    if (textEditingValue.text == "") {
                                      return const Iterable<String>.empty();
                                    }
                                    return fetchedAddresses.where((element) =>
                                        element.toString().contains(
                                            textEditingValue.text
                                                .toLowerCase()));
                                  },
                                  onSelected: (value) {
                                    addressEditingController.text =
                                        value.toString();
                                    print("PRINTING THE ADDRESS");
                                    print(value);
                                  },
                                  fieldViewBuilder: ((context,
                                      textEditingController,
                                      focusNode,
                                      onFieldSubmitted) {
                                    return TextFormField(
                                      focusNode: focusNode,
                                      controller: textEditingController,
                                      onFieldSubmitted: (String value) {
                                        addressEditingController.text = value;
                                        print(value);
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Address',
                                        labelText: 'Address',
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey.shade200,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            width: 1,
                                            style: BorderStyle.none,
                                            color: primaryColor,
                                          ),
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.location_city,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required Entry';
                                        }
                                        return null;
                                      },
                                      maxLength: 100,
                                    );
                                  }),
                                ),

                                const SizedBox(height: 10),
                              ],
                            ),
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
                                  _editParentsProfile(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  foregroundColor: Colors.white,
                                  backgroundColor: primaryColor,
                                ),
                                child: const Text('Update'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<void> _editParentsProfile(BuildContext context) async {
    final String firstName = firstNameEditingController.text.trim();
    final String lastName = lastNameEditingController.text.trim();

    final String phone = phoneEditingController.text.trim();
    final String emergencyPhone = emergencyPhoneEditingController.text.trim();
    final String postcode = postcodeEditingController.text.trim();
    final String address = addressEditingController.text.trim();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = await sharedPreferences.getString("token");

    dio.options.headers['Authorization'] = "Token $token";
    dio.options.contentType = 'text/html; charset=utf-8';
    // print("INSERTING DATA");
    // print("Token $token");
    Response result;
    final formData = FormData.fromMap({
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone,
      "emergency_phone": emergencyPhone,
      "address": address,
      "postcode": postcode,
      "userType": "parent",
      "dob": "01-01-2000",
      "relationship": relationship,
      "profession": profession,
      "designation": designation
    });
    print("Hi: $token");
    try {
      print("HI");
      result =
          //http://admin.merittutors.co.uk/api //http://35.176.201.155/api
          await dio.put("http://35.176.201.155/api/profile", data: formData);
      print(result.data);
      print("APi Called");
      if (result.statusCode == 200) {
        print("Profile Update Success");
        toast.showToast(
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: (Colors.greenAccent),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Padding(
              padding: EdgeInsets.all(3.0),
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
                    "Profile Updated Successfully.",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              )),
            ),
          ),
          toastDuration: const Duration(seconds: 2),
          gravity: ToastGravity.BOTTOM,
        );

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ParentsHome()));
        // Future.wait(11)
      }
    } on DioException catch (e, _) {
      String text = e.response?.data['response'];
      print("Profile update Failed");
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
                Icons.sms_failed,
                color: Colors.black,
              ),
              Text(
                "Something error occurred at $text",
                style: TextStyle(color: Colors.black),
              ),
            ],
          )),
        ),
        toastDuration: const Duration(seconds: 2),
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
}
