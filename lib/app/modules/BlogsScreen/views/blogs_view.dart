import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/cached_netword_image.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/Utils/nodata_image.dart';
import 'package:power_maids/app/modules/BlogsScreen/controllers/blogs_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';



class BlogsView extends GetView<BlogsListController> {
  const BlogsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppStyles.backgroundColor,
        titleSpacing: 5,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: AppStyles.backgroundColor,
        title:   AppbarWithBackButton(
          text: "Blogs",
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: false,
      ),
      body: Obx(() => Stack(
        children: [
          controller.isLoading.isFalse
          ?SingleChildScrollView(
            child: Column(
              children: [
                controller.blogsList.isEmpty
                ?NoDataFound(height:   MediaQuery.of(context).size.width /2,)
                :ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    shrinkWrap: true,
                    itemCount: controller.blogsList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (buildContext, index) {
                      var blogs = controller.blogsList[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 4),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 20,
                                offset: const Offset(
                                    0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              var data = {
                                "blog_id": blogs.id
                                    .toString()
                              };

                              Get.toNamed(Routes.BLOGSDETAILS,
                                  parameters: data);
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 4,
                                  height: 100,
                                  child: Card(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: LoadingImage(fit: BoxFit.fill,image: blogs.image.toString()
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Textwidget(
                                          maxLines: 2,
                                          text: blogs.title,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13.5,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Textwidget(
                                            color: Colors.grey,
                                            fontSize: 13,
                                            maxLines: 2,
                                            text: blogs.title),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    })

              ],
            ),
          )
          :ShowLoader.isLoadingProgress(controller.isLoading.value)
        ],
      )
      ),
    );
  }
}
