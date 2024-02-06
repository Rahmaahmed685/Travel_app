import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SecoundPage extends StatefulWidget {
  const SecoundPage({super.key});

  @override
  State<SecoundPage> createState() => _SecoundPageState();
}

class _SecoundPageState extends State<SecoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          children: [
          // Load a Lottie file from your assets
          Lottie.asset('assets/animations/logo.json'),
    ]),
    );
  }
}
