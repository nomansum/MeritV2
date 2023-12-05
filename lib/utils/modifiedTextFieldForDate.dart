import 'package:flutter/material.dart';
import 'package:merit_tuition_v1/constants/textstyles.dart';

class ModifiedTextFieldForDate extends StatefulWidget {
  final Icon icon;
  final TextEditingController controller;
  final bool obscureText;
  final String header;
  final bool enabled;
  const ModifiedTextFieldForDate(
      {required this.icon,
      required this.enabled,
      required this.controller,
      required this.obscureText,
      required this.header});

  @override
  State<ModifiedTextFieldForDate> createState() => ModifiedTextFieldState();
}

class ModifiedTextFieldState extends State<ModifiedTextFieldForDate> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.header,
            style: normalTextStyle,
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            enabled: widget.enabled,
            enableInteractiveSelection: true,
            controller: widget.controller,
            decoration: InputDecoration(
                prefixIcon: Opacity(opacity: 0.3, child: widget.icon),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                fillColor: Colors.black),
            obscureText: widget.obscureText,
          ),
          const SizedBox(
            height: 22,
          ),
        ]);
  }
}
