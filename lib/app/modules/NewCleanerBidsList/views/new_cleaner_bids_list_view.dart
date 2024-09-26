import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/cached_netword_image.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/Utils/nodata_image.dart';
import 'package:power_maids/app/modules/NewCleanerBidsList/controllers/new_cleaner_bids_list_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';


class NewCleanerBidsListView extends GetView<NewCleanerBidsListController> {
  const NewCleanerBidsListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyles.backgroundColor,
        appBar: AppBar(
          titleSpacing: 5,
          toolbarHeight: 70,
          automaticallyImplyLeading: false,
          elevation: 0,
          surfaceTintColor: AppStyles.backgroundColor,
          backgroundColor: AppStyles.backgroundColor,
          title: AppbarWithBackButton(
            text: 'Bids List',
            onPressed: () {
              Get.back();
            },
          ),
          centerTitle: false,
        ),
        body: Obx(() => Stack(
          children: [
            controller.isLoading.isTrue
            ?ShowLoader.isLoadingProgress(controller.isLoading.value)
            :SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: Textwidget(
                      text: "You have ${controller.cleanerList.length} bids",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 2, top: 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/icons/IconforHome.png",
                          height: 25,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Textwidget(
                            maxLines: 3,

                            text: controller.address.value,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  controller.cleanerList.isEmpty
                  ?NoDataFound(height: MediaQuery.of(context).size.height/2)
                  :ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.cleanerList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (buildContext, index) {
                        var list = controller.cleanerList[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 5, bottom: 5),
                          child: InkWell(
                            onTap: () {

                              var data = {
                                'bid_id' : controller.bidId.value,
                                'cleaner_id' : list.cleanerId.toString(),
                                "cleaner_name" : list.cleanerName,
                                "cleaner_image" : list.avatar,
                                "price" : list.price.toString(),
                                "address" : controller.address.value,
                                "ratting" : list.rating.toString(),
                                "review" : list.review.toString(),
                                "remote_firebase_id" : list.firebaseId.toString(),
                                "remote_user_id" : list.cleanerId.toString(),
                                "other_user_name" : list.cleanerName.toString(),
                                "service_id" : list.serviceId.toString(),
                                "service_name" : list.serviceName.toString(),
                                "user_type" : list.cleanerRole.toString(),
                                "zip_code" : list.propertyZipcode.toString(),
                                "property_id" : list.propertyId.toString(),
                                "about" : list.about.toString(),
                                "location" : list.address2.toString(),
                                "air_work" : list.airnestsWorks.toString(),
                                "platform_fee" : list.platformFee.toString(),
                                "bid_date" : list.bidDate.toString(),
                                "bid_time" : list.bidTime.toString(),
                              };

                              Get.toNamed(Routes.BIDER_DETAIL_SCREEN,parameters: data);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.zero,
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: AppStyles.backgroundColor),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 5, top: 5, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 80,
                                            width: 85,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: ProfileImage(image: list.avatar, fit: BoxFit.fill),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Textwidget(
                                                text: list.cleanerName,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                              ),
                                              Textwidget(
                                                text: "\$${list.price} for cleaning",
                                                color: AppStyles.GraylightTextColor,
                                              ),
                                              Row(
                                                children: [
                                                  RatingBar.builder(
                                                    ignoreGestures: true,
                                                    itemSize: 17,
                                                    initialRating:list.rating == "" ?0.0:double.parse(list.rating),
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemPadding: const EdgeInsets.symmetric(
                                                        horizontal: 0.0, vertical: 0.0),
                                                    itemBuilder: (context, _) => Icon(
                                                      Icons.star,
                                                      color: AppStyles.StarIconColor,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  Textwidget(
                                                    text: "( ${list.review} Review )",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  )
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 20,
                                        color: AppStyles.UnselectedTabColor,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                  controller.cleanerList.isEmpty
                      ? const SizedBox()
                  :Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                            child: Textwidget(
                              maxLines: 50,
                              textAlign: TextAlign.center,
                              text: "Don’t see a bid anymore?",
                              fontSize: 16,
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                            child: Textwidget(
                              textAlign: TextAlign.center,
                              maxLines: 50,
                              text:
                              "Bids expire after 48 hours. if you need help.please contact customer support.",
                              color: AppStyles.GraylightTextColor,
                              fontSize: 12,
                            )),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ],
        ))
    );
  }
}
