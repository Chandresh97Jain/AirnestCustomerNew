import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/app/modules/CleanerAndCo_hostList/controllers/cleaner_co_hostlist_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';


class CleanerAndCoHostListView extends GetView<CleanerAndCoHostListController> {
  const CleanerAndCoHostListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyles.backgroundColor,
        appBar: AppBar(
          surfaceTintColor: AppStyles.backgroundColor,
          titleSpacing: 5,
          toolbarHeight: 70,
          
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: AppStyles.backgroundColor,
          title: Obx(()=> AppbarWithBackButton(
            text: controller.id.value=="0"? "Cleaner List":"Co-Host List",
            onPressed: () {
              Get.back();
            },
          )
          ),
          centerTitle: false,
        ),
        body: Obx(() => Column(
          children: [
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
                  Textwidget(
                    text: controller.zipCode.value,
                    fontSize: 18,
                  ),
                ],
              ),
            ),
            controller.isLoading.isTrue
            ?SizedBox(
              height: MediaQuery.of(context).size.height/2,
              child: Center(
                child: ShowLoader.isLoadingProgress(controller.isLoading.value),
              ),
            )
            :controller.cleanercohostList.isEmpty
            ?SizedBox(
              height: MediaQuery.of(context).size.height/2,
              child: Center(
                child: Textwidget(
                  text: "No Data Found",
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            )
            :Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.cleanercohostList.length,
                  itemBuilder: (buildContext, index) {
                    var list = controller.cleanercohostList[index];

                    log("image =-=-=-= ${ApiService.imageURL+list.avatar}");
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          var data = {
                            "id": controller.id.toString(),
                            "title": controller.title.toString(),
                            "cleaner_cohost_id": list.id.toString(),
                            "user_type": controller.userType.toString(),
                            "service_id": controller.serviceId.toString(),
                            "service_name": controller.serviceName.toString(),
                            "zip_code": controller.zipCode.toString(),
                          };
                          Get.toNamed(Routes.MAID_DETAILS, parameters: data,arguments: true);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          margin: EdgeInsets.zero,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppStyles.backgroundColor),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, top: 5, bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 90,
                                          width: 90,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            child: Image.network(
                                              ApiService.imageURL+list.avatar,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),

                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Textwidget(
                                                text: list.firstname+" "+list.lastname,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                              ),
                                              // Textwidget(
                                              //   text: "\$${list.hourlyRate} for cleaning",
                                              //   color: AppStyles.GraylightTextColor,
                                              // ),
                                              Row(
                                                children: [
                                                  RatingBar.builder(
                                                    ignoreGestures: true,
                                                    itemSize: 17,
                                                    initialRating: double.parse(list.rating.toString()),
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 0.0,
                                                        vertical: 0.0),
                                                    itemBuilder: (context, _) =>
                                                        Icon(
                                                          Icons.star,
                                                          color:
                                                          AppStyles.StarIconColor,
                                                        ),
                                                    onRatingUpdate: (rating) {},
                                                  ),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  Flexible(
                                                    child: Textwidget(
                                                      text: "${list.rating} ( ${list.review} Review )",
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              // Textwidget(
                                              //   text: "Repeat Client: ${list.repeatClient}",
                                              //   fontSize: 12,
                                              // ),
                                             ],
                                          ),
                                        )
                                      ],
                                    ),
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
            ),
          ],
        ))
    );
  }
}
