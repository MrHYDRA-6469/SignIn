import 'package:SignIn/ui/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SignIn/user.dart';
import 'package:SignIn/ui/homeScreen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
