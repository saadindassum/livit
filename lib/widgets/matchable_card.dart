import 'package:flutter/material.dart';
import 'package:livit/models/matchable.dart';
import 'package:livit/utils/app_style.dart';
import 'package:livit/utils/colors.dart';
import 'package:livit/utils/size_config.dart';
import 'package:livit/widgets/square_avatar.dart';
import 'package:livit/widgets/star_row.dart';

class MatchableCard extends StatelessWidget {
  final Matchable match;
  const MatchableCard(this.match, {super.key});

  @override
  Widget build(BuildContext context) {
    IconData matchTypeIcon = match.getMatchType() == MatchType.user
        ? const IconData(0xe491, fontFamily: 'MaterialIcons')
        : const IconData(0xf06bb, fontFamily: 'MaterialIcons');
    Color matchTypeColor =
        match.getMatchType() == MatchType.user ? tealColor : redColor;
    return Container(
      height: SizeConfig.blockSizeVertical! * 10,
      width: double.infinity,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Avatar
              Container(
                padding: const EdgeInsets.fromLTRB(0, 5, 18, 5),
                child: SquareAvatar(
                    profilePic: Image.network(
                      match.getPictureUrl(),
                      fit: BoxFit.fitHeight,
                    ),
                    size: SizeConfig.blockSizeVertical! * 8,
                    bgColor: kTangerine),
              ),
              //Text
              Container(
                width: SizeConfig.blockSizeHorizontal! * 50,
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextStyle(
                      style: ubuntu.copyWith(
                        fontSize: 20,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      child: Text(match.getDisplayName()),
                    ),
                    Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                        child:
                            StarRow(rating: match.getStarRating(), width: 12)),
                  ],
                ),
              ),
            ],
          ),
          Icon(
            matchTypeIcon,
            size: 32,
            color: matchTypeColor,
          ),
        ],
      ),
    );
  }
}
