import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merit_tuition_v1/constants/icons.dart';
import 'package:merit_tuition_v1/utils/svg_to_icon.dart';

import 'package:merit_tuition_v1/utils/widgets/fees_information.dart';

class FeesDetailsCard extends StatefulWidget {
  final String title;
  final String month;
  final String status;
  final double dueBill;
  final double fee;
  final double paidBill;
  final Function() onPressed;
  const FeesDetailsCard(
      {super.key,
      required this.title,
      required this.month,
      required this.status,
      required this.dueBill,
      required this.fee,
      required this.paidBill,
      required this.onPressed});

  @override
  State<FeesDetailsCard> createState() => _FeesDetailsCardState();
}

class _FeesDetailsCardState extends State<FeesDetailsCard> {
  bool isExpanded = false;

  DateTime? dateTime;

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

  @override
  Widget build(BuildContext context) {
    dateTime = DateTime.parse(widget.month);
    String monthName = _getMonthName(dateTime!.month);
    String yearName = dateTime!.year.toString();

    String finalMonth = monthName + " " + yearName;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Theme(
        data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        child: ExpansionTile(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),

          // leading: Column(
          //   children: [FeesInformation(heading: "TITLE", details: title)],
          // ),
          leading: isExpanded
              ? SizedBox(
                  width: 1,
                )
              : Container(
                  height: 70,
                  width: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      Text(
                        "${widget.title}",
                        style: TextStyle(
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w800),
                      ),
                      Spacer(),
                      Text(
                        "${finalMonth}",
                        style: TextStyle(
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w400),
                      ),
                      Spacer()
                    ],
                  ),
                ),
          title: isExpanded
              ? Container(
                  height: 70,
                  width: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      Text(
                        "${widget.title}",
                        style: TextStyle(
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      Text(
                        "${finalMonth}",
                        style: TextStyle(
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w400),
                      ),
                      Spacer()
                    ],
                  ),
                )
              : Container(
                  height: 50,
                  width: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Text(
                        "DUE",
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 13,
                            color: widget.dueBill <= 0.0
                                ? Colors.black
                                : Colors.red,
                            fontWeight: FontWeight.w800),
                      ),
                      Spacer(),
                      Text(
                        "£${widget.dueBill}",
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 12,
                            color: widget.dueBill <= 0.0
                                ? Colors.grey.shade800
                                : Colors.red,
                            fontWeight: FontWeight.w400),
                      ),
                      Spacer()
                    ],
                  ),
                ),
          onExpansionChanged: (value) {
            isExpanded = !isExpanded;
            setState(() {});
          },
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: ShapeDecoration(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment
                        .center, //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FeesInformation(
                        heading: "FEE",
                        details: "£${widget.fee}",
                        isDue: false,
                        dueBill: 0.0,
                      ),
                      FeesInformation(
                        heading: "PAID",
                        details: "£${widget.paidBill}",
                        isDue: false,
                        dueBill: 0.0,
                      ),
                      FeesInformation(
                          heading: "DUE",
                          details: "£${widget.dueBill}",
                          isDue: true,
                          dueBill: widget.dueBill)
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFF4346A3),
                      ),
                      height: 40,
                      width: double.infinity,
                      child: TextButton(
                          onPressed: widget.onPressed,
                          child: Text(
                            'Pay Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                    ),
                  ),
                  Spacer()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}











// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:merit_tutor_app/src/constants/color.dart';
// import 'package:merit_tutor_app/src/constants/icons.dart';
// import 'package:merit_tutor_app/src/features/parent/screens/feesdetails/widgets/fees_information.dart';
// import 'package:merit_tutor_app/src/utils/svg_to_icon.dart';

// class FeesDetailsCard extends StatelessWidget {
//   final String title;
//   final String month;
//   final String status;
//   final double dueBill;
//   final double fee;
//   final double paidBill;
//   final Function() onPressed;
//   const FeesDetailsCard(
//       {super.key,
//       required this.title,
//       required this.month,
//       required this.status,
//       required this.dueBill,
//       required this.fee,
//       required this.paidBill,
//       required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: 165,
//       decoration: ShapeDecoration(
//         color: Colors.grey.shade300,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               crossAxisAlignment: CrossAxisAlignment
//                   .center, //   mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 FeesInformation(heading: "TITLE", details: title),
//                 FeesInformation(heading: "MONTH", details: month),
//                 FeesInformation(heading: "STATUS", details: status),
//               ],
//             ),
//             Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               crossAxisAlignment: CrossAxisAlignment
//                   .center, //   mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Flexible(
//                   child: Container(
//                     height: 40,
//                     width: 120,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           "DUE",
//                           style: TextStyle(
//                               overflow: TextOverflow.ellipsis,
//                               color: dueBill <= 0.0 ? Colors.black : Colors.red,
//                               fontWeight: FontWeight.w600),
//                         ),
//                         Text(
//                           "£$dueBill",
//                           style: TextStyle(
//                               overflow: TextOverflow.ellipsis,
//                               color: dueBill <= 0.0
//                                   ? Colors.grey.shade800
//                                   : Colors.red,
//                               fontWeight: FontWeight.w400),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 FeesInformation(heading: "FEE", details: "£$fee"),
//                 FeesInformation(heading: "PAID", details: "£$paidBill"),
//               ],
//             ),
//             Spacer(),
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 color: Color(0xFF4346A3),
//               ),
//               height: 40,
//               width: double.infinity,
//               child: Expanded(
//                 child: TextButton(
//                     onPressed: onPressed,
//                     child: Text(
//                       'Pay Now',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     )),
//               ),
//             ),
//             Spacer()
//           ],
//         ),
//       ),
//     );
//   }
// }


























// class FeesDetailsCard extends StatelessWidget {
//   final String feesType;
//   final String amount;
//   final String paymentStatus;
//   final void Function() ontap;
//   const FeesDetailsCard(
//       {super.key,
//       required this.feesType,
//       required this.amount,
//       required this.paymentStatus,
//       required this.ontap});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 185,
//       height: 165,
//       decoration: ShapeDecoration(
//         color: Color(0xFFF5F5F6),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
//             child: SvgIcon(path: bankIcon),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
//             child: Text(
//               feesType,
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
//             child: Row(
//               children: [
//                 Text(
//                   '£${amount}',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 22,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//                 Text(
//                   paymentStatus ,
//                   style: TextStyle(
//                     color: Color(0xFF898989),
//                     fontSize: 8,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 )
//               ],
//             ),
//           ),
//           // Padding(
//           //   padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
//           //   child: GestureDetector(
//           //     onTap: ontap,
//           //     child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//           //       SvgPicture.asset(
//           //         arrowRightIcon1,
//           //         height: 20,
//           //         width: 20,
//           //         fit: BoxFit.contain,
//           //       ),
//           //       Text(
//           //         'Pay Now',
//           //         style: TextStyle(
//           //           color: Color(0xFFFB95E1),
//           //           fontSize: 14,
//           //           fontWeight: FontWeight.w500,
//           //         ),
//           //       )
//           //     ]),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }
