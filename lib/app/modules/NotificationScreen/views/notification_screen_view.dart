import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/app/modules/NotificationScreen/controllers/notification_screen_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationScreenView extends GetView<NotificationScreenController> {
  const NotificationScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: AppStyles.backgroundColor,
          automaticallyImplyLeading: false,
          elevation: 1,
          backgroundColor: AppStyles.backgroundColor,
          title: Textwidget(
            text: "Notification",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          centerTitle: false,
        ),
        body: SmartRefresher(
          enablePullDown: true,
          footer: WaterDropMaterialHeader(
              backgroundColor: AppStyles.appThemeColor,
              color: AppStyles.backgroundColor),
          header: WaterDropMaterialHeader(
              backgroundColor: AppStyles.appThemeColor,
              color: AppStyles
                  .backgroundColor), // Customize the refresh indicator (you can use other built-in or custom indicators)
          controller: controller.refreshController,
          enablePullUp: true,
          onRefresh: () {
            controller.reFreshApis();

            if (true) controller.refreshController.refreshCompleted();
          },

          child: Obx(() => controller.isLoadingNotification.isFalse &&
                  controller.isReadNotification.isFalse
              ? controller.getNotificationList.isNotEmpty
                  ? SingleChildScrollView(
                    child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Textwidget(
                                    text:
                                        "You have ${controller.getNotificationList.length} notification",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                // Flexible(
                                //   child: IconButton(
                                //     onPressed: () {
                                //       controller.allNotificationGet();
                                //     },
                                //     icon: Textwidget(
                                //       text: "Mark all as read",
                                //       fontSize: 12,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.getNotificationList.length,
                                    itemBuilder: (buildContext, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 5,
                                            bottom: 5),
                                        child: Column(
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                final notificationId = controller
                                                    .getNotificationList[index].id
                                                    .toString();
                                                final bidDetailsId = controller
                                                    .getNotificationList[index]
                                                    .notification_id
                                                    .toString();
                                                log(bidDetailsId);
                    
                                                //  await controller.readNotification(notificationId: notificationId,BidDetailsId: BidDetailsId);
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: Row(
                                                      children: [
                                                        Card(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                          margin: EdgeInsets.zero,
                                                          child: Container(
                                                            height: 70,
                                                            width: 70,
                                                            decoration:
                                                                const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              child: CachedNetworkImage(
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      const Icon(Icons
                                                                          .person_outline_outlined),
                                                                  fit:
                                                                      BoxFit.fill,
                                                                  imageUrl: ApiService
                                                                          .imageURL +
                                                                      controller
                                                                          .getNotificationList[
                                                                              index]
                                                                          .sender_img
                                                                          .toString()),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 15,
                                                        ),
                                                        Flexible(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Textwidget(
                                                                maxLines: 10,
                                                                text: controller
                                                                    .getNotificationList[
                                                                        index]
                                                                    .title,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 15,
                                                              ),
                                                              Textwidget(
                                                                maxLines: 10,
                                                                text: controller
                                                                    .getNotificationList[
                                                                        index]
                                                                    .message,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontSize: 12,
                                                              ),
                                                              Textwidget(
                                                                text: controller
                                                                    .getNotificationList[
                                                                        index]
                                                                    .date_time,
                                                                fontSize: 11,
                                                                color: AppStyles
                                                                    .unSelectedTabTextColor,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  controller
                                                              .getNotificationList[
                                                                  index]
                                                              .is_read
                                                              .toString() ==
                                                          "0"
                                                      ? Icon(
                                                          Icons.circle,
                                                          size: 10,
                                                          color: AppStyles
                                                              .appThemeColor,
                                                        )
                                                      : const SizedBox()
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Divider(
                                              thickness: 1,
                                              height: 0,
                                              color: AppStyles.deviderColor,
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
                  )
                  : Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/hand-wash-svgrepo-com 1.png",
                          scale: 5,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Textwidget(
                          textAlign: TextAlign.center,
                          maxLines: 5,
                          text: "You don’t have\nany notification",
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        )
                      ],
                    ))
              : ShowLoader.isLoadingProgress(true)),
        ));
  }
}
