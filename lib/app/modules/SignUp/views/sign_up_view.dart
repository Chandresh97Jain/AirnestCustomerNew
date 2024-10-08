import 'dart:developer';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/Utils/onbording_appbar.dart';
import 'package:power_maids/Utils/textformfield_ui_global.dart';
import 'package:power_maids/app/modules/SignUp/controllers/sign_up_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // Set a base font size
    double titleFontSize = 24.0;
    double secoundtitleFontSize = 19.0;
    double fontSizeForteen = 14.0;
    // Calculate the adjusted font size based on screen width
    double titleAdjustedFontSize = screenWidth / 350.0 * titleFontSize;
    double secoundtitleAdjustedFontSize =
        screenWidth / 370.0 * secoundtitleFontSize;
    double fontSizeForteenAdjustedFontSize =
        screenWidth / 350.0 * fontSizeForteen;

    return  Obx(() => Scaffold(
      backgroundColor: AppStyles.OnbordingBodybackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        surfaceTintColor: AppStyles.backgroundColor,
        backgroundColor: AppStyles.backgroundColor,
        title: const OnbordingScreensAppbar(Title: "Sign Up"),
        centerTitle: true,
      ),
      body:  controller.isLoading.isFalse
          ?   SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Textwidget(
                    textscalefector: 1,
                    text: "Create your account",
                    fontWeight: FontWeight.w700,
                    fontSize: titleAdjustedFontSize,
                    color: AppStyles.appThemeColor,
                  ),
                  Textwidget(
                    textscalefector: 1,
                    text: "Sign up to join",
                    fontWeight: FontWeight.w400,
                    fontSize: secoundtitleAdjustedFontSize,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: AppStyles.backgroundColor,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppStyles.backgroundColor),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 30),
                    child: Column(
                      children: [
                        TextFieldDesigned(
                          controller: controller.firstNameTextController,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 9.5),
                            child: Image.asset(
                              "assets/icons/fn.png",
                              scale: 3.5,
                            ),
                          ),
                          hintText: "First Name",
                          keyboardType: TextInputType.text,
                          maxLength: 30,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldDesigned(
                          controller: controller.lastNameTextController,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 9.5),
                            child: Image.asset(
                              "assets/icons/fn.png",
                              scale: 3.5,
                            ),
                          ),
                          hintText: "Last Name",
                          keyboardType: TextInputType.text,
                          maxLength: 30,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldDesigned(
                          controller: controller.emailTextController,
                          prefixIcon: Image.asset(
                            "assets/icons/Icon-Set.png",
                            scale: 3.5,
                          ),
                          hintText: "Email",
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        IntlPhoneField(
                          controller: controller.phoneTextController,
                          dropdownIconPosition: IconPosition.leading,
                          // focusNode: focusNode,
                          showDropdownIcon: true,
                          dropdownIcon:  Icon(Icons.phone_android,color: AppStyles.appThemeColor,size: 25,),

                          style:const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'JosefinSans',
                            letterSpacing: 0.8,
                            fontStyle: FontStyle.normal,
                            color: Color(0xff5d5d5d),
                          ),
                          keyboardType: TextInputType.phone,
                          cursorColor:const  Color(0xff0F0F0F),
                          showCountryFlag: false,
                          flagsButtonMargin: const EdgeInsets.only(left: 10),
                          decoration: InputDecoration(
                            hintStyle:const TextStyle(
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
                              borderSide:   BorderSide.none,
                              //36325A
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:  BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide:  BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:  BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            fillColor: AppStyles.TextFormFieldBackgroundColor,
                            // errorStyle: TextStyle(
                            //   fontSize: 18,
                            //   fontWeight: FontWeight.w400,
                            //   fontFamily: 'Lagarto',
                            //   fontStyle: FontStyle.italic,
                            // ),
                          ),
                          languageCode: "en",
                          onChanged: (phone) {
                            log(phone.completeNumber);
                          },



                          onCountryChanged: (country) {
                            log('Country changed to: ' + country.name);
                            controller.countryCode.value = country.dialCode.toString();
                            log('Country Code : ' + country.dialCode);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(() => TextFieldDesigned(
                            controller: controller.passwordTextController,
                            obscureText: controller.obscureTextpassword.value,
                            prefixIcon: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8),
                              child: Image.asset(
                                "assets/icons/Vector.png",
                                scale: 3.5,
                              ),
                            ),
                            hintText: "Password",
                            keyboardType: TextInputType.text,
                            maxLength: 30,
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.togglePasswordVisibility();
                                //  controller.obscureText.value = !controller.obscureText.value;
                              },
                              icon:
                              Obx(() => controller.obscureTextpassword.value
                                  ? Image.asset(
                                "assets/icons/style=linear.png",
                                height: 25,
                              )
                                  : Image.asset(
                                "assets/icons/view.png",
                                height: 25,
                              )),
                            )
                        )
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        Obx(() => TextFieldDesigned(
                          controller: controller.googleMapService.addressController.value,
                          readOnly: false,
                          focusNode: controller.googleMapService.focusNode.value,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Icon(Icons.location_on_outlined, color: AppStyles.appThemeColor, size: 30),
                          ),
                          hintText: "Address",
                          keyboardType: TextInputType.text,
                          maxLength: 100,
                          suffixIcon: IconButton(
                            onPressed: () {
                              if(controller.googleMapService.addressController.value.text.isEmpty){
                                controller.googleMapService.getCurrentLocation();
                              }else{
                                {}
                              }
                            },
                            icon: controller.googleMapService.addressController.value.text.isEmpty && controller.googleMapService.isFocused.value==false
                                ? Textwidget(text: "Current Location", color: AppStyles.appThemeColor)
                                : const SizedBox(),
                          ),
                          onChanged: (v) {
                            controller.googleMapService.googlePlacesApi(v);
                            // controller.googleMapService.addressController.value.text = v;
                            if(v.isEmpty){
                              FocusManager.instance.primaryFocus?.unfocus();
                            }

                          },
                        )),
                        Obx(() => controller.googleMapService.placesList.isEmpty
                            ? const SizedBox()
                            : ListView.builder(
                          itemCount: controller.googleMapService.placesList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(controller.googleMapService.placesList[index].description),
                              onTap: () {
                                controller.googleMapService.addressController.value.text = controller.googleMapService.placesList[index].description;
                                controller.googleMapService.getPlaceDetails(controller.googleMapService.placesList[index].placeId.toString());
                                controller.googleMapService.placesList.clear();
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                            );
                          },
                        )),

                        const SizedBox(
                          height: 10,
                        ),
                        Obx(() {
                          return DropdownButton<String>(
                            value: controller.selectedOption.value == "Select an option"
                                ? null
                                : controller.selectedOption.value,
                            hint: Textwidget(
                              text: "How did you learn about us?",
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            iconEnabledColor: AppStyles.appThemeColor,
                            iconDisabledColor: AppStyles.appThemeColor,
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontFamily: "JosefinSans",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                //color: Theme.of(context).iconTheme.color
                                // decorationColor:decorationColor,
                                // decoration: decoration,
                                color: Colors.black
                            ),

                            isExpanded: true,
                            items: controller.options.map((String option) {
                              return DropdownMenuItem<String>(
                                enabled: true,
                                value: option,
                                child: Text(option),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                controller.updateSelected(value);
                              }
                            },
                            underline: SizedBox(), // This removes the underline
                          );
                        }),
                        const SizedBox(
                          height: 10,
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Obx(
                                  () => Checkbox(
                                activeColor: AppStyles.appThemeColor,
                                value: controller.isChecked.value,
                                onChanged: (bool? value) {
                                  controller.isChecked.value = value ?? false;
                                },
                              ),
                            ),
                            Flexible(
                              child: RichText(
                                textScaleFactor: 1,
                                maxLines: 25,
                                text: TextSpan(
                                  text: "By submitting your information, you agree to the ",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    height: 1.4,
                                    fontFamily: "JosefinSans",
                                    color: Colors.black, // You can set the default color here
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Terms",
                                      style: TextStyle(
                                        fontFamily: "JosefinSans",
                                        fontSize: 14,
                                        color: AppStyles.appThemeColor, // Make the link text blue
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          Get.toNamed(Routes.TERMS_AND_CONDITIONS);
                                        },
                                    ),
                                    TextSpan(
                                      text: " & ",
                                      style: const TextStyle(
                                        fontFamily: "JosefinSans",
                                        fontSize: 14,
                                        color: Colors.black, // Make the link text blue
                                      ),
                                      recognizer: TapGestureRecognizer()
                                    ),
                                    TextSpan(
                                      text: "Conditions",
                                      style: TextStyle(
                                        fontFamily: "JosefinSans",
                                        fontSize: 14,
                                        color: AppStyles.appThemeColor, // Make the link text blue
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          Get.toNamed(Routes.TERMS_AND_CONDITIONS);
                                        },
                                    ),
                                    const TextSpan(
                                      text: " of Airnest.",
                                      style:   TextStyle(
                                        fontFamily: "JosefinSans",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyButton(
                          onPressed: () {
                            controller.validation(context);
                          },
                          text: "Next",
                          color: AppStyles.appThemeColor,
                          TextColor: AppStyles.backgroundColor,
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Row(children: <Widget>[
                Expanded(
                    child: Divider(
                      color: AppStyles.deviderColor,
                      thickness: 1,
                    )),
                const SizedBox(
                  width: 10,
                ),
                Textwidget(
                  text: "Or Login With",
                  fontSize: fontSizeForteenAdjustedFontSize,
                  textscalefector: 1,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Divider(
                      color: AppStyles.deviderColor,
                      thickness: 1,
                    )),
              ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      controller.signInWithFacebook();
                    },
                    icon: Image.asset(
                      "assets/icons/facebbok.png",
                      scale: 3.5,
                    )),
                const SizedBox(
                  width: 8,
                ),
                IconButton(
                    onPressed: () {
                      controller.signInWithGoogle(context);
                    },
                    icon: Image.asset(
                      "assets/icons/Google (1).png",
                      scale: 3.5,
                    )),
                const SizedBox(
                  width: 8,
                ),

                if(Platform.isAndroid)
                 const  SizedBox()
                else
                  IconButton(
                      onPressed: () {
                        controller.onAppleLogin();
                      },
                      icon: Image.asset(
                        "assets/icons/Apple.png",
                        scale: 3.5,
                      )),

              ],
            ),
          ],
        ),
      ) :
      ShowLoader.isLoadingProgress(controller.isLoading.value),
      bottomNavigationBar: controller.isLoading.isFalse
          ? Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 15),
        child: Padding(
          padding: MediaQuery.viewInsetsOf(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  child: Textwidget(
                textscalefector: 1,
                text: "Already have an account?",
                fontSize: fontSizeForteenAdjustedFontSize,
                fontWeight: FontWeight.w500,
              )),
              Flexible(
                  child: TextButton(
                      onPressed: () {
                        controller.firstNameTextController.clear();
                        controller.lastNameTextController.clear();
                        controller.emailTextController.clear();
                        controller.phoneTextController.clear();
                        controller.passwordTextController.clear();
                        controller.googleMapService.addressController.value.clear();
                        Get.offAllNamed(Routes.SIGN_IN);
                      },
                      child: Textwidget(
                        textscalefector: 1,
                        text: "Sign In",
                        fontSize: fontSizeForteenAdjustedFontSize,
                        fontWeight: FontWeight.w700,
                        color: AppStyles.appThemeColor,
                      )))
            ],
          ),
        ),
      ) : const SizedBox() ,
    ));
  }
}
