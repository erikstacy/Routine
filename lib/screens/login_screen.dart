import 'package:flutter/material.dart';
import 'package:routine/screens/routine_screen.dart';
import 'package:routine/services/auth.dart';

class LoginScreen extends StatefulWidget {

  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  AuthService _auth = AuthService();
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                email = value;
              },
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
            RaisedButton(
              child: Text('REGISTER'),
              onPressed: () async {
                var user = await _auth.emailLogin(email, password);
                if (user != null) {
                  Navigator.pushReplacementNamed(context, RoutineScreen.id);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}