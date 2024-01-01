import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:merit_tuition_v1/constants/colors.dart';
import 'package:merit_tuition_v1/constants/icons.dart';
import 'package:merit_tuition_v1/pages/paymentType.dart';
import 'package:merit_tuition_v1/utils/widgets/fees_details_card.dart';
import 'package:merit_tuition_v1/utils/widgets/fees_details_screen_appbar.dart';
import 'package:merit_tuition_v1/utils/widgets/fees_overview.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FeesDetails extends StatefulWidget {
  final dynamic studentId;
  const FeesDetails({required this.studentId, super.key});

  @override
  State<FeesDetails> createState() => _FeesDetailsState();
}

class _FeesDetailsState extends State<FeesDetails> {
  final ScrollController _feesScrollController = ScrollController();
  double totalFees = 0.0;
  double totalPaid = 0.0;
  double totalDue = 0.0;
  List paymentIds = [];
  List<dynamic> result = [];
  String feesType = "all";
  
  get ids => null;

  Future<List<dynamic>> getStudentBills() async {
    totalFees = 0.0;
    totalPaid = 0.0;
    totalDue = 0.0;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    var url = feesType == "all"
        ? Uri.parse(
            'http://35.176.201.155/api/student-bills/${widget.studentId}')
        : Uri.parse(
            'http://35.176.201.155/api/student-bills/49?month=${feesType.split('-')[1]}&& year=${feesType.split('-')[0]}');
    http.Response response = await http.get(
      url,
      headers: {
        'Authorization':
            'Token $token', // Add the authorization header
      },
    );
    print(response.body);

    if (response.statusCode == 200) {
      try {
        result = jsonDecode(response.body);
        paymentIds.clear();
        print(result);
        result.forEach((element) {
          print(element);
          if(double.parse(element["due"])>0)
          {
            paymentIds.add(element['id']);
          }
          
          totalFees += double.parse(element["fee"]);
          totalPaid += double.parse(element["paid"]);
          totalDue += double.parse(element["due"]);
          print(double.parse(element["due"]));
          // if (totalDue < 0.001) {
          //   totalDue = totalDue * (-1.0);
          // }
        });
        print({totalDue, totalPaid});
        return result;
      } catch (e) {
        print(response);
        throw e;
      }
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something went wrong,please try again'),
        backgroundColor: Colors.red,
      ));
      throw Exception(
          'API call failed'); // Throwing an exception in case of an error
    }
  }

  void _popThisScreen(BuildContext context) {
    Navigator.of(context).pop();
  }

  void navigateToPaymentType() {
    if (totalDue > 0.0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PaymentType(paymentIds: paymentIds, amount: (totalDue * 100).toInt().toString())));
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Payment is already paid'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    BuildContext thiscontext = context;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return FutureBuilder<List<dynamic>>(
      future: getStudentBills(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              appBar: AppBar(
                scrolledUnderElevation: 0.0,
                elevation: 0.0,
                leading: IconButton(
                  onPressed: () {
                    print("LKDF");
                    _popThisScreen(thiscontext);
                  },
                  icon: Icon(Icons.keyboard_arrow_left),
                  color: Colors.black,
                ),
                backgroundColor: Colors.transparent,
                title: Text(
                  "Fees Details",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF000000)),
                ),
                centerTitle: true,
              ),
              body: Center(
                child: Container(
                  width: 100, // Adjust the width as needed
                  height: 100, // Adjust the height as needed
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.blue), // Customize the color
                    strokeWidth: 6, // Customize the thickness
                  ),
                ),
              ));
        } else if (snapshot.hasError) {
          // Handle error state.
          return Text('Error: ${snapshot.error}');
        } else {
          // Data has been successfully fetched.
          print("THIS IS SNAPSHOT");
          print(snapshot.data);

          final studentBills = snapshot.data!;

          return Scaffold(
            floatingActionButton: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
              child: GestureDetector(
                  onTap: () {
                    // StripeAPI.createStripeCustomer().then((value) =>  StripeAPI.makePayment("65", "USD", context));
                    navigateToPaymentType();
                  },
                  child: IntrinsicWidth(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(
                            255, 245, 232, 174), // Your background color
                      ),
                      padding: EdgeInsets.fromLTRB(3, 5, 8, 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset(
                              arrowRightIcon1,
                              height: 24,
                              width: 24,
                              fit: BoxFit.contain,
                            ),
                            Text(
                              'Pay Now',
                              style: TextStyle(
                                color: Color(0xFFFB95E1),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ]),
                    ),
                  )),
            ),
            appBar: AppBar(
              scrolledUnderElevation: 0.0,
              elevation: 0.0,
              leading: IconButton(
                onPressed: () {
                  print("LKDF");
                  _popThisScreen(thiscontext);
                },
                icon: Icon(Icons.keyboard_arrow_left),
                color: Colors.black,
              ),
              backgroundColor: Colors.transparent,
              title: Text(
                "Fees Details",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF000000)),
              ),
              centerTitle: true,
              // actions: [
              //   GestureDetector(
              //       onTap: () {
              //         //filter button code
              //       },                          ///commented on 2 DEC
              //       child: Icon(Icons.filter_alt_outlined)),
              //   SizedBox(
              //     width: 5,
              //   )
              // ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 80,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 125,
                            decoration: ShapeDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(0.00, -1.00),
                                end: Alignment(0, 1),
                                colors: [Color(0xFF4346A3), Color(0xFF4B4FCD)],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Amount To Be Paid',
                                    style: TextStyle(
                                      color: Color(0xFFD9D9D9),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '£$totalDue',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          OverflowBox(
                            alignment: Alignment(1.0, -2.0),
                            maxHeight:
                                70, // Adjust this value to control the overflow
                            child: Image.asset(
                              "assets/images/fees_details.png",
                              fit: BoxFit
                                  .cover, // You can adjust the fit as needed
                              width: 75, // Adjust the width as needed
                              height: 75, // Adjust the height as needed
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        feesOverview(
                            amount: totalFees,
                            descText: "Total Fees",
                            color: primaryColor),
                        feesOverview(
                            amount: totalPaid,
                            descText: "Total Paid",
                            color: secondaryColor),
                        feesOverview(
                            amount: totalDue,
                            descText: "Total Due",
                            color: Color(dueColor))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Fees Details',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Add your logic for the "All" button here
                                setState(() {
                                  feesType = "all";
                                });
                              },
                              child: Text("All"),
                            ),
                            SizedBox(
                                width:
                                    10), // Add some spacing between the buttons
                            ElevatedButton(
                              onPressed: () {
                                // Add your logic for the "This Month" button here
                                setState(() {
                                  feesType =
                                      "${DateTime.now().year}-${DateTime.now().month}";
                                });
                              },
                              child: Text(
                                  DateFormat.MMMM().format(DateTime.now())),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: height * 0.6,
                      width: double.infinity,
                      child: Scrollbar(
                        thickness: 5,
                        trackVisibility: false,
                        interactive: true,
                        thumbVisibility: true,
                        controller: _feesScrollController,
                        radius: const Radius.circular(5),
                        child: ListView.separated(
                            itemCount: studentBills.length,
                            separatorBuilder: ((context, index) {
                              return SizedBox(
                                height: 10,
                              );
                            }),
                            itemBuilder: (context, index) {
                              final double? paid =
                                  double.tryParse(studentBills[index]["paid"]);
                              final double? due =
                                  double.tryParse(studentBills[index]["due"]);
                              final double? fee =
                                  double.tryParse(studentBills[index]["fee"]);
                              return FeesDetailsCard(
                                title: studentBills[index]["title"],
                                fee: fee!,
                                paidBill: paid!,
                                dueBill: due!,
                                month: studentBills[index]["bill_date"],
                                onPressed: () {
                                  if (due != null) {
                                     List<dynamic> ids = [];
                                     ids.add(result[index]['id']);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PaymentType(
                                                paymentIds: ids,
                                                amount: (due.abs() * 100)
                                                    .toInt()
                                                    .toString())));
                                  }
                                },
                                status: '',
                              );
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
