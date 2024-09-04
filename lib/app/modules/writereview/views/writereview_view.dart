import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/cached_netword_image.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/Utils/textformfield_ui_global.dart';
import 'package:power_maids/app/modules/writereview/controllers/writereview_controller.dart';


class WritereviewView extends GetView<WritereviewController> {
  const WritereviewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppStyles.backgroundColor,
        titleSpacing: 5,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: AppStyles.backgroundColor,
        title: AppbarWithBackButton(
          text: "Write a Review",
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: false,
      ),
      body: Obx(() => Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height:80,
                        width: 80,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: LoadingImage(
                                image: controller.cleanerImage.value??"",
                                fit: BoxFit.fill
                            )
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Textwidget(
                              text: "Cleaner",
                              color: AppStyles.GrayTextColor,
                            ),
                            Textwidget(
                              text: controller.cleanerName.value,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                            Textwidget(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              maxLines: 50,
                              text: controller.description.value,
            
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            
                  const SizedBox(
                    height: 15,
                  ),
                  Divider(
                    thickness: 1,
                    height: 0,
                    color: AppStyles.deviderColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
            
                  Textwidget(
                    text: "How would you rate it?",
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                  const SizedBox(height: 10),
                  RatingBar.builder(
                    initialRating: controller.rating.value.toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 50.0,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star_border_rounded,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      controller.rating.value = rating.toInt();
                    },
                  ),
                  const SizedBox(height: 20),
                  Textwidget(
                    text: "Title your review",
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                  const SizedBox(height: 10),
                  TextFieldDesignedOutline(

                    controller: controller.titleController,
                    hintText: "What’ most important to know?",
                    keyboardType: TextInputType.text,
                    maxLength: 60,
                  ),
                  const SizedBox(height: 20),
                  Textwidget(
                    text: "Write your review",
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                  const SizedBox(height: 10),
                  TextFieldDesignedOutline(
                    controller: controller.reviewController,
                    maxLines: 3,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: SizedBox(
                        width: 10,
                        height: 60,
                        child: Image.asset(
                          "assets/icons/describeicon.png",
                          scale: 3.5,
                        ),
                      ),
                    ),
                    hintText: "Comment your experience with Cleaner/Co-host",
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20),
                  MyButton(
                    onPressed: () {
                      controller.reviewApi();
                    },
                    text: "Submit Review",
                    color: AppStyles.appThemeColor, TextColor: AppStyles.backgroundColor,
                  ),
                ],
              ),
            ),
          ),
          ShowLoader.isLoadingProgress(controller.isLoading.value)
        ],
      ),)
    );
  }
}
