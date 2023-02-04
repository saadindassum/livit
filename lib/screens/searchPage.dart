import 'package:flutter/material.dart';
import '../models/musicianBeta.dart';
import 'userBrowser.dart';
import '../utils/colors.dart';
import 'userBlock.dart';

//import 'dart:math';

/// TODO: Get the actual user's preferred genres so you can plug them into the user blocks.
/// TODO: Make sure you store a sorted copy of every user's genres to make comparing faster.
///   That might work as a hash map with a map to the user's ranking of the genre
class SearchPage extends StatefulWidget {
  List<UserBlock> users = [];
  SearchPage() {
    users = [
      UserBlock(musician: Musician(), userGenres: const ["Chicken Music"]),
      UserBlock(musician: Musician(), userGenres: const ["Classic Rock"]),
      UserBlock(musician: Musician(), userGenres: const ["Rock"]),
      UserBlock(musician: Musician(), userGenres: const ["Chicken Music"]),
      UserBlock(musician: Musician(), userGenres: const ["Classic Rock"]),
      UserBlock(musician: Musician(), userGenres: const ["Rock"]),
      UserBlock(musician: Musician(), userGenres: const ["Chicken Music"]),
      UserBlock(musician: Musician(), userGenres: const ["Classic Rock"]),
      UserBlock(musician: Musician(), userGenres: const ["Rock"]),
      UserBlock(musician: Musician(), userGenres: const ["Chicken Music"]),
      UserBlock(musician: Musician(), userGenres: const ["Classic Rock"]),
      UserBlock(musician: Musician(), userGenres: const ["Rock"]),
    ];
  }

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkBG,
      child: Column(children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.only(left: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: TextField(
                  style: TextStyle(color: kWhite),
                  obscureText: false,
                  cursorColor: kWhite,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: kWhite),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kWhite),
                    ),
                    labelText: 'find a musician',
                    labelStyle: TextStyle(color: kWhite),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
                color: kWhite,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(child: UserBrowser(users: widget.users)),
      ]),
    );
  }
}
