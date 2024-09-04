import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/cached_netword_image.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/app/modules/MaidDetails/controllers/maid_details_controller.dart';
import 'package:power_maids/app/modules/MaidDetails/model/details_model.dart';
import 'package:power_maids/app/modules/PhotoViewMaidDetails/views/photo_view_maid_details_view.dart';

class AboutScreen extends StatelessWidget {
  final String about; // Make sure `about` is declared as `final`
  final String business; // Make sure `about` is declared as `final`
  final String website; // Make sure `about` is declared as `final`
  List<PhotoListModel> photoList;

  AboutScreen(
      {super.key,
      required this.about,
      required this.business,
      required this.website,
      required this.photoList});

  final photoString = [];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MaidDetailsController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        about.isEmpty
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                child: Textwidget(
                  text: "About",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
        about.isEmpty
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Textwidget(
                    color: AppStyles.BlacklightTextcolor,
                    fontSize: 12,
                    maxLines: 100,
                    text: about),
              ),
        Visibility(
          visible: controller.serviceNameArray.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Textwidget(
              text: "Categories",
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
            child: Textwidget(
              color: AppStyles.BlacklightTextcolor,
              fontSize: 12,
              maxLines: 100,
              text: controller.serviceNameArray.join(', '),
            )),
        // Padding(
        //   padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
        //   child: Textwidget(
        //     text: "Working Hours",
        //     fontSize: 14,
        //     fontWeight: FontWeight.w700,
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
        //   child: Column(
        //     children: [
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Flexible(
        //             child: Textwidget(
        //               text: "Monday - Friday",
        //               fontSize: 12,
        //               color: AppStyles.BlacklightTextcolor,
        //             ),
        //           ),
        //           Flexible(
        //             child: Textwidget(
        //               text: "7:00AM - 8:30PM",
        //               fontSize: 12,
        //               fontWeight: FontWeight.w600,
        //             ),
        //           ),
        //         ],
        //       ),
        //       const SizedBox(
        //         height: 5,
        //       ),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Flexible(
        //             child: Textwidget(
        //               text: "Saturday - Sunday",
        //               fontSize: 12,
        //               color: AppStyles.BlacklightTextcolor,
        //             ),
        //           ),
        //           Flexible(
        //             child: Textwidget(
        //               text: "9:00AM - 6:30PM",
        //               fontSize: 12,
        //               fontWeight: FontWeight.w600,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),

        Visibility(
          visible: business.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Textwidget(
              text: "Business Name",
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Visibility(
          visible: business.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Textwidget(
                color: AppStyles.BlacklightTextcolor,
                fontSize: 12,
                maxLines: 100,
                text: business),
          ),
        ),

        Visibility(
          visible: website.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Textwidget(
              text: "Website",
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Visibility(
          visible: website.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Textwidget(
                color: AppStyles.BlacklightTextcolor,
                fontSize: 12,
                maxLines: 100,
                text: website),
          ),
        ),

        photoList.isEmpty
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Textwidget(
                  text: "Photos",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
        const SizedBox(
          height: 5,
        ),
        photoList.isEmpty
            ? const SizedBox()
            : SizedBox(
                height: 130,
                child: ListView.builder(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: photoList.length,
                    itemBuilder: (buildContext, index) {
                      var photo = photoList[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: InkWell(
                          onTap: () {
                            for (int i = 0; i < photoList.length; i++) {
                              photoString.add(photoList[i].photo);
                            }

                            Get.to(
                                PhotoViewMaidDetailsView(
                                  photos: photoString,
                                  index: index,
                                  isfirebaseImage: false,
                                ),
                                transition: Transition.rightToLeftWithFade);
                          },
                          child: Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: LoadingImage(
                                    image: photo.photo, fit: BoxFit.cover)),
                          ),
                        ),
                      );
                    }),
              )
      ],
    );
  }
}
