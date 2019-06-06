import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  /// The reference to the default Firebase app
  static Firestore _firestore = Firestore.instance;

  /// Creates a new document in the path specified by [collectionPath]
  static void createDocumentAtCollection(String collectionPath, Map<String, dynamic> data) {
    _firestore.collection(collectionPath).document().setData(data);
  }

  /// Creates a new document with the provided [documentID] at the [collectionPath]
  /// If a document with [documentID] already exists it will be overwritten.
  static void createDocumentWithIDAtCollection(String collectionPath, String documentID, Map<String, dynamic> data) {
    _firestore.collection(collectionPath).document(documentID).setData(data);
  }

  /// Creates a new document with the provided [documentID] at the [collectionPath]
  /// If a document with [documentID] already exists it will be merged with the [data] provided.
  static void mergeDocumentWithIDAtCollection(String collectionPath, String documentID, Map<String, dynamic> data) {
    _firestore.collection(collectionPath).document(documentID).setData(data, merge: true);
  }

  /// Converts [document] into a map. Takes [document.data] and merges it with [document.documentID]
  /// to make one singular map of details needed.
  static Map<String, dynamic> _documentToMap(DocumentSnapshot document) {
    Map<String, dynamic> m = document.data;
    m['id'] = document.documentID;
    return m;
  }

  static Map<String, dynamic> _documentSubToMap(DocumentSnapshot document, List<Map<String, dynamic>> children,
      {String subLevel}) {
    Map<String, dynamic> m = document.data;
    if (children != null) {
      m[subLevel] = children;
    }
    m['id'] = document.documentID;
    return m;
  }

// Sets the timestamp field [timestampFieldName] of the document with [documentID] in the collection
  /// at [collectionPath] to update to now.
  static void setDocumentTimestampNowWithIDAtCollection(
      String collectionPath, String documentID, String timestampFieldName) {
    _firestore.collection(collectionPath).document(documentID).setData({
      timestampFieldName: Timestamp.now(),
    }, merge: true);
  }

  /// Reads a maximum of [limit] documents from the collection at [collectionPath] and orders them by
  /// their [timestamp] descending.
  static Future<List<Map<String, dynamic>>> readDocumentsAtCollectionWithLimitByTimestampDescending(
      String collectionPath, int limit,
      {String subLevel}) async {
    Query query = _firestore.collection(collectionPath).limit(limit);

    QuerySnapshot snapshot = await query.getDocuments();
    List<DocumentSnapshot> documents = snapshot.documents;
    
    List<Map<String, dynamic>> data = documents.map((document) => _documentToMap(document)).toList();

    return Future.value(data);
  }

  static Future<List<Map<String, dynamic>>> _readDocumentsSubCollection(
      String documentId, String collectionPath, String subCollectionPath, int limit) async {
    Query query = _firestore.collection(collectionPath).document(documentId).collection(subCollectionPath);
    QuerySnapshot subSnapshot = await query.getDocuments();

    List<DocumentSnapshot> subDocuments = subSnapshot.documents;
    List<Map<String, dynamic>> data = subDocuments.map((playList) => _documentToMap(playList)).toList();
    return data;
  }

  static Future<List<Map<String, dynamic>>> readDocumentsSubCollection(
      String documentId, String collectionPath, String subCollectionPath, int limit) async {
    Query query = _firestore.collection(collectionPath).document(documentId).collection(subCollectionPath);
    QuerySnapshot subSnapshot = await query.getDocuments();

    List<DocumentSnapshot> subDocuments = subSnapshot.documents;
    List<Map<String, dynamic>> data = subDocuments.map((playList) => _documentToMap(playList)).toList();
    return Future.value(data);
  }



  static Future<List<Map<String, dynamic>>> readDocumentsThreeCollection(
      String documentId, String collectionPath, String subCollectionPath, String subcollectionId,String threeCollectionPath) async {
    Query query = _firestore.collection(collectionPath).document(documentId).
    collection(subCollectionPath).document(subcollectionId).collection(threeCollectionPath);
    QuerySnapshot subSnapshot = await query.getDocuments();

    List<DocumentSnapshot> subDocuments = subSnapshot.documents;
    List<Map<String, dynamic>> data = subDocuments.map((playList) => _documentToMap(playList)).toList();
    return Future.value(data);
  }





}
