import 'package:flutter/material.dart';
import 'package:SignIn/services/register.dart';
import 'package:SignIn/services/signIn.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn == true
        ? SignIn(toggleview: toggleView)
        : Register(toggleview: toggleView);
  }
}
