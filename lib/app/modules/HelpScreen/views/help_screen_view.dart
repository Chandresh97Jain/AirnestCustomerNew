import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/app/modules/HelpScreen/controllers/help_screen_controller.dart';

class HelpScreenView extends GetView<HelpScreenController> {
  const HelpScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     backgroundColor: AppStyles.backgroundColor,
    //     appBar: AppBar(
    //       surfaceTintColor: AppStyles.backgroundColor,
    //       titleSpacing: 5,
    //       toolbarHeight: 70,
    //       automaticallyImplyLeading: false,
    //       elevation: 0,
    //       backgroundColor: AppStyles.backgroundColor,
    //       title: AppbarWithBackButton(
    //         text: "Help Center",
    //         onPressed: () {
    //           Get.back();
    //         },
    //       ),
    //       centerTitle: false,
    //     ),
    //     body: Padding(
    //       padding: const EdgeInsets.only(left: 13, right: 13),
    //       child: Column(
    //         children: [
    //           Expanded(
    //             child: SingleChildScrollView(
    //               child: Column(
    //                 children: [
    //                   Padding(
    //                     padding: const EdgeInsets.only(top: 10, bottom: 10),
    //                     child: Stack(
    //                       children: [
    //                         Column(
    //                           children: [
    //                             const SizedBox(
    //                               height: 10,
    //                             ),
    //                             Container(
    //                               decoration: BoxDecoration(
    //                                   borderRadius: BorderRadius.circular(6),
    //                                   border: Border.all()),
    //                               child: ListView.builder(
    //                                   itemCount:
    //                                       controller.helpCenter["disc"]!.length,
    //                                   shrinkWrap: true,
    //                                   physics:
    //                                       const NeverScrollableScrollPhysics(),
    //                                   itemBuilder: (buildContext, indextitle) {
    //                                     return Column(
    //                                       children: [
    //                                         ExpansionTile(
    //                                           tilePadding:
    //                                               const EdgeInsets.only(
    //                                                   left: 10, right: 10),
    //                                           title: Textwidget(
    //                                             fontSize: 12,
    //                                             fontWeight: FontWeight.w700,
    //                                             text: controller.helpCenter[
    //                                                 "disc"]![indextitle],
    //                                           ),
    //                                           children: [
    //                                             Padding(
    //                                               padding: const EdgeInsets
    //                                                   .symmetric(
    //                                                   horizontal: 10,
    //                                                   vertical: 8),
    //                                               child: Column(
    //                                                 children: [
    //                                                   Textwidget(
    //                                                     maxLines: 100,
    //                                                     text:
    //                                                         "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.",
    //                                                   )
    //                                                 ],
    //                                               ),
    //                                             )
    //                                           ],
    //                                         ),
    //                                       ],
    //                                     );
    //                                   }),
    //                             ),
    //                           ],
    //                         ),
    //                         Padding(
    //                           padding: const EdgeInsets.only(left: 20),
    //                           child: Container(
    //                               color: Colors.white,
    //                               child: Padding(
    //                                 padding: const EdgeInsets.symmetric(
    //                                     horizontal: 8),
    //                                 child: Textwidget(
    //                                   text: "Authentication",
    //                                 ),
    //                               )),
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.only(top: 10, bottom: 10),
    //                     child: Stack(
    //                       children: [
    //                         Column(
    //                           children: [
    //                             const SizedBox(
    //                               height: 10,
    //                             ),
    //                             Container(
    //                               decoration: BoxDecoration(
    //                                   borderRadius: BorderRadius.circular(6),
    //                                   border: Border.all()),
    //                               child: ListView.builder(
    //                                   itemCount: controller
    //                                       .helpCenterOtherQueries["disc"]!
    //                                       .length,
    //                                   shrinkWrap: true,
    //                                   physics:
    //                                       const NeverScrollableScrollPhysics(),
    //                                   itemBuilder: (buildContext, indextitle) {
    //                                     return Column(
    //                                       children: [
    //                                         ExpansionTile(
    //                                           tilePadding:
    //                                               const EdgeInsets.only(
    //                                                   left: 10, right: 10),
    //                                           title: Textwidget(
    //                                             fontSize: 12,
    //                                             fontWeight: FontWeight.w700,
    //                                             text: controller
    //                                                     .helpCenterOtherQueries[
    //                                                 "disc"]![indextitle],
    //                                           ),
    //                                           children: [
    //                                             Padding(
    //                                               padding: const EdgeInsets
    //                                                   .symmetric(
    //                                                   horizontal: 10,
    //                                                   vertical: 8),
    //                                               child: Column(
    //                                                 children: [
    //                                                   Textwidget(
    //                                                     maxLines: 100,
    //                                                     text:
    //                                                         "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.",
    //                                                   )
    //                                                 ],
    //                                               ),
    //                                             )
    //                                           ],
    //                                         ),
    //                                       ],
    //                                     );
    //                                   }),
    //                             ),
    //                           ],
    //                         ),
    //                         Padding(
    //                           padding: const EdgeInsets.only(left: 20),
    //                           child: Container(
    //                               color: Colors.white,
    //                               child: Padding(
    //                                 padding: const EdgeInsets.symmetric(
    //                                     horizontal: 8),
    //                                 child: Textwidget(
    //                                   text: "Other queries",
    //                                 ),
    //                               )),
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                   TextButton(
    //                       onPressed: () {},
    //                       child: Textwidget(
    //                         text: "Having more queries?",
    //                         color: AppStyles.BlackColor,
    //                       )),
    //                   MyButtonwithIcon(
    //                     iconcolor: AppStyles.backgroundColor,
    //                     iconImageSize: 20,
    //                     iconimage: "assets/icons/phoneIcon.png",
    //                     text: 'Contact with us',
    //                     onPressed: () {},
    //                     color: AppStyles.appThemeColor,
    //                     Textcolor: Colors.white,
    //                   ),
    //                   const SizedBox(
    //                     height: 10,
    //                   ),
    //                   Row(
    //                     children: [
    //                       Expanded(
    //                           child: Divider(
    //                         endIndent: 20,
    //                         color: AppStyles.GrayTextColor,
    //                         thickness: 1,
    //                       )),
    //                       Textwidget(
    //                         fontSize: 16,
    //                         text: "OR",
    //                         color: AppStyles.GrayTextColor,
    //                       ),
    //                       Expanded(
    //                           child: Divider(
    //                         indent: 20,
    //                         color: AppStyles.GrayTextColor,
    //                         thickness: 1,
    //                       ))
    //                     ],
    //                   ),
    //                   const SizedBox(
    //                     height: 10,
    //                   ),
    //                   MyButtonwithIcon(
    //                     iconcolor: AppStyles.backgroundColor,
    //                     iconImageSize: 20,
    //                     iconimage: "assets/icons/mail.png",
    //                     text: 'Mail Us',
    //                     onPressed: () {},
    //                     color: AppStyles.BlackColor,
    //                     Textcolor: Colors.white,
    //                   ),
    //                   const SizedBox(
    //                     height: 10,
    //                   )
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ));

    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: buildAppBar(),
      body: Obx(() => controller.isLoadingHelpAuth.isFalse
          ? Visibility(
              visible: controller.getHelpAuthList.isNotEmpty,
              child: Visibility(
                visible: controller.getHelpAuthList.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Html(
                                  data: controller.title.toString(),
                                  style: {
                                    "body": Style(
                                      fontFamily: "JosefinSans",
                                      fontSize:
                                          FontSize(20.0), // Change font size
                                      fontWeight:
                                          FontWeight.bold, // Make text bold
                                      // fontStyle: FontStyle.italic, // Italicize text
                                    )
                                  }),
                              Html(
                                  data: controller.content.toString(),
                                  style: {
                                    "body": Style(
                                      fontFamily: "JosefinSans",
                                      // fontSize: FontSize(15.0), // Change font size
                                      //   fontWeight: FontWeight.bold, // Make text bold
                                      // fontStyle: FontStyle.italic, // Italicize text
                                    )
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : ShowLoader.isLoadingProgress(controller.isLoadingHelpAuth.value)),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      surfaceTintColor: AppStyles.backgroundColor,
      titleSpacing: 5,
      toolbarHeight: 70,
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: AppStyles.backgroundColor,
      title: AppbarWithBackButton(
        text: "FAQ",
        onPressed: () {
          Get.back();
        },
      ),
      centerTitle: false,
    );
  }
}
