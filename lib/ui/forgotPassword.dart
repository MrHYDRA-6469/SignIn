import 'package:flutter/material.dart';
import 'package:SignIn/services/auth.dart';
import 'package:SignIn/Shared/loading.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool _forgot = false;

  String _email = '';
  String error = '';
  String sent = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: Text(
                'Generate link',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Email',
                        labelText: 'Email',
                        fillColor: Colors.transparent,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(15),
                        )),
                    validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                    onChanged: (val) {
                      _email = val;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ActionChip(
                    label: Text('Forgot Password'),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        dynamic result =
                            await _auth.sendPasswordResetEmail(_email);
                        sent = 'Password reset link sended succesfully';

                        if (result == null) {
                          setState(() {
                            error = 'Please Retry';
                          });
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SizedBox(height: 20),
                  Text(sent),
                  Text(error)
                ]),
              ),
            ));
  }
}
