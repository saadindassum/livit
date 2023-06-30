import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:livit/models/matchable.dart';

class User implements Matchable {
  final String uid;
  final String username;
  final String displayName;
  final String email;
  final String bio;
  final String photoUrl;
  final String logoUrl;
  final List followers;
  final List following;
  final List<String> genres;
  final bool originals;
  final int starRating;

  const User({
    required this.uid,
    required this.username,
    required this.displayName,
    required this.email,
    required this.bio,
    required this.photoUrl,
    required this.logoUrl,
    required this.followers,
    required this.following,
    required this.genres,
    required this.originals,
    required this.starRating,
  });

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
      genres: snapshot['genres'],
      originals: snapshot['genres'],
      starRating: snapshot['starRating'],
    );
  }

  @override
  String getDisplayName() {
    return displayName;
  }

  @override
  String getId() {
    return uid;
  }

  @override
  String getPictureUrl() {
    return photoUrl;
  }

  @override
  String getLogoUrl() {
    return logoUrl;
  }

  @override
  int getStarRating() {
    return starRating;
  }

  @override
  MatchType getMatchType() {
    return MatchType.user;
  }

  @override
  List<String> getGenres() {
    return genres;
  }

  @override
  bool doesOriginals() {
    return originals;
  }
}
