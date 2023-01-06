import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _collectionReference = FirebaseFirestore.instance.collection('staff');

  //create user
  Future<String> createUser(
      {required BuildContext ctx, required String email, required String password, required String name, required bool isManager}) async {
    String message = 'User successfully created';

    try {
      UserCredential authUser = await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = authUser.user as User;
      await user.updateDisplayName(name);

      //create doc
      final details = {
        'email': email,
        'isManager': isManager,
        'name': name,
        'photoUrl': '',
        'uid': user.uid,
      };

      //store doc on firestore
      await _collectionReference.add(details);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-exists') {
        message = 'Email already exists';
      }
      else if (e.code == 'invalid-display-name') {
        message = 'Name is not valid';
      }
      else if (e.code == 'invalid-email') {
        message = 'Email is invalid';
      }
      else if (e.code == 'invalid-password') {
        message = 'Password must be at least 6 characters long';
      }
    }
    return message;
  }

  //change password
  Future<void> changePassword() async {
    await _firebaseAuth.sendPasswordResetEmail(
      email: _firebaseAuth.currentUser!.email as String,
    );
  }

  //sign out
  void logOut() {
    _firebaseAuth.signOut();
  }

  //update display name
  Future updateDisplayName(String name) async {
    await _firebaseAuth.currentUser!.updateDisplayName(name);
    QuerySnapshot qs = await _collectionReference.get();

    if (qs.docs.isNotEmpty) {
      for (int i = 0; i < qs.docs.length; i++) {
        if (qs.docs[i]['uid'] == _firebaseAuth.currentUser!.uid) {
          qs.docs[i].reference.update({
            'name': name,
          });
        }
      }
    }
  }

  //update profile picture
  Future updateProfilePicture(String path) async {
    await _firebaseAuth.currentUser!.updatePhotoURL(path);

    QuerySnapshot qs = await _collectionReference.get();

    if (qs.docs.isNotEmpty) {
      for (int i = 0; i < qs.docs.length; i++) {
        if (qs.docs[i]['uid'] == _firebaseAuth.currentUser!.uid) {
          qs.docs[i].reference.update({
            'photoUrl': path,
          });
        }
      }
    }
  }

  //get profile picture
  String getProfilePicture() {
    return _firebaseAuth.currentUser!.photoURL.toString();
  }

  //update email address
  Future updateEmailAddress(String newEmail) async {
    await _firebaseAuth.currentUser!.updateEmail(newEmail);

    QuerySnapshot qs = await _collectionReference.get();

    if (qs.docs.isNotEmpty) {
      for (int i = 0; i < qs.docs.length; i++) {
        if (qs.docs[i]['uid'] == _firebaseAuth.currentUser!.uid) {
          qs.docs[i].reference.update({
            'email': newEmail,
          });
        }
      }
    }
  }

  //delete account
  Future deleteAccount() async {
    await _firebaseAuth.currentUser!.delete();

    QuerySnapshot qs = await _collectionReference.get();

    if (qs.docs.isNotEmpty) {
      for (int i = 0; i < qs.docs.length; i++) {
        if (qs.docs[i]['uid'] == _firebaseAuth.currentUser!.uid) {
          qs.docs[i].reference.delete();
        }
      }
    }
  }
}
