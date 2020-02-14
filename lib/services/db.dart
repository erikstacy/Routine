import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:routine/services/models.dart';

class DatabaseService {

  final Firestore _db = Firestore.instance;

  Stream<List<Routine>> streamRoutineList(FirebaseUser user) {
    var ref = _db.collection('users').document(user.uid).collection('routines');

    return ref.snapshots().map((list) => list.documents.map((doc) => Routine.fromFirestore(doc)).toList());
  }

  Stream<Routine> streamRoutine(FirebaseUser user, String id) {
    return _db.collection('users').document(user.uid).collection('routines').document(id).snapshots().map((snap) => Routine.fromFirestore(snap));
  }

}