import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/app/modules/BookAppointment/controllers/book_appointment_controller.dart';
import 'package:power_maids/app/modules/BookAppointment/listviewui.dart';
import 'package:power_maids/app/routes/app_pages.dart';


class BookAppointmentView extends GetView<BookAppointmentController> {
  const BookAppointmentView({Key? key}) : super(key: key);
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
        title: AppbarWithBackButton(
          text: 'Book Appointment',
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Textwidget(
                    text: "Select Date",
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                  Obx(() => Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: DropdownButton<String>(
                            padding: EdgeInsets.zero,
                            value: controller.selectedValue.value,
                            icon: const Icon(Icons.keyboard_arrow_down_outlined),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(),
                            onChanged: (newValue) {
                              controller.selectedValue.value = newValue!;
                            },
                            items: controller.options
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                alignment: Alignment.center,
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(fontFamily: "JosefinSans"),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ))
                ],
              ),
             const SizedBox(
                height: 10,
              ),
              SelectDateListView(
                height: 100,
                date: controller.dateList,
                day: controller.dayList,
              ),
              const SizedBox(
                height: 10,
              ),
              Textwidget(
                text: "Select Time",
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
             const SizedBox(
                height: 10,
              ),
              SelectTimeGridView(
                time: controller.timeList,
              ),
              const SizedBox(
                height: 20,
              ),
              Textwidget(
                text: "Reminder",
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Textwidget(
                      text: "Select alert",
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  Obx(() => DropdownButton<String>(
                        padding: EdgeInsets.zero,
                        value: controller.selectedValueforAlert.value,
                        icon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                        ),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(),
                        onChanged: (newValue) {
                          controller.selectedValueforAlert.value = newValue!;
                        },
                        items: controller.optionsforalert
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              alignment: Alignment.center,
                              value: value,
                              child: Textwidget(
                                text: value,
                                color: AppStyles.Blacklightbuttoncolor,
                              ));
                        }).toList(),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 8, top: 8),
        child: MyButton(
          onPressed: () {
            Get.toNamed(Routes.BOOKING_SUMMARY);
          },
          text: "Next",
          color: AppStyles.appThemeColor,
          TextColor: AppStyles.backgroundColor,
        ),
      ),
    );
  }
}
