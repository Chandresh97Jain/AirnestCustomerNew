import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/app/modules/FilterScreen/controllers/filter_screen_controller.dart';
import 'package:power_maids/app/modules/FilterScreen/views/reusablelist_sort_and_gender.dart';
import 'package:range_slider_flutter/range_slider_flutter.dart';

class FilterScreenView extends GetView<FilterScreenController> {
  const FilterScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        titleSpacing: 5,
        toolbarHeight: 70,
        surfaceTintColor: AppStyles.backgroundColor,
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: AppStyles.backgroundColor,
        title: AppbarWithBackButton(
          text: 'Filter',
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Textwidget(
                text: "Availability",
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Textwidget(
                    text: "Available Today",
                  ),
                  Obx(() => Switch(
                      activeColor: AppStyles.appThemeColor,
                      value: controller.isSwitched.value,
                      onChanged: (value) {
                        controller.toggleSwitch();
                      }))
                ],
              ),
              Textwidget(
                text: "Sort Options",
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.sortOPtion.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (buildContext, index) {
                    return Obx(() => SortOptionAndGender(
                          text: controller.sortOPtion[index],
                          iconImage: controller.sortoptionselected.value ==
                                  controller.sortOPtion[index]
                              ? 'assets/icons/circulfilledicon.png'
                              : 'assets/icons/ciruleicon.png',
                          onPressed: () {
                            controller.sortoptionselected.value =
                                controller.sortOPtion[index];
                          },
                        ));
                  }),
              const SizedBox(
                height: 15,
              ),
              Textwidget(
                text: "Gender",
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.genderList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (buildContext, index) {
                    return Obx(() => SortOptionAndGender(
                          text: controller.genderList[index],
                          iconImage: controller.genderselected.value ==
                                  controller.genderList[index]
                              ? 'assets/icons/circulfilledicon.png'
                              : 'assets/icons/ciruleicon.png',
                          onPressed: () {
                            controller.genderselected.value =
                                controller.genderList[index];
                          },
                        ));
                  }),
              const SizedBox(
                height: 15,
              ),
              Textwidget(
                text: "Work Experience (years)",
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
              const SizedBox(
                height: 10,
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: 5,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: (const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3,
                  crossAxisCount: 3,
                )),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      onTap: () {
                        controller.workExperienceselected.value =
                            controller.workExperience[index];
                      },
                      child: Obx(
                        () => Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color:
                                      controller.workExperienceselected.value ==
                                              controller.workExperience[index]
                                          ? AppStyles.appThemeColor
                                          : AppStyles.GrayTextColor)),
                          child: Center(
                            child: Textwidget(
                              text: controller.workExperience[index],
                              fontSize: 12.5,
                              color: controller.workExperienceselected.value ==
                                      controller.workExperience[index]
                                  ? AppStyles.appThemeColor
                                  : AppStyles.BlackColor,
                            ),
                          ),
                        ),
                      ));
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Textwidget(
                text: "Price Range",
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
              RangeSliderFlutter(
                // key: Key('3343'),
                values: [
                  controller.lowerValue.value.toDouble(),
                  controller.upperValue.value.toDouble()
                ],
                rangeSlider: true,
                tooltip: RangeSliderFlutterTooltip(
                  alwaysShowTooltip: true,
                ),
                max: 20000,
                textPositionBottom: -125,
                handlerHeight: 25,
                trackBar: RangeSliderFlutterTrackBar(
                  activeTrackBarHeight: 3,
                  inactiveTrackBarHeight: 3,
                  activeTrackBar: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppStyles.appThemeColor,
                  ),
                  inactiveTrackBar: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                ),

                min: 0,
                fontSize: 15,
                textBackgroundColor: AppStyles.appThemeColor,
                onDragging: (handlerIndex, lowerValue, upperValue) {
                  controller.lowerValue.value = lowerValue;
                  controller.upperValue.value = upperValue;
                },
              ),
              const SizedBox(
                height: 35,
              ),
              Textwidget(
                text: "Star Rating",
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(50)),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.starRating.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (buildContext, index) {
                      return InkWell(
                        onTap: () {
                          controller.starRatingselected.value =
                              controller.starRating[index];
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 14),
                              child: Textwidget(
                                text: controller.starRating[index],
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              Icons.star,
                              size: 18,
                              color: AppStyles.StarIconColor,
                            ),
                            index < controller.starRating.length - 1
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width /
                                                40),
                                    child: const VerticalDivider(),
                                  )
                                : const SizedBox()
                          ],
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
        child: MyButton(
          text: 'Apply Filters',
          onPressed: () {
            Get.back();
          },
          color: AppStyles.appThemeColor,
          TextColor: AppStyles.backgroundColor,
        ),
      ),
    );
  }
}
