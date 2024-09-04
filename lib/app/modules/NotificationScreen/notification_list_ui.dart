import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/app/routes/app_pages.dart';
import 'controllers/notification_screen_controller.dart';

class NotificationListUI extends StatelessWidget {
  final List imagesList;
  final List nameList;
  final List titleList;
  final List dateList;
  final List timeList;

  const NotificationListUI(
      {required this.imagesList,
      required this.nameList,
      required this.titleList,
      required this.dateList,
      required this.timeList});

  @override
  Widget build(BuildContext context) {
    Get.put(NotificationScreenController());
    final controller = NotificationScreenController();

    return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.imagesList.length,
        itemBuilder: (buildContext, index) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.NOTIFICATION_DETAILS);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          
                          children: [
                            Container(
                              height: 70,
                              decoration: const BoxDecoration(shape: BoxShape.circle),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  imagesList[index],
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Textwidget(
                                    maxLines: 10,

                                    text: nameList[index],
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                  Textwidget(
                                    maxLines: 10,
                                    text: titleList[index],
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Textwidget(
                                          text: dateList[index],
                                          fontSize: 11,
                                          color: AppStyles.GrayTextColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Image.asset(
                                        "assets/icons/timeIcon.png",
                                        height: 11,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Flexible(
                                        child: Textwidget(
                                          
                                          text: timeList[index],
                                          fontSize: 11,
                                          color: AppStyles.GrayTextColor,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.circle,
                        size: 10,
                        color: AppStyles.appThemeColor,
                      )
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
        });
  }
}
