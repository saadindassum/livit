// update user state
import 'package:flutter/material.dart';
import 'package:livit/models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user = const User(
    uid: 'joeMomma42069',
    username: 'saullyG',
    displayName: 'Slippin\' Jimmy',
    email: 'callSaul@saul.com',
    bio: 'I did ur mom',
    photoUrl:
        'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.theeffect.net%2Fwp-content%2Fuploads%2F2013%2F12%2FSaul-Goodman-aka-Bob-Odenkirk.jpg&f=1&nofb=1&ipt=521d70542063bb09ca9bce6590ff997a9c788858141eb4cb431f8517a8b1012f&ipo=images',
    logoUrl:
        'https://upload.wikimedia.org/wikipedia/en/thumb/8/8a/Better_Call_Saul_logo.svg/1200px-Better_Call_Saul_logo.svg.png',
    followers: [],
    following: [],
    genres: ['lawyer music', 'rock', 'smoke on the water'],
    originals: true,
    starRating: 5,
  );

  User get getUser => _user!;

  // Future<void> refreshUser() async {
  //   User user = await _authMethods.getUserDetails();
  //   _user = user;
  //   notifyListeners();
  //}
}
