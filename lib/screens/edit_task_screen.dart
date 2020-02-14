import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routine/services/db.dart';
import 'package:routine/services/models.dart';

class EditTaskScreen extends StatefulWidget {

  static String id = 'edit_task_screen';

  Task task;
  String routineId;

  EditTaskScreen({
    this.task,
    this.routineId,
  });

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {

  TextEditingController titleController = TextEditingController();

  DatabaseService _db = DatabaseService(); 

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var user = Provider.of<FirebaseUser>(context);

    String startingTitle = widget.task == null ? '' : widget.task.title;
    titleController.text = startingTitle;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            // Changed title - Old Task
            if (startingTitle != titleController.text && widget.task != null) {
              _db.setTaskName(user, widget.routineId, widget.task.id, titleController.text);
            }

            // Changed title - New Task
            if (startingTitle != titleController.text && widget.task == null) {
              _db.createNewTask(user, widget.routineId, titleController.text);
            }

            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
            ),
            RaisedButton(
              child: Icon(
                Icons.delete,
              ),
              onPressed: () {
                _db.deleteTask(user, widget.routineId, widget.task.id);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}