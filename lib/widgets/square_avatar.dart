import 'package:flutter/material.dart';

class SquareAvatar extends StatelessWidget {
  final Image profilePic;
  final double size;
  final Color bgColor;

  const SquareAvatar({
    super.key,
    required this.profilePic,
    required this.size,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0), //or 15.0
      child: Container(
        height: size,
        width: size,
        color: bgColor,
        child: profilePic,
      ),
    );
  }
}
