import 'package:flutter/material.dart';

import 'package:livit/models/matchable.dart';
import 'package:livit/utils/app_style.dart';
import 'package:livit/utils/colors.dart';
import 'package:livit/utils/size_config.dart';
import 'package:livit/widgets/matchable_card.dart';

import 'package:livit/widgets/square_avatar.dart';
import 'package:livit/widgets/star_row.dart';

class MatchableCardList extends StatelessWidget {
  final List<Matchable> matchList;
  const MatchableCardList({super.key, required this.matchList});

  @override
  Widget build(BuildContext context) {
    List<Widget> wList = [];
    for (int i = 0; i < matchList.length; i++) {
      Widget currentWidget = Column(
        children: [
          MatchableCard(matchList[i]),
          const SizedBox(
            height: 20,
          )
        ],
      );
      wList.add(currentWidget);
    }
    return Column(
      children: wList,
    );
  }
}
