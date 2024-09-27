import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/textformfield_ui_global.dart';
import 'package:power_maids/app/modules/ChatBodVerify/controllers/chat_bod_verify_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';


class ChatBodVerifyView extends GetView<ChatBodVerifyController> {
  const ChatBodVerifyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        titleSpacing: 5,
        //toolbarHeight: 70,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppStyles.backgroundColor,
        title: AppbarWithBackButton(
          text: 'Chat Bot Verification ',
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/chatbot1.png',
                  scale: 5,
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                    child: Textwidget(
                  maxLines: 5,
                  textAlign: TextAlign.center,
                  text: "Hello I’m Chatty",
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                )),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 18,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Textwidget(
                    maxLines: 5,
                    textAlign: TextAlign.center,
                    text: "Authentocation Verification",
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                  ),
                  Textwidget(
                    textAlign: TextAlign.center,
                    maxLines: 50,
                    text:
                        "Enter your email address, we will send a verification code to your email",
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: AppStyles.BlacklightTextcolor,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppStyles.backgroundColor),
                child: Padding(
                  padding: const
                  EdgeInsets.symmetric(horizontal: 12, vertical: 30),
                  child: Column(
                    children: [
                      TextFieldDesigned(
                        prefixIcon: Image.asset(
                          "assets/icons/phoneIcon.png",
                          scale: 3.5,
                        ),
                        hintText: "Email",
                        keyboardType: TextInputType.phone,
                      ),
                      const
                      SizedBox(
                        height: 20,
                      ),
                      MyButton(
                        onPressed: () {
                          Get.toNamed(Routes.CHATBOOTVERIFY_OTP);
                        },
                        text: "Send OTP",
                        color: AppStyles.appThemeColor,
                        TextColor: AppStyles.backgroundColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
