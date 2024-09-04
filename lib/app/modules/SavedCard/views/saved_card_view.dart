import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/Utils/textformfield_ui_global.dart';
import 'package:power_maids/app/modules/SavedCard/controllers/saved_card_controller.dart';

class SavedCardView extends GetView<SavedCardController> {
  const SavedCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: AppStyles.backgroundColor,
        appBar: AppBar(
          surfaceTintColor: AppStyles.backgroundColor,
          titleSpacing: 5,
          toolbarHeight: 70,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: AppStyles.backgroundColor,
          title: AppbarWithBackButton(
            text: 'Add New Card',
            onPressed: () {
              Get.back();
            },
          ),
          centerTitle: false,
        ),
        body: Obx(() =>  controller.isLoading.isFalse && controller.isLoadingRemoveCard.isFalse  && controller.isLoadingAddCard.isFalse
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 10, bottom: 20),
                      child: Textwidget(
                        text: "Credit/Debit Card",
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 10),
                      child: Textwidget(
                        text: "Card Number",
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 20),
                        child: TextFieldDesignedOutline(
                          maxLength: 24,
                          controller: controller.cardNumberController,
                          hintText: "Enter card number",
                          inputFormatters: [CardNumberFormatter()],
                        )

                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Textwidget(
                                  text: "Valid Thru",
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFieldDesignedOutline(
                                        maxLength: 2,
                                        controller: controller.monthController,
                                        hintText: "Month",
                                       ),
                                    ),
                                     const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: TextFieldDesignedOutline(
                                        maxLength: 4,
                                        controller: controller.yearController,
                                        hintText: "Year",
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Textwidget(
                                  text: "CVV",
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Obx(() => Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: TextFieldDesignedOutline(
                                                maxLength: 4,
                                                controller:
                                                    controller.cvvController,
                                                obscureText: controller
                                                    .obscureText.value,
                                                hintText: "CVV",
                                                keyboardType:
                                                    TextInputType.number,
                                                suffixIcon: IconButton(
                                                  onPressed: () {
                                                    controller
                                                        .togglePasswordVisibility();
                                                    //  controller.obscureText.value = !controller.obscureText.value;
                                                  },
                                                  icon: Obx(() => controller
                                                          .obscureText.value
                                                      ? Image.asset(
                                                          "assets/icons/style=linear.png",
                                                          height: 25,
                                                        )
                                                      : Image.asset(
                                                          "assets/icons/view.png",
                                                          height: 25,
                                                        )),
                                                )),
                                          )),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 10),
                      child: Textwidget(
                        text: "Card Holder’s Name",
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                        ),
                        child: TextFieldDesignedOutline(
                          maxLength: 40,
                          controller: controller.cardHolderNameController,
                          hintText: "Name on Card",
                          keyboardType: TextInputType.text,
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: MyButton(
                        text: "Save card",
                        onPressed: () {
                          controller.onSubmitSaveCard();
                        },
                        color: AppStyles.appThemeColor,
                        TextColor: AppStyles.backgroundColor,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    controller.isLoading.isTrue
                        ? ShowLoader.isLoadingProgress(
                            controller.isLoading.value &&
                                controller.isLoadingRemoveCard.value)
                        : controller.cardList.isEmpty
                            ? const SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                    ),
                                    child: Textwidget(
                                      text: "Saved Card",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: controller.cardList.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (buildContext, index) {
                                        final cardList =
                                            controller.cardList[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              bottom: 10,
                                              top: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppStyles.backgroundColor,
                                              border: Border.all(
                                                  color: AppStyles
                                                      .TextformfeildOutlineColor,
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, bottom: 8, top: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                          "assets/images/mastercard.png",
                                                          scale: 3,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Flexible(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Textwidget(
                                                                text: controller
                                                                    .cardList[
                                                                        index]
                                                                    .cardHolderName,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                              Textwidget(
                                                                text: cardList
                                                                    .cardNumber,
                                                                color: AppStyles
                                                                    .GrayTextColor,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  PopupMenuButton(
                                                      surfaceTintColor:
                                                          AppStyles
                                                              .backgroundColor,
                                                      itemBuilder: (BuildContext
                                                          context) {
                                                        return [
                                                          const PopupMenuItem<
                                                              int>(
                                                            value: 0,
                                                            child: Center(
                                                                child: Text(
                                                                    "Remove")),
                                                          ),
                                                        ];
                                                      },
                                                      onSelected: (value) {
                                                        if (value == 0) {
                                                          controller.cardRemove(
                                                              cardId: controller
                                                                  .cardList[
                                                                      index]
                                                                  .id);
                                                        } else if (value == 1) {
                                                        } else if (value ==
                                                            2) {}
                                                      }),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      })
                                ],
                              )
                  ],
                ),
              )
            : ShowLoaderr.isLoadingProgress()));
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove all non-digit characters
    final sanitized = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Split into groups of 4 digits and join with spaces
    final buffer = StringBuffer();
    for (int i = 0; i < sanitized.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(sanitized[i]);
    }

    return newValue.copyWith(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
