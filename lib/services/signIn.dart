import 'package:SignIn/Shared/orDivider.dart';
import 'package:SignIn/services/auth.dart';
import 'package:SignIn/services/register.dart';
import 'package:flutter/material.dart';
import 'package:SignIn/shared/loading.dart';
import 'package:SignIn/ui/forgotPassword.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool _forgot = false;

  String _email = '';
  String _password = '';
  String error = '';
  String sent = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            // resizeToAvoidBottomPadding: false,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                  ),
                ]),
            body: SingleChildScrollView(
              child: Container(
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
                      validator: (val) => val.length < 6
                          ? 'Enter minimum six Characters'
                          : null,
                      obscureText: true,
                      onChanged: (val) {
                        _password = val;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: Colors.blue[100],
                          border: Border.all(color: Colors.black12)),
                      child: ActionChip(
                        backgroundColor: Colors.blue[100],
                        label: Text('Sign In'),
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          if (_formKey.currentState.validate()) {
                            dynamic result = await _auth
                                .signInWithEamilandPasswd(_email, _password);
                            if (result == null) {
                              setState(() {
                                _forgot = true;
                                error = 'Unable to Sign In';
                                loading = false;
                              });
                            }
                          }
                        },
                      ),
                    ),
                    Visibility(
                      visible: _forgot,
                      child: ActionChip(
                        backgroundColor: Colors.red[300],
                        label: Text('Forgot Password'),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen(),
                            ),
                          );
                          setState(() {
                            _forgot = false;
                          });
                        },
                      ),
                    ),
                    OrDivider(),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: Colors.blue[100],
                          border: Border.all(color: Colors.black12)),
                      child: ActionChip(
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
                    ),
                    SizedBox(height: 20),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red),
                    ),
                    Text(sent),
                  ]),
                ),
              ),
            ));
  }
}
