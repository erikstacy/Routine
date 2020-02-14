import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routine/screens/edit_routine_screen.dart';
import 'package:routine/screens/edit_task_screen.dart';
import 'package:routine/services/db.dart';
import 'package:routine/services/models.dart';
import 'package:routine/shared/loader.dart';

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

    return StreamBuilder(
      stream: _db.streamTaskList(user, widget.routine.id),
      builder: (context, snapshot) {
        return StreamBuilder(
          stream: _db.streamRoutine(user, widget.routine.id),
          builder: (context, snapshot2) {

            if (!snapshot.hasData && !snapshot2.hasData) {
              return LoadingScreen();
            } else {
              List<Task> taskList = snapshot.data;
              Routine routine = snapshot2.data;

              return Scaffold(
                appBar: AppBar(
                  title: GestureDetector(
                    child: Text(routine.title),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => EditRoutineScreen(routine: widget.routine,),
                      ));
                    },
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.close,
                      ),
                      onPressed: () async {
                        _db.uncheckRoutineTasks(user, widget.routine.id);
                      },
                    ),
                  ],
                ),
                body: ListView.builder(
                  itemCount: taskList.length,
                  itemBuilder: (context, index) {
                    Task task = taskList[index];

                    return ListTile(
                      title: Text(task.title),
                      trailing: Checkbox(
                        value: task.isDone,
                        onChanged: (value) {
                          _db.setTaskIsDone(user, widget.routine.id, task.id, value);
                        },
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => EditTaskScreen(task: task, routineId: widget.routine.id,),
                        ));
                      },
                    );
                  },
                ),
                floatingActionButton: FloatingActionButton(
                  child: Icon(
                    Icons.add,
                  ),
                  onPressed: () {
                    Task newTask;
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => EditTaskScreen(task: newTask, routineId: widget.routine.id,),
                    ));
                  },
                ),
              );
            }
          },
        );
      }
    );
  }
}