import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:routine/services/models.dart';

class DatabaseService {

  final Firestore _db = Firestore.instance;

  /*

   Streams

  */

  Stream<List<Routine>> streamRoutineList(FirebaseUser user) {
    var ref = _db.collection('users').document(user.uid).collection('routines');
    return ref.snapshots().map((list) => list.documents.map((doc) => Routine.fromFirestore(doc)).toList());
  }

  Stream<Routine> streamRoutine(FirebaseUser user, String id) {
    return _db.collection('users').document(user.uid).collection('routines').document(id).snapshots().map((snap) => Routine.fromFirestore(snap));
  }

  Stream<List<Task>> streamTaskList(FirebaseUser user, String routineId) {
    var ref = _db.collection('users').document(user.uid).collection('routines').document(routineId).collection('tasks');
    return ref.snapshots().map((list) => list.documents.map((doc) => Task.fromFirestore(doc)).toList());
  }

  /*

    Futures

  */

  String getReminderTitle(FirebaseUser user, String routineId) {
    _db.collection('users').document(user.uid).collection('routines').document(routineId).get().then((doc) {
      return doc.data['title'];
    });
  }

  /*

   Writes

  */

  void setTaskIsDone(FirebaseUser user, String routineId, String taskId, bool value) {
    _db.collection('users').document(user.uid).collection('routines').document(routineId).collection('tasks').document(taskId).setData({
      'isDone': value,
    }, merge: true);
  }

  void setTaskName(FirebaseUser user, String routineId, String taskId, String value) {
    _db.collection('users').document(user.uid).collection('routines').document(routineId).collection('tasks').document(taskId).setData({
      'title': value,
    }, merge: true);
  }

  void createNewTask(FirebaseUser user, String routineId, String value) {
    _db.collection('users').document(user.uid).collection('routines').document(routineId).collection('tasks').add({
      'title': value,
      'isDone': false,
    });
  }

  void deleteTask(FirebaseUser user, String routineId, String taskId) {
    _db.collection('users').document(user.uid).collection('routines').document(routineId).collection('tasks').document(taskId).delete();
  }

  void uncheckRoutineTasks(FirebaseUser user, String routineId) async {
    var ref = await _db.collection('users').document(user.uid).collection('routines').document(routineId).collection('tasks').getDocuments();

    List<DocumentSnapshot> list = ref.documents;
    for (int i = 0; i < list.length; i++) {
      var thing = list[i];
      setTaskIsDone(user, routineId, thing.documentID, false);
    }
  }

  void setRoutineName(FirebaseUser user, String routineId, String value) {
    _db.collection('users').document(user.uid).collection('routines').document(routineId).setData({
      'title': value,
    }, merge: true);
  }

  void createRoutine(FirebaseUser user, String routineId, String value) {
    _db.collection('users').document(user.uid).collection('routines').add({
      'title': value,
      'isDone': false,
    });
  }

  void deleteRoutine(FirebaseUser user, String routineId) {
    _db.collection('users').document(user.uid).collection('routines').document(routineId).delete();
  }
}