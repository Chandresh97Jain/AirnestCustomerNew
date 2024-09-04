import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:power_maids/Utils/color_style.dart';

class RatingBarGlobal extends StatelessWidget {
  final double?    initialRating;
  final ignoreGestures;

  const RatingBarGlobal({Key? key,  this.initialRating,this.ignoreGestures}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return                                  RatingBar.builder(
      ignoreGestures: ignoreGestures,
      itemSize: 13,
      initialRating: initialRating!.toDouble(),
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding:
      const EdgeInsets.symmetric(
          horizontal: 0.0),
      itemBuilder: (context, _) =>
          Icon(
            Icons.star,
            color: AppStyles
                .StarIconColor,
          ),
      onRatingUpdate: (rating) {
      },
    );

  }
}
