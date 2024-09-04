import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:power_maids/Utils/cached_netword_image.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/nodata_image.dart';
import 'package:power_maids/app/modules/MaidDetails/model/details_model.dart';



class ReviewScreen extends StatelessWidget {
  List<ReviewList> reviewlist;
  ReviewScreen({super.key, required this.reviewlist});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 80,
          ),
          reviewlist.isEmpty? const SizedBox():
          Textwidget(
            text: "All Reviews",
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(
            height: 15,
          ),
          reviewlist.isEmpty? NoDataFound(height: MediaQuery.of(context).size.height/4):
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount:reviewlist.length,
              shrinkWrap: true,
              itemBuilder: (buildContext, index) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: const BoxDecoration(shape: BoxShape.circle),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: LoadingImage(image: reviewlist[index].image, fit: BoxFit.cover,)
                                    ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Textwidget(
                                  fontWeight: FontWeight.w700,
                                  text: reviewlist[index].customerName,
                                ),
                                RatingBar.builder(
                                  ignoreGestures: true,
                                  itemSize: 13,
                                  initialRating: double.parse(reviewlist[index].rating),
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding:
                                      const EdgeInsets.symmetric(horizontal: 0.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: AppStyles.StarIconColor,
                                  ),
                                  onRatingUpdate: (rating) {
                                    log(rating.toString());
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                        Textwidget(
                          fontSize: 12,
                          text: reviewlist[index].timeAgo,
                        )
                      ],
                    ),
                    Textwidget(
                      color: AppStyles.BlacklightTextcolor,
                      fontSize: 12,
                      maxLines: 100,
                      text: reviewlist[index].review
                    ),
                    const Divider()
                  ],
                );
              })
        ],
      ),
    );
  }
}
