import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:livit/utils/size_config.dart';
import 'package:provider/provider.dart';

import 'package:livit/models/user.dart';

import 'package:livit/utils/app_style.dart';

import 'package:livit/providers/user_provider.dart';
import 'package:livit/providers/event_provider.dart';
import 'package:livit/providers/match_provider.dart';

class ExploreScreen extends StatelessWidget with WidgetsBindingObserver {
  const ExploreScreen({super.key});

  /*User getFeaturedEventHost(context) {
    return context
        .watch<MatchProvider>()
        .getUserByUID(context.watch<EventProvider>().nextMatchingEvent.hostID);
  }*/

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat.yMMMd();

    return Stack(
      children: [
        //COMPONENT: Background Image
        SizedBox(
          height: SizeConfig.blockSizeVertical! * 70,
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
        //COMPONENT: Event Text
        Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          height: SizeConfig.blockSizeVertical! * 70,
          child: Expanded(
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
                (context
                            .watch<MatchProvider>()
                            .getUserByUID(context
                                .watch<EventProvider>()
                                .nextMatchingEvent
                                .hostID)
                            .logoUrl ==
                        '')
                    ? DefaultTextStyle(
                        style: ubuntu.copyWith(fontSize: SizeConfig.paragraph),
                        child: Text(
                          context
                              .watch<MatchProvider>()
                              .getUserByUID(context
                                  .watch<EventProvider>()
                                  .nextMatchingEvent
                                  .hostID)
                              .displayName,
                          overflow: TextOverflow.visible,
                        ),
                      )
                    : SizedBox(
                        width: SizeConfig.blockSizeHorizontal! * 10,
                        child: Image.network(context
                            .watch<MatchProvider>()
                            .getUserByUID(context
                                .watch<EventProvider>()
                                .nextMatchingEvent
                                .hostID)
                            .logoUrl),
                      ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
