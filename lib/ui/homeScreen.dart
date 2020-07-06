import 'package:flutter/material.dart';
import 'package:SignIn/services/auth.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Welcome', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              color: Colors.white,
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Center(
              child: Card(
                child: Text('You have succesfully logged in'),
              ),
            )
            // DataTile(),
            // BackdropFilter(
            //   filter: ImageFilter.blur(sigmaX: _isBlurred ? 5 : 0, sigmaY: _isBlurred ? 5 : 0),
            //     child: Container(
            //       color: Colors.black.withOpacity(0),
            //     ),
            // ),
          ],
        ),
      ),
    );
  }
}
