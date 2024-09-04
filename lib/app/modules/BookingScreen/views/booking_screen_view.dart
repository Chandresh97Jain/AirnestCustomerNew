import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/app/modules/BookingScreen/controllers/booking_screen_controller.dart';
import 'package:power_maids/app/modules/BookingScreen/dynamic_list.dart';

class BookingScreenView extends GetView<BookingScreenController> {
  const BookingScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            surfaceTintColor: AppStyles.backgroundColor,
            automaticallyImplyLeading: false,
            elevation: 1,
            backgroundColor: AppStyles.backgroundColor,
            title: Textwidget(
              text: "My Booking",
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            centerTitle: false,
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: AppStyles.appThemeColor,
              labelColor: AppStyles.appThemeColor,

              onTap: (v){

                controller.bookingRequestListApi();
                controller.bookingHistoryListApi();

              },

              tabs: const [
                Tab(text: "Booking Request"),
                Tab(text: "Booking History"),



              ],
              labelStyle: const TextStyle(
                  fontFamily: "JosefinSans",
                  fontWeight: FontWeight.w700,
                  fontSize: 15),
            ),
          ),
          body: Obx(() => Stack(
            children: [
              controller.isLoading.isTrue
                  ?ShowLoader.isLoadingProgress(controller.isLoading.value)
                  :Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TabBarView(
                  children: [
                    ///Booking Request
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          BookingRequestListView(requestList: controller.bookingRequestList,)
                        ],
                      ),
                    ),

                    ///Booking Preview
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          BookingPreview(
                            hestoryList: controller.bookingHistoryList,

                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ))
      ),
    );
  }
}
