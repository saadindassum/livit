import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/size_config.dart';

class VerticalStarRating extends StatelessWidget {
  //const Question({super.key});

  int rating; //Must round double to int
  List<Image> stars = [];

  VerticalStarRating(this.rating) {
    if (rating < 0) return;
    if (rating > 5) {
      rating = 5;
    }
    if (rating < 1) {
      rating = 1;
    }

    for (int i = 5; i > 0; i--) {
      if (i > rating) {
        stars.add(
          const Image(
            image: AssetImage('assets/starOutline.png'),
            height: 14,
            width: 14,
            fit: BoxFit.contain,
          ),
        );
      } else {
        stars.add(
          const Image(
            image: AssetImage('assets/star.png'),
            height: 14,
            width: 14,
            fit: BoxFit.contain,
          ),
        );
      }
      if (i <= 1) return;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (rating >= 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...stars,
        ],
      );
    }
    return Text(
      "NR",
      style: kSourceSansProMedium.copyWith(
        fontSize: SizeConfig.blockSizeHorizontal! * 2,
        color: kWhite,
      ),
    );
  }
}
