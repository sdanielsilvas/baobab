import 'package:baobab_app/models/time_line_app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'abstract_repositorie.dart';

class FirestoreRepository extends Repository {


  static const String TIMELINE_COLLECTION = 'timeline';
  static const String ACHIEVEMENT_COLLECTION = 'achievements';
  static Firestore _firestore = Firestore.instance;


  Stream<List<Achievement>> getAchievements(String team) =>
      _firestore.collection(TIMELINE_COLLECTION)
          .document(team)
          .collection(ACHIEVEMENT_COLLECTION)
          .snapshots()
          .map((snapshot) =>
          snapshot.documents
              .map((doc) => Achievement.fromJson(doc.data))
              .toList());


  Stream<List<TimeLineApp>> getTimeLinesApp() =>
      _firestore.collection(TIMELINE_COLLECTION).snapshots()
          .map((snapshot) => snapshot.documents.map((doc) => TimeLineApp.fromJson(doc.data)).toList());



  Stream<List<TimeLineApp>> getTimeLinesAppSub() {
    return _firestore.collection(TIMELINE_COLLECTION).snapshots()
        .map((snapshot) => snapshot.documents.map((doc) {
      return  TimeLineApp.fromJson(doc.data);
    }).toList());
  }






}