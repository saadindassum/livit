import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final bool open;
  final String eid;
  final String hostID;
  final String eventName;
  final DateTime dateTime;
  final String photoUrl;
  final List<String> genreTags;
  final bool originals;

  const Event(
      {required this.open,
      required this.eid,
      required this.hostID,
      required this.eventName,
      required this.dateTime,
      required this.photoUrl,
      required this.genreTags,
      required this.originals});

  Map<String, dynamic> toJson() => {
        'open': open,
        'eid': eid,
        'hostID': hostID,
        'eventName': eventName,
        'dateTime': dateTime,
        'photoUrl': photoUrl,
        'genreTags': genreTags,
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
      genreTags: snapshot['genreTags'],
      originals: snapshot['originals'],
    );
  }
}
