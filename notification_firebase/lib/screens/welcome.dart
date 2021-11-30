import 'package:flutter/material.dart';
import 'package:notification_firebase/main.dart';

class Welcome extends StatefulWidget {
  static String id = "/welcome";
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, MyHomePage.id);
        },
        child: Text("Go To"),
      ),
    ));
  }
}
