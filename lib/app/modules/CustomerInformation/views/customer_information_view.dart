import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/textformfield_ui_global.dart';
import 'package:power_maids/app/modules/CustomerInformation/controllers/customer_information_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';



class CustomerInformationView extends GetView<CustomerInformationController> {
  const CustomerInformationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 15,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: AppStyles.backgroundColor,
        title: AppbarWithBackButton(
          text: 'Customer Info',
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Textwidget(
                text: "Your Detail",
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
              const SizedBox(
                height: 12,
              ),
              TextFieldDesignedOutline(
                prefixIcon: SizedBox(
                  width: 10,
                  height: 60,
                  child: Image.asset(
                    "assets/icons/fn.png",
                    scale: 3.5,
                  ),
                ),
                hintText: "Full Name",
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 12,
              ),
              TextFieldDesignedOutline(
                prefixIcon: SizedBox(
                  width: 10,
                  height: 60,
                  child: Image.asset(
                    "assets/icons/Icon-Set.png",
                    scale: 3.5,
                  ),
                ),
                hintText: "Email",
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 12,
              ),
              TextFieldDesignedOutline(
                prefixIcon: SizedBox(
                  width: 10,
                  height: 60,
                  child: Image.asset(
                    "assets/icons/phoneIcon.png",
                    scale: 3.5,
                  ),
                ),
                hintText: "Phone",
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 12,
              ),
              TextFieldDesignedOutline(
                prefixIcon: SizedBox(
                  width: 10,
                  height: 60,
                  child: Image.asset(
                    "assets/icons/addressIcon.png",
                    scale: 3.5,
                  ),
                ),
                hintText: "Address",
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 12,
              ),
              TextFieldDesignedOutline(
                prefixIcon: SizedBox(
                  width: 10,
                  height: 60,
                  child: Image.asset(
                    "assets/icons/aptIcon.png",
                    scale: 3.5,
                  ),
                ),
                hintText: "Apt/Suite #",
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Flexible(
                    child: TextFieldDesignedOutline(
                      prefixIcon: SizedBox(
                        width: 10,
                        height: 60,
                        child: Image.asset(
                          "assets/icons/cityIcon.png",
                          scale: 3.5,
                        ),
                      ),
                      hintText: "City",
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: TextFieldDesignedOutline(
                      prefixIcon: SizedBox(
                        width: 10,
                        height: 60,
                        child: Image.asset(
                          "assets/icons/stateicon.png",
                          scale: 3.5,
                        ),
                      ),
                      hintText: "State",
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Flexible(
                    child: TextFieldDesignedOutline(
                      prefixIcon: SizedBox(
                        width: 10,
                        height: 60,
                        child: Image.asset(
                          "assets/icons/countryicon.png",
                          scale: 3.5,
                        ),
                      ),
                      hintText: "Country",
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: TextFieldDesignedOutline(
                      prefixIcon: SizedBox(
                        width: 10,
                        height: 60,
                        child: Image.asset(
                          "assets/icons/addressIcon.png",
                          scale: 3.5,
                        ),
                      ),
                      hintText: "ZipCode",
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              TextFieldDesignedOutline(
                maxLines: 4,
                prefixIcon: SizedBox(
                  width: 10,
                  child: Image.asset(
                    "assets/icons/describeicon.png",
                    scale: 3.5,
                  ),
                ),
                hintText: "Describe Your Task",
                keyboardType: TextInputType.text,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 8, top: 8),
        child: MyButton(
            onPressed: () {
              Get.toNamed(Routes.REVIEW_BOOKING_DETAIL);
            },
            text: "Proceed To Checkout", color: AppStyles.appThemeColor, TextColor: AppStyles.backgroundColor,),
      ),
    );
  }
}
