import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routine/services/db.dart';
import 'package:routine/services/models.dart';

class TaskScreen extends StatefulWidget {

  static String id = 'task_screen';

  Routine routine;

  TaskScreen({
    this.routine,
  });

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  DatabaseService _db = DatabaseService();

  @override
  Widget build(BuildContext context) {

    var user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.routine.title),
      ),
      body: StreamBuilder(
        stream: _db.streamTaskList(user, widget.routine.id),
        builder: (context, snapshot) {
          List<Task> taskList = snapshot.data;

          return ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, index) {
              Task task = taskList[index];

              return ListTile(
                title: Text(task.title),
                trailing: Checkbox(
                  value: task.isDone,
                  onChanged: (value) {
                    // Todo - Implement this
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}