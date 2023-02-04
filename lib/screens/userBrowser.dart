import 'package:flutter/material.dart';
import 'userBlock.dart';

/// UserBrowser is a component of SearchPage in which users will pop up
/// It consists of a ListView which displays a list of relevant  users.
/// TODO: User browser needs to pass the  highlighted

class UserBrowser extends StatefulWidget {
  final List<UserBlock> users;

  const UserBrowser({required this.users});

  @override
  _UserBrowserState createState() => _UserBrowserState();
}

class _UserBrowserState extends State<UserBrowser> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ...(widget.users),
      ],
    );
  }
}
