import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/app/modules/MakeAccountWithScreen/controllers/make_account_with_screen_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';

class MakeAccountWithScreenView
    extends GetView<MakeAccountWithScreenController> {
  const MakeAccountWithScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyles.OnbordingBodybackgroundColor,
        appBar: AppBar(
          surfaceTintColor: AppStyles.OnbordingBodybackgroundColor,
          elevation: 0,
          backgroundColor: AppStyles.OnbordingBodybackgroundColor,
          centerTitle: true,

        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Image.asset(
                  "assets/icons/logo.png",
                  height: MediaQuery.of(context).size.height / 6.5,
                )),
                const SizedBox(
                  height: 20,
                ),
                Textwidget(
                  text: "Welcome!",
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  color: AppStyles.appThemeColor,
                ),
                Textwidget(
                  maxLines: 50,
                  text:
                      "What best describes your needs? Choose from one of the following options.",
                  color: AppStyles.BlacklightTextcolor,
                ),
                const SizedBox(
                  height: 15,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.makeAccountwith['id']!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (buildContext, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: CardUI(
                          iconImages: controller.makeAccountwith['IconImage']![index],
                          title: controller.makeAccountwith['title']![index],
                          discription: controller.makeAccountwith['discription']![index],
                          onPressed: () {
                            var data = {
                              "title": controller.makeAccountwith['title']![index].toString(),
                              "id": controller.makeAccountwith['id']![index].toString(),
                              "nextScreendis": controller.makeAccountwith['nextScreendis']![index].toString(),
                              "user_type":controller.makeAccountwith['id']![index].toString() == "0"?"1":"2"
                            };
                            if(controller.makeAccountwith['id']![index].toString()=="2"){
                              Get.toNamed(Routes.CREATE_BID_FOR_CLEANER_AND_COHOST);
                            }else{
                              Get.toNamed(Routes.SELECT_SERVICES, parameters: data);
                            }
                          },
                        ),
                      );
                    }
                    ),
              ],
            ),
          ),
        ),
      bottomNavigationBar:             Obx(() => controller.dashBtn.value == true
          ? Padding(
        padding: const EdgeInsets.all(20.0),
        child: IconButton(
          onPressed: (){
            Get.offAllNamed(Routes.DESHBOARD);

          },
          icon: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Textwidget(
                text: "Go to Dashboard",
                fontWeight: FontWeight.w700,
                fontSize: 15,
                maxLines: 2,
              ),
               const SizedBox(width: 5,),
              Container(
                padding:  const EdgeInsets.all(0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppStyles.appThemeColor
                ),
                child:  const Icon(Icons.arrow_right_alt,color: Colors.white),
              )
            ],
          ),
        ),
      )
          : const SizedBox())
      ,
    );
  }
}

class CardUI extends StatelessWidget {
  final String iconImages;
  final String title;
  final String discription;
  final VoidCallback? onPressed;

  const CardUI(
      {super.key, required this.iconImages,
      required this.title,
      required this.discription,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onPressed,
      child: Card(
        color: AppStyles.backgroundColor,
        surfaceTintColor: AppStyles.backgroundColor,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    Image.asset(
                      iconImages.toString(),
                      height: 25,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Textwidget(
                            text: title,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            maxLines: 2,
                          ),
                          Textwidget(
                            fontSize: 13,
                            color: AppStyles.BlacklightTextcolor,
                            maxLines: 5,
                            text: discription,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20,
                color: AppStyles.BlacklightTextcolor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
