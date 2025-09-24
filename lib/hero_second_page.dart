// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class HeroSecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hero Example - Page 2")),
      body: Center(
        child: Hero(
          tag: 'hero-logo',
          child: FlutterLogo(size: 200), // 👈 نفس الـ Widget لكن أكبر
        ),
      ),
    );
  }
}
