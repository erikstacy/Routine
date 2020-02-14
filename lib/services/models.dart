import 'package:cloud_firestore/cloud_firestore.dart';

class Task {

  String id;
  String title;
  bool isDone;

  Task({
    this.id,
    this.title,
    this.isDone,
  });

  factory Task.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Task(
      id: doc.documentID,
      title: data['title'] ?? '',
      isDone: data['isDone'] ?? false,
    );
  }

}

class Routine {

  String id;
  String title;

  Routine({
    this.id,
    this.title,
  });

  factory Routine.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Routine(
      id: doc.documentID,
      title: data['title'] ?? '',
    );
  }

}