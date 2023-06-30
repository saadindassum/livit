import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:livit/utils/size_config.dart';
import 'package:livit/widgets/matchable_card_list.dart';
import 'package:provider/provider.dart';

import 'package:livit/utils/app_style.dart';
import 'package:livit/utils/colors.dart';
import 'package:livit/providers/event_provider.dart';
import 'package:livit/providers/match_provider.dart';

class ExploreScreen extends StatelessWidget with WidgetsBindingObserver {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat.yMMMd();
    String logoUrl = context
        .watch<MatchProvider>()
        .getUserByUID(context.watch<EventProvider>().nextMatchingEvent.hostID)
        .getLogoUrl();

    return Stack(
      children: [
        //COMPONENT: Background Image
        SizedBox(
          height: SizeConfig.blockSizeVertical! * 80,
          width: double.infinity,
          child: ShaderMask(
            shaderCallback: (Rect rect) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: Image.network(
              context.watch<EventProvider>().nextMatchingEvent.photoUrl,
              fit: BoxFit.fitHeight,
              loadingBuilder: (context, child, loadingProgress) {
                return loadingProgress == null
                    ? child
                    : Center(
                        child: SizedBox(
                          width: SizeConfig.blockSizeHorizontal! * 20,
                          height: SizeConfig.blockSizeHorizontal! * 20,
                          child: const CircularProgressIndicator(),
                        ),
                      );
              },
            ),
          ),
        ),
        //Scrollable area
        Container(
          padding: sidePadding,
          child: SingleChildScrollView(
            //COMPONENT: Featured Event Text
            child: Column(
              children: [
                Container(
                  padding: sidePadding,
                  height: SizeConfig.blockSizeVertical! * 65,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultTextStyle(
                            style: ubuntu.copyWith(
                              fontSize: SizeConfig.title,
                              color: kTangerine,
                            ),
                            child: Text(context
                                .watch<EventProvider>()
                                .nextMatchingEvent
                                .eventName),
                          ),
                          DefaultTextStyle(
                            style: ubuntu.copyWith(
                              fontSize: SizeConfig.subtitle,
                            ),
                            child: Text(
                              '${DateFormat('EEEE').format(context.watch<EventProvider>().nextMatchingEvent.dateTime)} ${formatter.format(context.watch<EventProvider>().nextMatchingEvent.dateTime)}',
                            ),
                          ),
                        ],
                      ),
                      //if host has logo, display logo. If not, name
                      (logoUrl == '')
                          ? DefaultTextStyle(
                              style: ubuntu.copyWith(
                                  fontSize: SizeConfig.paragraph),
                              child: Text(
                                context
                                    .watch<MatchProvider>()
                                    .getUserByUID(context
                                        .watch<EventProvider>()
                                        .nextMatchingEvent
                                        .hostID)
                                    .getDisplayName(),
                                overflow: TextOverflow.visible,
                              ),
                            )
                          : SizedBox(
                              width: SizeConfig.blockSizeHorizontal! * 30,
                              child: Image.network(logoUrl),
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 8,
                ),
                //List of matches
                MatchableCardList(
                    matchList: context.watch<MatchProvider>().matchList)
              ],
            ),
          ),
        )
      ],
    );
  }
}
