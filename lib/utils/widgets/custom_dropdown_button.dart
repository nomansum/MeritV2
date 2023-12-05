import 'package:flutter/material.dart';
import 'package:merit_tuition_v1/constants/colors.dart';
import 'package:merit_tuition_v1/constants/textstyles.dart';

class CustomDropDownList extends StatefulWidget {
  final String header;
  final Function(String value) onChanged;
  final List<String> data;

  const CustomDropDownList(
      {super.key,
      required this.header,
      required this.onChanged,
      required this.data});

  @override
  State<CustomDropDownList> createState() => _CustomDropDownListState();
}

class _CustomDropDownListState extends State<CustomDropDownList> {
  String dropdownValue = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.header,
          style: normalTextStyle,
        ),
        const SizedBox(
          height: 8,
        ),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.only(top: 20, bottom: 20, left: 3),
            hoverColor: primaryColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Colors.black, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
          ),
          hint: const Text('Select your Preferred Branch'),
          value: dropdownValue == "" ? widget.data[0] : dropdownValue,
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
              widget.onChanged(dropdownValue);
            });
          },
          items: widget.data!.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: normalTextStyle),
            );
          }).toList(),
        ),
        const SizedBox(
          height: 22,
        )
      ],
    );
  }
}
