import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/color_style.dart';

import 'controllers/book_appointment_controller.dart';

class SelectDateListView extends StatelessWidget {
  final List date;
  final List day;
  final double height;

  const  SelectDateListView({
    required this.height,
    required this.date,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(BookAppointmentController());
    final controller = BookAppointmentController();
    return SizedBox(
      height: height,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.dateList.length,
          shrinkWrap: true,
          itemBuilder: (buildContext, index) {
            return InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  controller.selectedDate.value = controller.dateList[index];
                },
                child: Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, bottom: 5, top: 5),
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: controller.selectedDate.value ==
                              controller.dateList[index]
                          ? AppStyles.appThemeColor
                          : AppStyles.backgroundColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: SizedBox(
                        width: 75,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              day[index],
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: "JosefinSans",
                                color: controller.selectedDate.value ==
                                        controller.dateList[index]
                                    ? AppStyles.backgroundColor
                                    : AppStyles.BlackColor,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                            Text(date[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "JosefinSans",
                                  color: controller.selectedDate.value ==
                                          controller.dateList[index]
                                      ? AppStyles.backgroundColor
                                      : AppStyles.BlackColor,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
          }),
    );
  }
}

class SelectTimeGridView extends StatelessWidget {
  final List time;

  SelectTimeGridView({
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(BookAppointmentController());
    final controller = BookAppointmentController();
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.timeList.length,
        gridDelegate: (const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1.5,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10)),
        itemBuilder: (buildContext, index) {
          return InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                controller.selectetime.value = controller.timeList[index];
              },
              child: Obx(
                () => Card(
                  color:
                      controller.selectetime.value == controller.timeList[index]
                          ? AppStyles.appThemeColor
                          : AppStyles.backgroundColor,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  child: Center(
                    child: Text(
                      time[index],
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: "JosefinSans",
                        color: controller.selectetime.value ==
                                controller.timeList[index]
                            ? AppStyles.backgroundColor
                            : AppStyles.BlackColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ));
        });
  }
}
