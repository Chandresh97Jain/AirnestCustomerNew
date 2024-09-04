import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/app/modules/ChatBodScreen/controllers/chat_bod_screen_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';

class ChatBodScreenView extends GetView<ChatBodScreenController> {
  const ChatBodScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyles.appThemeColor,
        appBar: AppBar(
          titleSpacing: 5,
          toolbarHeight: 70,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: AppStyles.appThemeColor,
          title: AppbarWithBackButton(
            titleColor: AppStyles.backgroundColor,
            text: 'Chat Bot',
            onPressed: () {
              Get.back();
            },
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 7,
              ),
              Center(
                  child: Textwidget(
                maxLines: 5,
                textAlign: TextAlign.center,
                text: "Hello\nI’m Chatty",
                fontWeight: FontWeight.w700,
                fontSize: 25,
                color: AppStyles.backgroundColor,
              )),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              Image.asset(
                "assets/icons/chatbot1.png",
                height: MediaQuery.of(context).size.height / 8,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              Center(
                  child: Textwidget(
                maxLines: 5,
                textAlign: TextAlign.center,
                text: "How can I help\nyou?",
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: AppStyles.backgroundColor,
              )),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 5,
                    right: MediaQuery.of(context).size.width / 5,
                    bottom: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    Get.toNamed(Routes.CHAT_BOD_VERIFY);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppStyles.backgroundColor),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Center(
                          child: Textwidget(
                        text: "I want to know",
                        fontSize: 16,
                        color: AppStyles.appThemeColor,
                        fontWeight: FontWeight.w700,
                      )),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
