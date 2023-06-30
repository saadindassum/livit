import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:livit/models/matchable.dart';

class Event implements Matchable {
  final bool open;
  final String eid;
  final String hostID;
  final String eventName;
  final DateTime dateTime;
  final String photoUrl;
  final List<String> genres;
  final bool originals;

  const Event(
      {required this.open,
      required this.eid,
      required this.hostID,
      required this.eventName,
      required this.dateTime,
      required this.photoUrl,
      required this.genres,
      required this.originals});

  Map<String, dynamic> toJson() => {
        'open': open,
        'eid': eid,
        'hostID': hostID,
        'eventName': eventName,
        'dateTime': dateTime,
        'photoUrl': photoUrl,
        'genres': genres,
        'originals': originals,
      };

  static Event fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Event(
      open: snapshot['open'],
      eid: snapshot['eid'],
      hostID: snapshot['hostID'],
      eventName: snapshot['eventName'],
      dateTime: snapshot['dateTime'],
      photoUrl: snapshot['photoUrl'],
      genres: snapshot['genres'],
      originals: snapshot['originals'],
    );
  }

  @override
  String getDisplayName() {
    return eventName;
  }

  @override
  String getId() {
    return eid;
  }

  @override
  String getPictureUrl() {
    return photoUrl;
  }

  @override
  String getLogoUrl() {
    return '';
  }

  @override
  MatchType getMatchType() {
    return MatchType.event;
  }

  @override
  int getStarRating() {
    return 0;
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
