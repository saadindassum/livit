class Venue {
  final String uid = "69420";
  final String name = "Los Pollos Hermanos";
  final String handle = "@chickenbros";
  final int rating = 5;

  const Venue();

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
