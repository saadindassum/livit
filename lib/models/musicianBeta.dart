class Musician {
  final String uid = "42069";
  final String name = "Saul Goodman";
  final String handle = "@saulgoodman";
  final List<String> genres = [
    "Rock",
    "Classic Rock",
    "Chicken Music",
    /*"Soundtracks",
    "People music",
    "More music"*/
  ];
  final double rating = 3;

  Musician();

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

  @override
  List<String> getGenres() {
    return genres;
  }
}
