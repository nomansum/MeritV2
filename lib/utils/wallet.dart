import 'package:flutter/material.dart';
import 'package:merit_tuition_v1/constants/colors.dart';
import 'package:merit_tuition_v1/constants/imageStrings.dart';
import 'package:merit_tuition_v1/constants/text.dart';


class walletWidget extends StatelessWidget {
  const walletWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * .147,
      width: double.infinity,
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF4346A3), Color(0xFF4B50CE)],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(34, 10, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$1600',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                Text(
                  totalIncome,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFFD9D9D9),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: size.width * 0.35,
                  height: size.height * 0.04,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      checkHistory,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: StadiumBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Transform.scale(
              scale: 1.35,
              child: Transform.rotate(
                angle: 0.18,
                child: Image.asset(walletPic),
                origin: Offset(62, -5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}