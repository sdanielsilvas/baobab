import 'package:baobab_app/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class User {
  String id;

  String fullName;

  String email;

  FirebaseUser firebaseUser;

  static String _usersCollectionPath = 'users';

  static String _userLastLoginFieldName = 'lastLogin';

  User({@required this.id, @required this.fullName, @required this.email, this.firebaseUser});

  /// Create a [User] from a FirebaseUser [user]. Typically from the result of a signup or login event.
  factory User.fromFirebaseUser(FirebaseUser user) {
    return User(
      id: user.uid,
      fullName: user.displayName,
      email: user.email,
      firebaseUser: user,
    );
  }

  /// Saves the details of a user to the database at the path 'users/userID'
  ///
  /// If this is a new user then their details will be written as normal.
  /// If the user already exists their details will be merged with the existing document on Firestore.
  void saveUserToDatabase() {
    Database.mergeDocumentWithIDAtCollection(_usersCollectionPath, this.id, this.toMap());
  }

  /// Turns the User object into a map that can be used by the database to save to a user document.
  Map<String, dynamic> toMap() {
    return {
      'fullName': this.fullName,
      'email': this.email,
    };
  }

  /// Set the user's lastLogin field to now.
  void updateLastLoginTime() {
    Database.setDocumentTimestampNowWithIDAtCollection(_usersCollectionPath, this.id, _userLastLoginFieldName);
  }
}
