import 'package:flutter/material.dart';
import 'package:routine/screens/login_screen.dart';
import 'package:routine/screens/register_screen.dart';
import 'package:routine/screens/routine_screen.dart';
import 'package:routine/services/auth.dart';

class WelcomeScreen extends StatefulWidget {

  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();

    _auth.getUser.then(
      (user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, RoutineScreen.id);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Register'),
              onPressed: () {
                Navigator.pushNamed(context, RegisterScreen.id);
              },
            ),
            RaisedButton(
              child: Text('Login'),
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}