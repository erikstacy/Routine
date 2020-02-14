import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routine/screens/task_screen.dart';
import 'package:routine/screens/welcome_screen.dart';
import 'package:routine/services/auth.dart';
import 'package:routine/services/db.dart';
import 'package:routine/services/models.dart';

class RoutineScreen extends StatefulWidget {

  static String id = 'routine_screen';

  @override
  _RoutineScreenState createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {

  AuthService _auth = AuthService();
  DatabaseService _db = DatabaseService();

  @override
  Widget build(BuildContext context) {

    var user = Provider.of<FirebaseUser>(context);

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
      body: StreamBuilder(
        stream: _db.streamRoutineList(user),
        builder: (context, snapshot) {
          List<Routine> routineList = snapshot.data;

          return ListView.builder(
            itemCount: routineList.length,
            itemBuilder: (context, index) {
              Routine routine = routineList[index];

              return ListTile(
                title: Text(routine.title),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => TaskScreen(routine: routine,),
                  ));
                },
              );
            },
          );
        },
      ),
    );
  }
}