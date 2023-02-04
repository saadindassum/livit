import 'dart:collection';

import 'package:flutter/material.dart';
import 'verticalStarRating.dart';
import '../utils/stats.dart';
import 'package:livit/models/musicianBeta.dart';
import '../models/venueBeta.dart';
import '../utils/colors.dart';
import '../utils/size_config.dart';

/// Userblock class for displaying user summaries in the search page
/// TODO: Add field for picture thumbnail in  here
/// TODO: highlight genres that match the user
/// TODO: Text overflow clipping isn't working for some reason. Fix. Expanded widget is obvious answer but it doesn't work
/// TODO: Implement genresString for Venue searches
/// TODO: Figure out how to implement a hash set instead of a String List for User Genres? Unless it's equally as fast in Dart.
/// TODO: Convert all tags to lowercase when comparing genres. This might have to be done when storing genres.
/// TODO: If the above has to be done when storing, make sure all the ones that were already stored are turned to lowercase

class UserBlock extends StatelessWidget {
  //const Question({super.key});

  String name = "";
  VerticalStarRating rating = VerticalStarRating(5);
  String imgURL = "";

  List<String> userGenres = [];
  List<TextSpan> spans = [];

  UserBlock({super.key, required Musician musician, required userGenres}) {
    name = musician.name;
    rating = VerticalStarRating(musician.rating.round());
    imgURL = 'https://i.redd.it/7uz6pae120s71.jpg';
    List<String> genres = musician.getGenres();

    //In for loop, we create the genres string, and we find every genre we should highlight
    for (int i = 0; i < genres.length; i++) {
      String genresString = "";
      genresString += genres[i];
      if (i != genres.length - 1) genresString += ", ";

      //Check if current genre matches user
      if (userGenres.contains(genres[i])) {
        //genre has beeen matched, add a bold text span
        spans.add(TextSpan(
            text: genres[i],
            style: kSourceSansProBold.copyWith(
                fontSize: SizeConfig.blockSizeHorizontal! * 2.5,
                color: kWhite)));
        if (i != genres.length - 1) spans.add(TextSpan(text: ", "));
      } else {
        spans.add(TextSpan(text: genresString));
      }
    }
  }

  UserBlock.fromVenue({super.key, required Venue venue}) {
    name = venue.name;
    rating = VerticalStarRating(venue.rating);
    imgURL =
        'https://static.independent.co.uk/s3fs-public/thumbnails/image/2015/05/01/15/lospolloshermanos.jpg?quality=75&width=990&auto=webp&crop=982:726,smart';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        SizedBox(
            height: 100,
            child: Container(
              margin: const EdgeInsets.only(
                left: 6,
                right: 6,
              ),
              padding: const EdgeInsets.fromLTRB(7, 5, 5, 7),
              decoration: BoxDecoration(
                color: lBlue,
                borderRadius: BorderRadius.circular(kBorderRadius),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 5,
                    offset: Offset(0, 2),
                    color: kBoxShadowColor,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        //Avatar
                        borderRadius:
                            BorderRadius.circular(kBorderRadius), //or 15.0
                        child: Container(
                          height: 95.0,
                          width: 95.0,
                          color: const Color(0xffFF0E58),
                          child: Image.network(
                            imgURL,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(14, 0, 0, 5),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 2,
                            ),
                            Container(
                              padding: const EdgeInsets.only(right: 13.0),
                              child: Text(
                                name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: kSourceSansProBold.copyWith(
                                  fontSize: SizeConfig.blockSizeHorizontal! * 5,
                                  color: kWhite,
                                ),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: kSourceSansProMedium.copyWith(
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal! * 2.5,
                                    color: kWhite),
                                children: spans,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 4, 7, 4),
                    child: rating,
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
