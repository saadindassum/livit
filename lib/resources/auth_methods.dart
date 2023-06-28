// file handles users' backends
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:livit/models/user.dart' as model;
import 'package:livit/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  // user signup
  Future<String> signUpUser({
    required String username,
    required String displayName,
    required String email,
    required String password,
    required String bio,
    Uint8List? file,
  }) async {
    String res = "error occurred";
    try {
      if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        // register user with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // add profile picture to firebase
        // if user has selected image upload that
        // else use default image
        String photoUrl = "";
        String logoUrl = '';
        if (file != null) {
          photoUrl = await StorageMethods()
              .uploadImageToStorage('profilePics', file, false);
        } else {
          final ByteData bytes =
              await rootBundle.load('assets/livit_default_avatar.png');
          final Uint8List defaultImg = bytes.buffer.asUint8List();
          photoUrl = await StorageMethods()
              .uploadImageToStorage('profilePics', defaultImg, false);
        }

        // add user to firebase
        model.User user = model.User(
          username: username,
          displayName: displayName,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          followers: [],
          following: [],
          photoUrl: photoUrl,
          logoUrl: logoUrl,
        );

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        res = "success";
      } else {
        res = "Please enter all fields!";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = "Email is not properly formatted!";
      } else if (err.code == 'weak-password') {
        res = "Password must be at least 6 characters long!";
      } else {
        res = err.toString();
      }
    }
    return res;
  }

  // user login
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all fields!";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = "Invalid Email!";
      } else if (err.code == 'user-not-found') {
        res = "Incorrect Email!";
      } else if (err.code == 'wrong-password') {
        res = "Incorrect Password!";
      } else {
        res = err.toString();
      }
    }
    return res;
  }

  // user signout
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
