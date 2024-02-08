import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppHeaderText extends StatelessWidget {
  final String text;

  AppHeaderText({
    required this.text,
    }){super.key;}

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
