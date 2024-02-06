import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppHeaderText extends StatelessWidget {
  double size;
  final String text;
  final Color color;

  AppHeaderText({
    this.size=30,
    required this.text,
    required this.color}){super.key;}

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
