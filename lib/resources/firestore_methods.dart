// file provides specific firebase functions
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:livit/models/post.dart';
import 'package:livit/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // upload post
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage,
  ) async {
    String res = "error occurred";

    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = const Uuid().v1();

      Post post = Post(
        uid: uid,
        username: username,
        description: description,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
        stars: [],
      );

      _firestore.collection('posts').doc(postId).set(post.toJson());

      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // update stars
  Future<String> likePost(
    String postId,
    String uid,
    List stars,
  ) async {
    String res = "error occurred";

    try {
      if (stars.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'stars': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'stars': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // store comment
  Future<String> postComment(
    String postId,
    String text,
    String uid,
    String username, // any error change back to name??
    String profilePic,
  ) async {
    String res = "error occurred";

    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'username': username,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
      } else {
        res = "Text is empty!";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // delete post
  Future<String> deletePost(String postId) async {
    String res = "error occurred";

    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // follow/unfollow users
  Future<String> followUser(String uid, String followId) async {
    String res = "error occurred";

    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
