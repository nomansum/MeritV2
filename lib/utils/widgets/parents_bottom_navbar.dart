import 'package:flutter/material.dart';
import 'package:merit_tuition_v1/constants/icons.dart';
import 'package:merit_tuition_v1/pages/fees_details.dart';
import 'package:merit_tuition_v1/utils/BottomNavigationItem.dart';

class ParentsBottomNavBar extends StatelessWidget {
  const ParentsBottomNavBar(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.07,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Material(
        elevation: 2.0,
        child: Row(children: [
          Expanded(
            child: ParentsBottomNavigationItem(
                onPressed: () => {}, iconPath: assignmentIcon),
          ),
          Expanded(
            child: ParentsBottomNavigationItem(
                onPressed: () => {}, iconPath: userIcon),
          ),
          Expanded(
            child: ParentsBottomNavigationItem(
                onPressed: () => {}, iconPath: reportIcon),
          ),
          Expanded(
            child: ParentsBottomNavigationItem(
                onPressed: () => {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) =>
                      //       FeesDetails(), // Replace with your fees details page
                      // ))
                    },
                iconPath: paymentIcon),
          )
        ]),
      ),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:merit_tutor_app/components/BottomNavigationItem.dart';
// import 'package:merit_tutor_app/constants/color.dart';
// import 'package:merit_tutor_app/constants/icons.dart';
// import 'package:merit_tutor_app/utils/svg_to_icon.dart';

// class ParentsBottomNavBar extends StatelessWidget {
//   const ParentsBottomNavBar(BuildContext context, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;

//     return Container(
//       height: height * 0.10,
//       decoration: BoxDecoration(color: Colors.transparent),
//       //margin: EdgeInsets.all(5),
//       padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//       child: Stack(
//         alignment: AlignmentDirectional.bottomEnd,
//         children: [
//           Positioned(
//               right: 0,
//               left: 0,
//               bottom: 0, //top: 17,
//               child: Container(
//                 height: height * 0.07,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                 ),
//                 child: Material(
//                   elevation: 2.0,
//                   child: Row(children: [
//                     Expanded(
//                       child: ParentsBottomNavigationItem(
//                           onPressed: () => {}, iconPath: assignmentIcon),
//                     ),
//                     Expanded(
//                       child: ParentsBottomNavigationItem(
//                           onPressed: () => {}, iconPath: userIcon),
//                     ),
//                     Spacer(),
//                     Expanded(
//                       child: ParentsBottomNavigationItem(
//                           onPressed: () => {}, iconPath: reportIcon),
//                     ),
//                     Expanded(
//                       child: ParentsBottomNavigationItem(
//                           onPressed: () => {}, iconPath: paymentIcon),
//                     )
//                   ]),
//                 ),
//               )),
//           Positioned(
//             left: 0,
//             right: 0,
//             top: 0,
//             child: GestureDetector(
//               onTap: () => {},
//               child: Container(
//                 width: 60,
//                 height: 60,
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                     color: Color(primaryColor), shape: BoxShape.circle),
//                 child: SvgIcon(path: homeIcon),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }








// // import 'package:flutter/material.dart';
// // import 'package:merit_tutor_app/components/BottomNavigationItem.dart';
// // import 'package:merit_tutor_app/constants/color.dart';
// // import 'package:merit_tutor_app/constants/icons.dart';
// // import 'package:merit_tutor_app/utils/svg_to_icon.dart';

// // class ParentsBottomNavBar extends StatelessWidget {
// //   const ParentsBottomNavBar(BuildContext context, {super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final height = MediaQuery.of(context).size.height;

// //     return Container(
// //       height: height * 0.11,
// //       decoration: BoxDecoration(color: Colors.transparent),
// //       //margin: EdgeInsets.all(5),
// //       padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
// //       child: Stack(
// //         children: [
// //           Positioned(
// //               right: 0,
// //               left: 0,
// //               bottom: 0, //top: 17,
// //               child: Container(
// //                 height: height * 0.07,
// //                 decoration: BoxDecoration(
// //                   color: Colors.white,
// //                 ),
// //                 child: Material(
// //                   elevation: 2.0,
// //                   child: Row(children: [
// //                     Expanded(
// //                       child: ParentsBottomNavigationItem(
// //                           onPressed: () => {}, iconPath: assignmentIcon),
// //                     ),
// //                     Expanded(
// //                       child: ParentsBottomNavigationItem(
// //                           onPressed: () => {}, iconPath: userIcon),
// //                     ),
// //                     Spacer(),
// //                     Expanded(
// //                       child: ParentsBottomNavigationItem(
// //                           onPressed: () => {}, iconPath: reportIcon),
// //                     ),
// //                     Expanded(
// //                       child: ParentsBottomNavigationItem(
// //                           onPressed: () => {}, iconPath: paymentIcon),
// //                     )
// //                   ]),
// //                 ),
// //               )),
// //           Positioned(
// //             left: 0,
// //             right: 0,
// //             top: 0,
// //             child: GestureDetector(
// //               onTap: () => {},
// //               child: Container(
// //                 width: 60,
// //                 height: 60,
// //                 padding: const EdgeInsets.all(16),
// //                 decoration: BoxDecoration(
// //                     color: Color(primaryColor), shape: BoxShape.circle),
// //                 child: SvgIcon(path: homeIcon),
// //               ),
// //             ),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }




