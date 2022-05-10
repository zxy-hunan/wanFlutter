import 'package:flutter/material.dart';
import 'dart:async';

import 'package:wanFlutter/page/MainPage.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 3000), handleTimeout);
  }

  void handleTimeout() {
    // callback function
    // Do some work.
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return MainPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Image.asset("images/iconwel.jpg", fit: BoxFit.cover));
  }
}
