import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routine/services/db.dart';
import 'package:routine/services/models.dart';

class TaskScreen extends StatefulWidget {

  static String id = 'task_screen';

  String routineId;

  TaskScreen({
    this.routineId,
  });

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  DatabaseService _db = DatabaseService();

  @override
  Widget build(BuildContext context) {

    var user = Provider.of<FirebaseUser>(context);

    return StreamBuilder(
      stream: _db.streamRoutine(user, widget.routineId),
      builder: (context, snap) {
        Routine routine = snap.data;

        return Scaffold(
          appBar: AppBar(
            title: Text(routine.title),
          ),
          body: ListView.builder(
            itemCount: routine.taskList.length,
            itemBuilder: (context, index) {
              Task task = routine.taskList[index];

              return ListTile(
                title: Text(task.title),
                trailing: Checkbox(
                  value: task.isDone,
                  onChanged: (value) {
                    // Todo - make this work
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}