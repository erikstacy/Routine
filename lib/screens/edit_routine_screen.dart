import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routine/services/db.dart';
import 'package:routine/services/models.dart';

class EditRoutineScreen extends StatefulWidget {

  static String id = 'edit_routine_screen';

  Routine routine;

  EditRoutineScreen({
    this.routine,
  });

  @override
  _EditRoutineScreenState createState() => _EditRoutineScreenState();
}

class _EditRoutineScreenState extends State<EditRoutineScreen> {

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

    String startingTitle = widget.routine == null ? '' : widget.routine.title;
    titleController.text = startingTitle;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Routine'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            // Changed title - Old Task
            if (startingTitle != titleController.text && widget.routine != null) {
              _db.setRoutineName(user, widget.routine.id, titleController.text);
            }

            // Changed title - New Task
            if (startingTitle != titleController.text && widget.routine == null) {
              _db.createRoutine(user, titleController.text);
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
                _db.deleteRoutine(user, widget.routine.id);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}