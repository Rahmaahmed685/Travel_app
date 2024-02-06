import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppContentText extends StatelessWidget {
  double size;
  final String text;

  AppContentText({this.size=15,required this.text}){super.key;}

@override
Widget build(BuildContext context) {
  return Text(
    text,
    style:Theme.of(context).textTheme.titleSmall,
  );
}
}