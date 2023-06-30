import 'package:flutter/material.dart';

import 'package:livit/models/matchable.dart';
import 'package:livit/utils/app_style.dart';
import 'package:livit/utils/colors.dart';
import 'package:livit/utils/size_config.dart';

import 'package:livit/widgets/square_avatar.dart';
import 'package:livit/widgets/star_row.dart';

class MatchableCardList extends StatelessWidget {
  final List<Matchable> matchList;
  const MatchableCardList({super.key, required this.matchList});

  @override
  Widget build(BuildContext context) {
    List<Widget> wList = [];
    for (int i = 0; i < matchList.length; i++) {
      IconData matchTypeIcon = matchList[i].getMatchType() == MatchType.user
          ? const IconData(0xe491, fontFamily: 'MaterialIcons')
          : const IconData(0xf06bb, fontFamily: 'MaterialIcons');
      Color matchTypeColor =
          matchList[i].getMatchType() == MatchType.user ? tealColor : redColor;
      Widget currentWidget = Column(
        children: [
          Container(
            padding: sidePadding,
            decoration: const BoxDecoration(
              borderRadius: defaultBorderRadius,
              color: greyTransparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Avatar
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 5, 18, 5),
                      child: SquareAvatar(
                          profilePic: Image.network(
                            matchList[i].getPictureUrl(),
                            fit: BoxFit.fitHeight,
                          ),
                          size: SizeConfig.blockSizeVertical! * 8,
                          bgColor: kTangerine),
                    ),
                    //Text
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultTextStyle(
                              style: ubuntu.copyWith(
                                fontSize: 20,
                              ),
                              child: Text(matchList[i].getDisplayName())),
                          Container(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                              child: StarRow(
                                  rating: matchList[i].getStarRating(),
                                  width: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
                Icon(
                  matchTypeIcon,
                  color: matchTypeColor,
                ),
              ],
            ),
          ),
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
