import 'package:flutter/material.dart';
import 'package:routine/screens/login_screen.dart';
import 'package:routine/screens/register_screen.dart';
import 'package:routine/screens/routine_screen.dart';
import 'package:routine/screens/welcome_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RoutineScreen.id: (context) => RoutineScreen(),
      },
    );
  }
}