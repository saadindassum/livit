import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String username;
  final String displayName;
  final String email;
  final String bio;
  final String photoUrl;
  final String logoUrl;
  final List followers;
  final List following;

  const User(
      {required this.uid,
      required this.username,
      required this.displayName,
      required this.email,
      required this.bio,
      required this.photoUrl,
      required this.followers,
      required this.following,
      required this.logoUrl});

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'username': username,
        'displayName': displayName,
        'email': email,
        'bio': bio,
        'photoUrl': photoUrl,
        'logoUrl': logoUrl,
        'followers': followers,
        'following': following,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      uid: snapshot['uid'],
      username: snapshot['username'],
      displayName: snapshot['displayName'],
      email: snapshot['email'],
      bio: snapshot['bio'],
      photoUrl: snapshot['photoUrl'],
      logoUrl: snapshot['logoUrl'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }
}
