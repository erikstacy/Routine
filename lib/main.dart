import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routine/screens/edit_task_screen.dart';
import 'package:routine/screens/login_screen.dart';
import 'package:routine/screens/register_screen.dart';
import 'package:routine/screens/routine_screen.dart';
import 'package:routine/screens/task_screen.dart';
import 'package:routine/screens/welcome_screen.dart';
import 'package:routine/services/auth.dart';
import 'package:routine/services/models.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    AuthService _auth = AuthService();

    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(value: _auth.user),
      ],
      child: MaterialApp(
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          RegisterScreen.id: (context) => RegisterScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RoutineScreen.id: (context) => RoutineScreen(),
          TaskScreen.id: (context) => TaskScreen(),
          EditTaskScreen.id: (context) => EditTaskScreen(),
        },
        theme: ThemeData.dark(),
      ),
    );
  }
}