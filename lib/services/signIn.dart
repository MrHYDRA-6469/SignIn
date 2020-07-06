import 'package:SignIn/Shared/orDivider.dart';
import 'package:SignIn/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:SignIn/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleview;
  SignIn({this.toggleview});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String _email = '';
  String _password = '';
  String error = '';

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
                  'Sign in',
                  style: TextStyle(color: Colors.black),
                ),
                actions: <Widget>[
                  FlatButton.icon(
                    icon: Icon(Icons.person),
                    label: Text('Register'),
                    onPressed: () async {
                      widget.toggleview();
                    },
                  ),
                ]),
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
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Password',
                        labelText: 'Password',
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
                    validator: (val) =>
                        val.length < 6 ? 'Enter minimum six Characters' : null,
                    obscureText: true,
                    onChanged: (val) {
                      _password = val;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ActionChip(
                    backgroundColor: Colors.blue[100],
                    label: Text('sign In'),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      if (_formKey.currentState.validate()) {
                        dynamic result = await _auth.signInWithEamilandPasswd(
                            _email, _password);
                        if (result == null) {
                          setState(() {
                            error = 'Unable to Sign In';
                            loading = false;
                          });
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  OrDivider(),
                  ActionChip(
                    backgroundColor: Colors.blue[100],
                    avatar: Image.asset('assets/icons/google.png'),
                    label: Text('Sign In with Google'),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.signInWithGoogle();

                      if (result == null) {
                        setState(() {
                          error = 'Unable to Sign In';
                          loading = false;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  Text(error)
                ]),
              ),
            ));
  }
}