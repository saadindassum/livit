import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:livit/models/base_user.dart';

class Venue extends BaseUser {
  final String uid;
  final String name;
  final String handle;
  final String email;
  final String bio;
  final String photoUrl;
  final int rating;
  final List<String> genres;
  final bool anyGenre; //User does all genres
  final List<String> vibes;
  final List<String> artists;
  final bool originals;
  final List followers;
  final List following;

  const Venue({
    required this.uid,
    required this.name,
    required this.email,
    required this.handle,
    required this.bio,
    required this.photoUrl,
    required this.rating,
    required this.genres,
    required this.anyGenre,
    required this.vibes,
    required this.artists,
    required this.originals,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'handle': handle,
        'email': email,
        'bio': bio,
        'photoUrl': photoUrl,
        'rating': rating,
        'genres': genres,
        'anyGenre': anyGenre,
        'vibes': vibes,
        'artists': artists,
        'originals': originals,
        'followers': followers,
        'following': following,
      };

  static Venue fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Venue(
      uid: snapshot['uid'],
      name: snapshot['name'],
      handle: snapshot['handle'],
      email: snapshot['email'],
      bio: snapshot['bio'],
      photoUrl: snapshot['photoUrl'],
      rating: snapshot['rating'],
      genres: snapshot['genres'],
      anyGenre: snapshot['anyGenre'],
      vibes: snapshot['vibes'],
      artists: snapshot['artists'],
      originals: snapshot['originals'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }

  @override
  getName() {
    return name;
  }

  @override
  void setName() {
    // TODO: implement setName
    throw UnimplementedError();
  }

  @override
  String getUID() {
    return uid;
  }
}
