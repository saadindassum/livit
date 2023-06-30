import 'package:flutter/material.dart';
import 'package:livit/utils/colors.dart';

class StarRow extends StatelessWidget {
  final int rating;
  final double width;
  const StarRow({
    super.key,
    required this.rating,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> wList = [];
    for (int i = 0; i < rating; i++) {
      wList.add(Icon(
        const IconData(0xe5f9, fontFamily: 'MaterialIcons'),
        size: width,
        color: kTangerine,
      ));
      wList.add(
        SizedBox(
          width: width,
        ),
      );
    }
    return SizedBox(
      height: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: wList,
      ),
    );
  }
}
