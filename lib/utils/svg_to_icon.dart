import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final String path;

  const SvgIcon({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(path, semanticsLabel: 'Acme Logo');
  }
}
