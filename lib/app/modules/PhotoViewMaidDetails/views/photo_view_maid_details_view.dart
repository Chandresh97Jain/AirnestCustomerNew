import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/app/modules/PhotoViewMaidDetails/controllers/photo_view_maid_details_controller.dart';

class PhotoViewMaidDetailsView extends GetView<PhotoViewMaidDetailsController> {
  final List? photos;
  final int? index;
  final isfirebaseImage;
  const PhotoViewMaidDetailsView(
      {Key? key, this.photos, this.index, this.isfirebaseImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        title: const Text(""),
        centerTitle: true,
      ),
      body: PhotoViewGallery.builder(
        backgroundDecoration: BoxDecoration(color: AppStyles.backgroundColor),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions.customChild(
              minScale: PhotoViewComputedScale.covered,
              heroAttributes: PhotoViewHeroAttributes(tag: photos![index]),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      //  height: MediaQuery.of(context).size.height / 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: isfirebaseImage == true
                            ? Image.network(
                                photos![index],
                                fit: BoxFit.fill,
                              )
                            : Image.network(
                                ApiService.imageURL + photos![index],
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  ],
                ),
              ));
        },
        pageController: PageController(initialPage: index!),
        enableRotation: false,
        itemCount: photos!.length,
      ),
    );
  }
}
