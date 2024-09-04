import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/app/modules/TermsAndConditions/controllers/terms_and_conditions_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndConditionsView extends GetView<TermsAndConditionsController> {
  const TermsAndConditionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppStyles.backgroundColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: AppStyles.appThemeColor,
        title: Textwidget(
          text: "Terms & Conditions",
          color: AppStyles.backgroundColor,
          fontSize: 18,
        ),
      ),
      body: Obx(
            () => controller.isLoadingTermsConditions.isFalse
            ? SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Html(
                  data: controller.content.value,
                  style: {
                    "body": Style(
                      fontFamily: "JosefinSans",
                    ),
                  },
                  onLinkTap: (url, attributes, element) {
                    _handleLinkTap(url);
                  },
                ),
              ],
            ),
          ),
        )
            :       ShowLoader.isLoadingProgress(controller.isLoadingTermsConditions.value),

      ),
    );
  }

  void _handleLinkTap(String? url) async {
    if (url != null) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        // Handle the situation when the URL can't be opened
        Get.snackbar("Error", "Cannot open the link");
      }
    }
  }
}
