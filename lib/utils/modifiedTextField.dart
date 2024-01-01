import 'package:flutter/material.dart';
import 'package:merit_tuition_v1/constants/textstyles.dart';

class ModifiedTextField extends StatefulWidget {
  final Icon icon;
  final TextEditingController controller;
  final bool obscureText;
  final String header;
  const ModifiedTextField(
      {required this.icon,
      required this.controller,
      required this.obscureText,
      required this.header});

  @override
  State<ModifiedTextField> createState() => ModifiedTextFieldState();
}

class ModifiedTextFieldState extends State<ModifiedTextField> {
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
            controller: widget.controller,
            decoration: InputDecoration(
                prefixIcon: Opacity(opacity: 0.3, child: widget.icon),
                border: const OutlineInputBorder()),
            obscureText: widget.obscureText,
          ),
          const SizedBox(
            height: 22,
          ),
        ]);
  }
}
