import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/cached_netword_image.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/Utils/nodata_image.dart';
import 'package:power_maids/app/modules/BlogsDetailsScreen/controllers/blogs_details_controller.dart';



class BlogsDetailsView extends GetView<BlogsDetailsController> {
  const BlogsDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controllerrr = Get.put(BlogsDetailsController());
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppStyles.backgroundColor,
        titleSpacing: 5,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: AppStyles.backgroundColor,
        title:   AppbarWithBackButton(
          text: "Blog Details",
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: false,
      ),
      body: Obx(
            () => Stack(
              children: [
                controllerrr.isLoading.isFalse
                    ?SingleChildScrollView(
                      child: Column(
                        children: [
                          controllerrr.blogsList.isEmpty
                              ?NoDataFound(height:   MediaQuery.of(context).size.width /2,)
                              :Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(

                                      height: 200,
                                      width: MediaQuery.of(context).size.width,
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: LoadingImage(image: controllerrr.blogsDetails['image'], fit: BoxFit.fill)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: Textwidget(maxLines: 5,text: controllerrr.blogsDetails['title'],fontWeight: FontWeight.w700,fontSize: 14,textAlign: TextAlign.center,),
                                    ),

                                    Html(
                                        data: controllerrr.blogsDetails['description'],
                                        style: {
                                          "body": Style(
                                            fontFamily: "JosefinSans",
                                            fontSize: FontSize(14.0), // Change font size
                                           // fontWeight: FontWeight.bold, // Make text bold
                                            // fontStyle: FontStyle.italic, // Italicize text
                                          )
                                        }




                                    ),

                                  ],
                                ),
                              )

                        ],
                      ),
                    )
                    :ShowLoader.isLoadingProgress(controllerrr.isLoading.value)
              ],
            )
      ),
    );
  }
}
