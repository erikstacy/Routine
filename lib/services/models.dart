import 'package:cloud_firestore/cloud_firestore.dart';

class Task {

  String title;
  bool isDone;

  Task({
    this.title,
    this.isDone,
  });

  factory Task.fromMap(Map data) {
    return Task(
      title: data['title'] ?? '',
      isDone: data['isDone'] ?? false,
    );
  }

}

class Routine {

  String id;
  String title;
  List<Task> taskList;

  Routine({
    this.id,
    this.title,
    this.taskList,
  });

  factory Routine.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Routine(
      id: doc.documentID,
      title: data['title'] ?? '',
      taskList: (data['tasks'] as List ?? []).map((v) => Task.fromMap(v)).toList(),
    );
  }

}