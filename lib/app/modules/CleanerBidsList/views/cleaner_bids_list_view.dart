import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/app/modules/CleanerBidsList/bid_dynamic_list.dart';
import 'package:power_maids/app/modules/CleanerBidsList/controllers/cleaner_bids_list_controller.dart';


class CleanerBidsListView extends GetView<CleanerBidsListController> {
  const CleanerBidsListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: AppStyles.backgroundColor,
          appBar: AppBar(
            titleSpacing: 5,
            toolbarHeight: 70,
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: AppStyles.backgroundColor,
            title: AppbarWithBackButton(
              text: 'My Bids',
              onPressed: () {
                Get.back();
              },
            ),
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: AppStyles.appThemeColor,
              labelColor: AppStyles.appThemeColor,
              tabs: const [
                Tab(text: "For Cleaner"),
                Tab(text: "For Co-host"),
              ],
              labelStyle: const TextStyle(
                  fontFamily: "JosefinSans",
                  fontWeight: FontWeight.w700,
                  fontSize: 15),
            ),
            centerTitle: false,
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
                    Column(
                      children: [
                        BidListCleaner(clenerbidlist: controller.cleanerBidList)
                      ],
                    ),

                    ///Booking Preview
                    Column(
                      children: [
                        BidListCoHost(cohostbidlist: controller.coHostBidList,)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
          )
      ),
    );
  }
}
