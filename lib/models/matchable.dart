enum MatchType {
  user,
  event,
}

abstract class Matchable {
  String getId();
  String getDisplayName();
  String getPictureUrl();
  String getLogoUrl();
  MatchType getMatchType();
  int getStarRating();
  List<String> getGenres();
  bool doesOriginals();
}
