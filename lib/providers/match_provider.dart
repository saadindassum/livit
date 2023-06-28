// update user state
import 'package:flutter/material.dart';
import 'package:livit/models/user.dart';
import 'dart:math';
import 'dart:convert';

///Match Provider will need a user in order to generate matches.

class MatchProvider with ChangeNotifier {
  //TODO: Plug in user to get matches

  //TODO: define the match list as it should be.
  final List<User> _matchList = const [
    User(
      uid: 'tpe',
      username: 'trevorPhillipsEnterprises',
      displayName: 'Trevor Phillips Enterprises',
      email: 'trevor@tpe.com',
      bio:
          'The guns and crank in this town go through Trevor Phillips Enterprises, or they ain\'t going.',
      photoUrl:
          'https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fimage.slidesharecdn.com%2Fgtav-trevorphillipsenterprises-131126075309-phpapp02%2F95%2Fgta-v-trevor-phillips-enterprises-identity-logo-1-638.jpg%3Fcb%3D1385474065&f=1&nofb=1&ipt=4823c0c67071bd2959a2b09f469105e176877ecae5ef6b81b4e0cd6cc5c35b2e&ipo=images',
      logoUrl:
          'https://static.wikia.nocookie.net/gtawiki/images/8/88/TrevorPhilipsIndustries-GTAV-Logo.svg/revision/latest?cb=20160916125757',
      followers: [],
      following: [],
    ),
    User(
      uid: 'pollos',
      username: 'pollosHermanos',
      displayName: 'Los Pollos Hermanos',
      email: 'fring@pollos.com',
      bio: 'Are you up to Los Pollos standards?',
      photoUrl:
          'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fcallsaulnow.com%2Fwp-content%2Fuploads%2Fgetty-images%2F2017%2F04%2F667022464-los-pollos-hermanos-opens-pop-up-restaurant-in-sydney.jpg.jpg&f=1&nofb=1&ipt=20c2372a3bb1b633a3260831117cb97840a451f0e5427e78aba4e02d6ece9e0b&ipo=images',
      logoUrl:
          'https://static.wikia.nocookie.net/breakingbad/images/5/5c/Los_Pollos.png/revision/latest?cb=20220928160229',
      followers: [],
      following: [],
    ),
    User(
      uid: 'lsCustoms',
      username: 'LosSantosCustoms',
      displayName: 'Los Santos Customs',
      email: 'dude@lsCustoms.com',
      bio: 'Repaint your car! Anything you need, just bring her in!',
      photoUrl:
          'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fgta5mod.net%2Fwp-content%2Fuploads%2F2020%2F12%2FLos-Santos-Customs-Extension-14.jpg&f=1&nofb=1&ipt=849a89cdeb334c0394a0dc69b23915a3235120d13fdc649d76e79c947560adc1&ipo=images',
      logoUrl:
          'https://w7.pngwing.com/pngs/657/680/png-transparent-grand-theft-auto-v-logo-los-santos-video-game-west-coast-offense-game-text-logo.png',
      followers: [],
      following: [],
    ),
    User(
      uid: 'hornados',
      username: 'donDieguito',
      displayName: 'Hornados Don Dieguito',
      email: 'dieguito@hornados.com',
      bio: 'Tasty hornado',
      photoUrl:
          'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fpbs.twimg.com%2Fmedia%2FCbmu0_nXIAAan1D.jpg%3Alarge&f=1&nofb=1&ipt=0339774677dec6f33b1e93583540740f472979d641e4b7d95c908b541d26d7e3&ipo=images',
      logoUrl: '',
      followers: [],
      following: [],
    )
  ];
  List<User> get matchList => _matchList;

  //TODO: Fetch the last shown match from Firebase
  int _lastShown = 0;
  int get lastShown => _lastShown;

  ///Shows you a best match from your top 50 matches.
  ///Also refreshes your last shown match
  ///Should be called on app start or reload
  void refreshBestMatch() {
    int matchIndex;
    do {
      if (_matchList.length < 50) {
        matchIndex = Random().nextInt(_matchList.length);
      } else {
        matchIndex = Random().nextInt(50);
      }
    } while (matchIndex == _lastShown);
  }

  User getBestMatch() {
    refreshBestMatch();
    return _matchList[lastShown];
  }

  //TODO: store last match in Firebase

  Future<void> refreshMatches() async {
    //TODO: Refresh the matches
    notifyListeners();
  }

  User getUserByUID(String uid) {
    //TODO: Actually implement the functionality, find something more efficient than a for loop
    for (int i = 0; i < _matchList.length; i++) {
      if (_matchList[i].uid == uid) return _matchList[i];
    }
    return const User(
      uid: '',
      username: '',
      displayName: '',
      email: '',
      bio: '',
      photoUrl: '',
      logoUrl: '',
      followers: [],
      following: [],
    );
  }

  //Comment out dummy data
  // List<User> dummyList = const [
  // User(
  //     uid: 'tpe',
  //     username: 'trevorPhillipsEnterprises',
  //     displayName: 'Trevor Phillips Enterprises',
  //     email: 'trevor@tpe.com',
  //     bio:
  //         'The guns and crank in this town go through Trevor Phillips Enterprises, or they ain\'t going.',
  //     photoUrl:
  //         'https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fimage.slidesharecdn.com%2Fgtav-trevorphillipsenterprises-131126075309-phpapp02%2F95%2Fgta-v-trevor-phillips-enterprises-identity-logo-1-638.jpg%3Fcb%3D1385474065&f=1&nofb=1&ipt=4823c0c67071bd2959a2b09f469105e176877ecae5ef6b81b4e0cd6cc5c35b2e&ipo=images',
  //     logoUrl:
  //         'https://static.wikia.nocookie.net/gtawiki/images/8/88/TrevorPhilipsIndustries-GTAV-Logo.svg/revision/latest?cb=20160916125757',
  //     followers: [],
  //     following: [],
  //   ),
  //   User(
  //     uid: 'pollos',
  //     username: 'pollosHermanos',
  //     displayName: 'Los Pollos Hermanos',
  //     email: 'fring@pollos.com',
  //     bio: 'Are you up to Los Pollos standards?',
  //     photoUrl:
  //         'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fcallsaulnow.com%2Fwp-content%2Fuploads%2Fgetty-images%2F2017%2F04%2F667022464-los-pollos-hermanos-opens-pop-up-restaurant-in-sydney.jpg.jpg&f=1&nofb=1&ipt=20c2372a3bb1b633a3260831117cb97840a451f0e5427e78aba4e02d6ece9e0b&ipo=images',
  //     logoUrl:
  //         'https://static.wikia.nocookie.net/breakingbad/images/5/5c/Los_Pollos.png/revision/latest?cb=20220928160229',
  //     followers: [],
  //     following: [],
  //   ),
  //   User(
  //     uid: 'lsCustoms',
  //     username: 'LosSantosCustoms',
  //     displayName: 'Los Santos Customs',
  //     email: 'dude@lsCustoms.com',
  //     bio: 'Repaint your car! Anything you need, just bring her in!',
  //     photoUrl:
  //         'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fgta5mod.net%2Fwp-content%2Fuploads%2F2020%2F12%2FLos-Santos-Customs-Extension-14.jpg&f=1&nofb=1&ipt=849a89cdeb334c0394a0dc69b23915a3235120d13fdc649d76e79c947560adc1&ipo=images',
  //     logoUrl:
  //         'https://w7.pngwing.com/pngs/657/680/png-transparent-grand-theft-auto-v-logo-los-santos-video-game-west-coast-offense-game-text-logo.png',
  //     followers: [],
  //     following: [],
  //   ),
  //   User(
  //     uid: 'hornados',
  //     username: 'donDieguito',
  //     displayName: 'Hornados Don Dieguito',
  //     email: 'dieguito@hornados.com',
  //     bio: 'Tasty hornado',
  //     photoUrl:
  //         'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fpbs.twimg.com%2Fmedia%2FCbmu0_nXIAAan1D.jpg%3Alarge&f=1&nofb=1&ipt=0339774677dec6f33b1e93583540740f472979d641e4b7d95c908b541d26d7e3&ipo=images',
  //     logoUrl: '',
  //     followers: [],
  //     following: [],
  //   )
  // ];
}
