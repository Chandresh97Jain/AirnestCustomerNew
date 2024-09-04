import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/cached_netword_image.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/Utils/textformfield_ui_global.dart';
import 'package:power_maids/app/modules/EditProfile/controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: true);
        // Your custom back button handling logic
        return true; // Return true to allow popping, false to prevent
      },
      child: Scaffold(
          backgroundColor: AppStyles.backgroundColor,
          appBar: AppBar(
            titleSpacing: 5,
            toolbarHeight: 70,
            surfaceTintColor: AppStyles.backgroundColor,
            automaticallyImplyLeading: false,
            elevation: 1,
            backgroundColor: AppStyles.backgroundColor,
            title: AppbarWithBackButton(
              text:
                  controller.dashBtn.value == true ? 'Profile' : 'Edit Profile',
              onPressed: () {
                Get.back(result: true);
              },
            ),
            centerTitle: false,
          ),
          body: Obx(() => Stack(
                children: [
                  controller.isLoading.isFalse
                      ? SingleChildScrollView(
                          child: Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10),
                            child: Column(
                              children: [
                                Center(
                                  child: SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Container(
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        AppStyles.appThemeColor,
                                                    width: 2),
                                                shape: BoxShape.circle),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Obx(() => controller
                                                      .selectedImage
                                                      .value
                                                      .path
                                                      .isEmpty
                                                  ? ProfileImage(
                                                      image: controller
                                                          .profileNetwork.value,
                                                      fit: BoxFit.fill)
                                                  : ClipOval(
                                                      child: Image.file(
                                                      File(controller
                                                          .selectedImage
                                                          .value
                                                          .path),
                                                      fit: BoxFit.fill,
                                                      height: 145,
                                                      width: 145,
                                                    ))),
                                            )),
                                        IconButton(
                                            // padding: EdgeInsets.zero,
                                            onPressed: () {
                                              showModalBottomSheet<void>(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10))),
                                                // context and builder are
                                                // required properties in this widget
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 25),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                              height: 60,
                                                              decoration: BoxDecoration(
                                                                  color: AppStyles
                                                                      .backgroundColor,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border.all(
                                                                      color: AppStyles
                                                                          .appThemeColor)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        5.0),
                                                                child:
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          Get.back();

                                                                          controller
                                                                              .pickImageFromCamera(context);
                                                                        },
                                                                        icon: Image
                                                                            .asset(
                                                                          "assets/icons/camera.png",
                                                                          color:
                                                                              AppStyles.appThemeColor,
                                                                          scale:
                                                                              8,
                                                                        )),
                                                              )),
                                                        ),
                                                        Expanded(
                                                            child: Divider(
                                                          endIndent: 8,
                                                          color: AppStyles
                                                              .appThemeColor,
                                                        )),
                                                        Textwidget(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          text: "OR",
                                                          color: AppStyles
                                                              .appThemeColor,
                                                        ),
                                                        Expanded(
                                                            child: Divider(
                                                          indent: 8,
                                                          color: AppStyles
                                                              .appThemeColor,
                                                        )),
                                                        Expanded(
                                                          child: Container(
                                                              height: 60,
                                                              decoration: BoxDecoration(
                                                                  color: AppStyles
                                                                      .backgroundColor,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border.all(
                                                                      color: AppStyles
                                                                          .appThemeColor)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        5.0),
                                                                child:
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          Get.back();
                                                                          controller
                                                                              .pickImageFromGallery(context);
                                                                        },
                                                                        icon: Image
                                                                            .asset(
                                                                          "assets/icons/image-gallery.png",
                                                                          color:
                                                                              AppStyles.appThemeColor,
                                                                          scale:
                                                                              8,
                                                                        )),
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            icon: Container(
                                              decoration: BoxDecoration(
                                                  color:
                                                      AppStyles.backgroundColor,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      width: 1,
                                                      color: AppStyles
                                                          .appThemeColor)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                  "assets/icons/cameraicon.png",
                                                  height: 15,
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Textwidget(
                                  maxLines: 5,
                                  textAlign: TextAlign.center,
                                  text:
                                      "${controller.firstnameController.value.text} ${controller.lastnameController.value.text}",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                                Textwidget(
                                  text:
                                      'Member since ${controller.memberSince.value}',
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextFieldDesigned(
                                  controller:
                                      controller.firstnameController.value,
                                  prefixIcon: SizedBox(
                                    width: 25,
                                    child: Image.asset(
                                      "assets/icons/personicon.png",
                                      scale: 3.5,
                                    ),
                                  ),
                                  hintText: "First Name",
                                  keyboardType: TextInputType.text,
                                  maxLength: 25,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFieldDesigned(
                                  controller:
                                      controller.lastnameController.value,
                                  prefixIcon: SizedBox(
                                    width: 25,
                                    child: Image.asset(
                                      "assets/icons/personicon.png",
                                      scale: 3.5,
                                    ),
                                  ),
                                  hintText: "Last Name",
                                  keyboardType: TextInputType.text,
                                  maxLength: 25,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFieldDesigned(
                                  controller: controller.emailController.value,
                                  readOnly: true,
                                  prefixIcon: SizedBox(
                                    width: 25,
                                    child: SizedBox(
                                      width: 25,
                                      child: Image.asset(
                                        "assets/icons/Icon-Set.png",
                                        scale: 3.5,
                                      ),
                                    ),
                                  ),
                                  hintText: "Email",
                                  keyboardType: TextInputType.text,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                IntlPhoneField(
                                  controller: controller.numberController.value,
                                  dropdownIconPosition: IconPosition.leading,
                                  // focusNode: focusNode,
                                  showDropdownIcon: true,
                                  dropdownIcon: Icon(
                                    Icons.phone_android,
                                    color: AppStyles.appThemeColor,
                                    size: 25,
                                  ),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'JosefinSans',
                                    letterSpacing: 0.8,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xff5d5d5d),
                                  ),
                                  keyboardType: TextInputType.phone,
                                  cursorColor: const Color(0xff0F0F0F),
                                  // initialCountryCode: controller.dialCode.value,
                                  showCountryFlag: false,
                                  flagsButtonMargin:
                                      const EdgeInsets.only(left: 10),
                                  decoration: InputDecoration(
                                    hintStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      letterSpacing: 0.8,
                                      fontFamily: 'JosefinSans',
                                    ),
                                    filled: true,
                                    counterText: '',
                                    hintText: "Phone",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      //36325A
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    fillColor:
                                        AppStyles.TextFormFieldBackgroundColor,
                                    // errorStyle: TextStyle(
                                    //   fontSize: 18,
                                    //   fontWeight: FontWeight.w400,
                                    //   fontFamily: 'Lagarto',
                                    //   fontStyle: FontStyle.italic,
                                    // ),
                                  ),
                                  languageCode: "en",
                                  onChanged: (phone) {
                                    log(phone.completeNumber.toString());
                                  },
                                  onCountryChanged: (country) {
                                    log('Country changed to: ' + country.name);
                                    controller.dialCode.value =
                                        country.dialCode.toString();
                                    log('Country Code : ' +
                                        country.dialCode.toString());
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Obx(() => TextFieldDesigned(
                                      controller: controller.googleMapService
                                          .addressController.value,
                                      readOnly: false,
                                      focusNode: controller
                                          .googleMapService.focusNode.value,
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Icon(Icons.location_on_outlined,
                                            color: AppStyles.appThemeColor,
                                            size: 30),
                                      ),
                                      hintText: "Address",
                                      keyboardType: TextInputType.text,
                                      maxLength: 100,
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          if (controller
                                              .googleMapService
                                              .addressController
                                              .value
                                              .text
                                              .isEmpty) {
                                            controller.googleMapService
                                                .getCurrentLocation();
                                          }
                                        },
                                        icon: Obx(() {
                                          if (controller
                                                  .googleMapService
                                                  .addressController
                                                  .value
                                                  .text
                                                  .isEmpty &&
                                              !controller.googleMapService
                                                  .isFocused.value) {
                                            return Textwidget(
                                              text: "Current Location",
                                              color: AppStyles.appThemeColor,
                                            );
                                          } else {
                                            return const SizedBox();
                                          }
                                        }),
                                      ),
                                      onChanged: (v) {
                                        // controller.googleMapService.googlePlacesApi(v);
                                        // if (v.isEmpty) {
                                        //   FocusManager.instance.primaryFocus?.unfocus();
                                        //   controller.googleMapService.isFocused.value = false; // Ensure the focus state is updated
                                        //   controller.update(); // Trigger UI rebuild
                                        // }
                                        controller.googleMapService
                                            .googlePlacesApi(v);
                                        if (v.isEmpty) {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          controller.googleMapService.isFocused
                                              .value = false;
                                        } else {
                                          controller.googleMapService.isFocused
                                              .value = true;
                                        }
                                        controller.update();
                                      },
                                    )),

                                // Obx(() => TextFieldDesigned(
                                //   controller: controller.googleMapService.addressController.value,
                                //   readOnly: false,
                                //   focusNode: controller.googleMapService.focusNode.value,
                                //   prefixIcon: Padding(
                                //     padding: const EdgeInsets.symmetric(horizontal: 15),
                                //     child: Icon(Icons.location_on_outlined, color: AppStyles.appThemeColor, size: 30),
                                //   ),
                                //   hintText: "Address",
                                //   keyboardType: TextInputType.text,
                                //   maxLength: 100,
                                //   suffixIcon:   IconButton(
                                //     onPressed: () {
                                //       if(controller.googleMapService.addressController.value.text.isEmpty){
                                //         controller.googleMapService.getCurrentLocation();
                                //       }else{
                                //         {}
                                //       }
                                //     },
                                //     icon:   controller.googleMapService.addressController.value.text.isEmpty && controller.googleMapService.isFocused.value==false
                                //         ? Textwidget(text: "Current Location", color: AppStyles.appThemeColor)
                                //         : const SizedBox(),
                                //      ),
                                //   onChanged: (v) {
                                //     controller.googleMapService.googlePlacesApi(v);
                                //     // controller.googleMapService.addressController.value.text = v;
                                //     if(v.isEmpty){
                                //       FocusManager.instance.primaryFocus?.unfocus();
                                //       controller.update();
                                //     }
                                //
                                //   },
                                // )),
                                const SizedBox(
                                  height: 25,
                                ),

                                Obx(() => controller.googleMapService.placesList.isEmpty
                                    ? const SizedBox()
                                    : Container(
                                  decoration:   BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: AppStyles.TextformfeildOutlineColor),
                                  ),

                                  child: ListView.builder(
                                          itemCount: controller
                                              .googleMapService.placesList.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {

                                            return ListTile(
                                              title: Text(controller
                                                  .googleMapService
                                                  .placesList[index]
                                                  .description),
                                              onTap: () {
                                                controller
                                                        .googleMapService
                                                        .addressController
                                                        .value
                                                        .text =
                                                    controller
                                                        .googleMapService
                                                        .placesList[index]
                                                        .description;
                                                controller.googleMapService
                                                    .getPlaceDetails(controller
                                                        .googleMapService
                                                        .placesList[index]
                                                        .placeId
                                                        .toString());
                                                controller
                                                    .googleMapService.placesList
                                                    .clear();
                                                FocusManager.instance.primaryFocus
                                                    ?.unfocus();
                                              },
                                            );
                                          },
                                        ),
                                    )),
                                const SizedBox(
                                  height: 25,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: MyButton(
                                    text: "Update Profile",
                                    onPressed: () {
                                      controller.updateProfileApi(context);
                                    },
                                    color: AppStyles.appThemeColor,
                                    TextColor: AppStyles.backgroundColor,
                                  ),
                                ),
                                Visibility(
                                  visible: controller.dashBtn.isFalse,
                                  child: TextButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                surfaceTintColor:
                                                    AppStyles.backgroundColor,
                                                backgroundColor:
                                                    AppStyles.backgroundColor,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                elevation: 0,
                                                contentPadding: EdgeInsets.zero,
                                                titlePadding: EdgeInsets.zero,
                                                content: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 20,
                                                          bottom: 20),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Textwidget(
                                                        text: "So Sad!",
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            80,
                                                      ),
                                                      Image.asset(
                                                        "assets/icons/emojidown.png",
                                                        height: 90,
                                                      ),
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            60,
                                                      ),
                                                      Textwidget(
                                                        textAlign:
                                                            TextAlign.center,
                                                        fontSize: 15,
                                                        maxLines: 50,
                                                        text:
                                                            "Once you delete your account, there’s no getting it back. Make sure you want to do this.",
                                                      ),
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            60,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child:
                                                                  MyButtonForAlertbox(
                                                                      text:
                                                                          "Yes, Delete Account",
                                                                      onPressed:
                                                                          () {
                                                                        controller
                                                                            .accountDelete(context);
                                                                      },
                                                                      color: AppStyles
                                                                          .backgroundColor,
                                                                      TextColor:
                                                                          AppStyles
                                                                              .BlackColor)),
                                                          Expanded(
                                                              child:
                                                                  MyButtonForAlertbox(
                                                                      text:
                                                                          "No, Keep It",
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(context);
                                                                       },
                                                                      color: AppStyles
                                                                          .appThemeColor,
                                                                      TextColor:
                                                                          AppStyles
                                                                              .backgroundColor)),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      child: Text(
                                        'Delete Account',
                                        style: TextStyle(
                                            fontFamily: "JosefinSans",
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor:
                                                AppStyles.appThemeColor,
                                            color: AppStyles.appThemeColor),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ))
                      : ShowLoader.isLoadingProgress(
                          controller.isLoading.value),
                ],
              ))),
    );
  }
}
