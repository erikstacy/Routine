import 'package:flutter/material.dart';
import 'package:routine/screens/welcome_screen.dart';
import 'package:routine/services/auth.dart';

class RoutineScreen extends StatefulWidget {

  static String id = 'routine_screen';

  @override
  _RoutineScreenState createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {

  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Routines'),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListTile(
            title: Text('Sign Out'),
            onTap: () {
              _auth.signOut();
              Navigator.pushReplacementNamed(context, WelcomeScreen.id);
            },
          ),
        ),
      ),
    );
  }
}