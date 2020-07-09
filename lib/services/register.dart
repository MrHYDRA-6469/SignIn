import 'package:SignIn/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:SignIn/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleview;
  Register({this.toggleview});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                  'Register Screen',
                  style: TextStyle(color: Colors.black),
                ),
                actions: <Widget>[
                  FlatButton.icon(
                    icon: Icon(Icons.person),
                    label: Text('Sign In'),
                    onPressed: () async {
                      widget.toggleview();
                    },
                  ),
                ]),
            body: SingleChildScrollView(
              child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
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
                          validator: (val) =>
                              val.isEmpty ? 'Enter an Email' : null,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              color: Colors.blue[100],
                              border: Border.all(color: Colors.black12)),
                          child: ActionChip(
                            label: Text('Register'),
                            backgroundColor: Colors.blue[100],
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });
                              if (_formKey.currentState.validate()) {
                                dynamic result =
                                    await _auth.registerWithEamilandPasswd(
                                        _email, _password);
                                if (result == null) {
                                  setState(() {
                                    error = 'letus know error';
                                    loading = false;
                                  });
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(error)
                      ],
                    ),
                  )),
            ),
          );
  }
}
