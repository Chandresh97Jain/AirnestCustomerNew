import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/appbar_with_backbutton.dart';
import 'package:power_maids/Utils/button_ui_global.dart';
import 'package:power_maids/Utils/cached_netword_image.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/Utils/textformfield_ui_global.dart';
import 'package:power_maids/app/modules/AddRequirementCleaner/controllers/add_requirement_cleaner_controller.dart';
import 'package:power_maids/app/modules/BookingSummary/controllers/booking_summary_controller.dart';
import 'package:power_maids/app/modules/ExtraworkAddScreen/priceforairbnb_dynamic_ui.dart';
import 'package:power_maids/app/modules/MaidDetails/controllers/maid_details_controller.dart';
import '../../../../Payment/stripe_payment.dart' as payment;
import '../../../../Payment/stripe_payment.dart';


class BookingSummaryView extends GetView<BookingSummaryController> {
  const BookingSummaryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // BookingSummaryController controller = Get.put(BookingSummaryController());
    List<int> yearOptions = controller.generateYears();

    MaidDetailsController maidDetailsController = Get.put(MaidDetailsController());
    AddRequirementCleanerController addRequirementCleanerController = Get.put(AddRequirementCleanerController());


    double af = controller.adminFees.value;
    
    // if(controller.serviceId.value == "1" || controller.serviceId.value == "2" || controller.serviceId.value == "4"){
    //   double tp = double.parse(addRequirementCleanerController.totalPayment.value);
    //   double totalCommissionPrice = (af / 100) * tp;
    //   // double final_total = tp+totalCommissionPrice;
    //   // controller.totalPrice.value = final_total.toString();
    //
    //   controller.total_commision_price.value = totalCommissionPrice.toString();
    //   print("Total amount admin fees: \$${controller.total_commision_price.value}");
    //
    // }else if(controller.serviceId.value == "3" || controller.serviceId.value == "6"){
    //   double tsp = double.parse(addRequirementCleanerController.totalSqftPrice.value);
    //   double totalCommissionPrice = (af / 100) * tsp;
    //   // double final_total = tsp+totalCommissionPrice;
    //   // controller.totalPrice.value = final_total.toString();
    //
    //   controller.total_commision_price.value = totalCommissionPrice.toString();
    //   print("Total amount admin fees: \$${controller.total_commision_price.value}");
    //
    // }else{
    //   double thp = double.parse(addRequirementCleanerController.totalHourlyPrice.value);
    //   double totalCommissionPrice = (af / 100) * thp;
    //   // double final_total = thp+totalCommissionPrice;
    //   // controller.totalPrice.value = final_total.toString();
    //
    //   controller.total_commision_price.value = totalCommissionPrice.toString();
    //   print("Total amount admin fees: \$${controller.total_commision_price.value}");
    //
    // }
    

    //  double totalPayment = 40.0;
    // double adminFeePercentage = 5.0;
    // double adminFee = (adminFeePercentage / 100) * totalPayment;
    // // double amountAfterFees = totalPayment - adminFee;
    //
    // log("Total amount after admin fees: \$${adminFee.toStringAsFixed(2)}");

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
          text: 'Booking Summary',
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: false,
      ),
      body: Obx(() =>  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Textwidget(
                        text: "Date and Time",
                        color: AppStyles.GrayTextColor,
                      ),
                      Textwidget(
                        text: controller.formatDateString(addRequirementCleanerController.selectedDate.value.toString()),
                        // text: DateFormat("d mmm, yyyy").format(addRequirementCleanerController.selectedDate.value!),
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                      Textwidget(
                        text: controller.formatTimeOfDay(addRequirementCleanerController.selectedTime.value)
                      ),
                    ],
                  ),
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: Image.asset(
                  //       "assets/icons/writeicon.png",
                  //       height: 30,
                  //     ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
                height: 0,
                color: AppStyles.deviderColor,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: LoadingImage(image: maidDetailsController.profileImage.value, fit: BoxFit.fill,)
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Textwidget(
                          text: controller.serviceName.value,
                          color: AppStyles.GrayTextColor,
                        ),
                        Textwidget(
                          text: maidDetailsController.cleanerCoHostName.value,
                          // text: maidDetailsController.cleaner_coHost_name.value,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                        Textwidget(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          maxLines: 50,
                          text:maidDetailsController.about.value
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Divider(
                thickness: 1,
                height: 0,
                color: AppStyles.deviderColor,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Textwidget(
                          text: "Billing To",
                          color: AppStyles.GrayTextColor,
                        ),
                        Textwidget(
                          text: "${controller.fName.value} ${controller.lName.value}",
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                        Textwidget(
                          maxLines: 10,
                          text: controller.address.value,
                        ),
                        Textwidget(
                          text: controller.number.value,
                        ),
                      ],
                    ),
                  ),
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: Image.asset(
                  //       "assets/icons/writeicon.png",
                  //       height: 30,
                  //     ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
                height: 0,
                color: AppStyles.deviderColor,
              ),
              const SizedBox(
                height: 10,
              ),
              Textwidget(
                text: "Price Details",
                color: AppStyles.GrayTextColor,
              ),
              if(controller.serviceId.value == "1" || controller.serviceId.value == "2" || controller.serviceId.value == "4")
                ListView.builder(
                    itemCount: addRequirementCleanerController.serviceLableId.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (buildContext, index){
                      // var lable = controller.priceLabels[index];

                      return Padding(
                        padding:
                        const EdgeInsets.only(left: 12, right: 12, bottom: 10),
                        child: PriceforAirbnb(
                            title: addRequirementCleanerController.serviceTitleList[index],
                            totalprice: "\$${addRequirementCleanerController.serviceTotalPriceList[index]}",
                            price: "\$${addRequirementCleanerController.serviceActualPrice[index]}",
                            counttext: addRequirementCleanerController.serviceQtyList[index].toString()),
                      );
                    }
                )
              else if(controller.serviceId.value == "3" || controller.serviceId.value == "6")
                if(controller.serviceId.value == "1" || controller.serviceId.value == "2" || controller.serviceId.value == "4")
                  ListView.builder(
                      itemCount: addRequirementCleanerController.serviceLableId.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (buildContext, index){
                        // var lable = controller.priceLabels[index];

                        return Padding(
                          padding:
                          const EdgeInsets.only(left: 12, right: 12, bottom: 10),
                          child: PriceforAirbnb(
                              title: addRequirementCleanerController.serviceTitleList[index],
                              totalprice: "\$${addRequirementCleanerController.serviceTotalPriceList[index]}",
                              price: "\$${addRequirementCleanerController.serviceActualPrice[index]}",
                              counttext: addRequirementCleanerController.serviceQtyList[index].toString()),
                        );
                      }
                  )
                else if(controller.serviceId.value == "3" || controller.serviceId.value == "6")
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5),
                      child:Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/icons/Vector (3).png",
                            scale: 3,
                            color: AppStyles.appThemeColor,
                          ),
                          const SizedBox(width: 15,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Textwidget(
                                text: "${addRequirementCleanerController.sQft.value} Sq.ft" ,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                              Textwidget(
                                text: "\$${addRequirementCleanerController.totalSqftPrice.value} - ${
                                    addRequirementCleanerController.selectServiceWeeklySqrFeel.value == "0"
                                        ?"Week"
                                        :addRequirementCleanerController.selectServiceWeeklySqrFeel.value == "1"
                                        ?"Bi Week"
                                        :"Month"
                                }",
                                color: AppStyles.appThemeColor,
                              ),
                            ],
                          ),
                        ],
                      )
                  )  // suqer feet
                else
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 5),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image.asset(
                            //   "assets/icons/Vector (5).png",
                            //   scale: 4,
                            //   color: AppStyles.appThemeColor,
                            // ),
                            // SizedBox(width: 5,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Textwidget(
                                      text:addRequirementCleanerController.selectServiceWeeklyHourly.value == "0"
                                          ? "Weekly"
                                          :addRequirementCleanerController.selectServiceWeeklyHourly.value == "1"
                                          ?'Bi Weekly'
                                          :"Monthly",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Textwidget(
                                      text: "\$${addRequirementCleanerController.actualHourlyPrice.value}",
                                      fontSize: 12,
                                      color: AppStyles.appThemeColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Image.asset(
                                      "assets/icons/cancelicon.png",
                                      color: AppStyles.appThemeColor,
                                      scale: 7.5,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Textwidget(
                                      textscalefector: 1,
                                      text: addRequirementCleanerController.hourQty.value,
                                      fontWeight: FontWeight.w700,
                                      color: AppStyles.appThemeColor,
                                      fontSize: 12,
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        Textwidget(
                          text: "\$${addRequirementCleanerController.totalHourlyPrice.value}",
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ],
                    ),
                  ) // suqer feet
              else
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image.asset(
                          //   "assets/icons/Vector (5).png",
                          //   scale: 4,
                          //   color: AppStyles.appThemeColor,
                          // ),
                          // SizedBox(width: 5,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Textwidget(
                                    text:addRequirementCleanerController.selectServiceWeeklyHourly.value == "0"
                                        ? "Weekly"
                                        :addRequirementCleanerController.selectServiceWeeklyHourly.value == "1"
                                        ?'Bi Weekly'
                                        :"Monthly",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Textwidget(
                                    text: "\$${addRequirementCleanerController.actualHourlyPrice.value}",
                                    fontSize: 12,
                                    color: AppStyles.appThemeColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Image.asset(
                                    "assets/icons/cancelicon.png",
                                    color: AppStyles.appThemeColor,
                                    scale: 7.5,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Textwidget(
                                    textscalefector: 1,
                                    text: addRequirementCleanerController.hourQty.value,
                                    fontWeight: FontWeight.w700,
                                    color: AppStyles.appThemeColor,
                                    fontSize: 12,
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Textwidget(
                        text: "\$${addRequirementCleanerController.totalHourlyPrice.value}",
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ],
                  ),
                ),

              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Textwidget(
                    text: "Processing Fee(${controller.adminFeesShow.value}%)",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  Obx(() => Textwidget(
                    text: "\$${controller.totalCommisionPrice.value}",
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
                height: 0,
                color: AppStyles.deviderColor,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Textwidget(
                    text: "Total Price",
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),

                  if(controller.serviceId.value == "1" || controller.serviceId.value == "2" || controller.serviceId.value == "4")
                    Textwidget(
                      text: "\$${controller.totalPrice.value}",
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    )
                  else if(controller.serviceId.value == "3" || controller.serviceId.value == "6")
                    Textwidget(
                      text: "\$${controller.totalPrice.value}",
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ) // suqer feet
                  else
                    Textwidget(
                      text: "\$${controller.totalPrice.value}",
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Textwidget(
                text: "Payment Method",
                color: AppStyles.GrayTextColor,
              ),
              controller.isLoading.isTrue
                  ? ShowLoader.isLoadingProgress(controller.isLoading.value)
                  :   controller.cardList.isEmpty
              ? const SizedBox()
              :ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.cardList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (buildContext, index) {
                    final itemName = 'Item $index';
                    final cardList = controller.cardList[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppStyles.backgroundColor,
                          border: Border.all(
                              color: AppStyles.TextformfeildOutlineColor,
                              width: 1.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, bottom: 8, top: 8),
                          child: InkWell(
                            onTap: () {
                              controller.paymentSelected.value = itemName;
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/mastercard.png",
                                      scale: 3,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Textwidget(
                                          text: "Bank of name",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        Textwidget(
                                          text: cardList.cardNumber,
                                          color: AppStyles.GrayTextColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Obx(() =>
                                  controller.paymentSelected.value ==
                                      itemName
                                      ? Image.asset(
                                    "assets/icons/circulfilledicon.png",
                                    height: 23,
                                  )
                                      : Image.asset(
                                    "assets/icons/ciruleicon.png",
                                    height: 23,
                                  )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    showModalBottomSheet(
                      useSafeArea: true,
                        elevation: 0,
                        backgroundColor: AppStyles.OnbordingBodybackgroundColor,
                        isScrollControlled: true,
                        context: context,
                        builder: (builder) {
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 5, top: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Textwidget(
                                        text: "Add New Card",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          icon: const Icon(
                                            Icons.cancel_outlined,
                                            size: 30,
                                          ))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      // Textwidget(
                                      //   text: "Credit/Debit Card",
                                      //   fontSize: 18,
                                      //   fontWeight: FontWeight.w700,
                                      // ),
                                      SizedBox(
                                        height:
                                        MediaQuery.of(context).size.height /
                                            80,
                                      ),
                                      Textwidget(
                                        text: "Card Number",
                                      ),
                                      SizedBox(
                                        height:
                                        MediaQuery.of(context).size.height /
                                            100,
                                      ),
                                      TextFieldDesignedOutline(
                                        controller: controller.cardNumberController,
                                        maxLength: 14,
                                        hintText: "Enter 12 digit card number",
                                      ),
                                      SizedBox(
                                        height:
                                        MediaQuery.of(context).size.height /
                                            50,
                                      ),
                                      Row(
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
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(12),
                                                              border: Border.all(
                                                                  color: AppStyles
                                                                      .TextformfeildOutlineColor)),
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(
                                                                left: 10, right: 10),
                                                            child: Center(
                                                              child: Obx(
                                                                    () => DropdownButton<String>(
                                                                  hint: Textwidget(
                                                                    text: "Month",
                                                                  ),
                                                                  padding: EdgeInsets.zero,
                                                                  value: controller.selectedMonth.value,
                                                                  icon: const Icon(
                                                                      Icons.keyboard_arrow_down_outlined),
                                                                  iconSize: 24,
                                                                  elevation: 16,
                                                                  style: const TextStyle(
                                                                      color: Colors.black),
                                                                  underline: Container(),
                                                                  onChanged: (newValue) {
                                                                    controller.selectedMonth.value =
                                                                    newValue!;
                                                                  },
                                                                  items: controller.options
                                                                      .map<DropdownMenuItem<String>>(
                                                                          (String value) {
                                                                        return DropdownMenuItem<String>(
                                                                          value: value,
                                                                          child: Text(
                                                                            value,
                                                                            style: const TextStyle(
                                                                                fontFamily: "JosefinSans"),
                                                                          ),
                                                                        );
                                                                      }).toList(),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )

                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(12),
                                                              border: Border.all(
                                                                  color: AppStyles
                                                                      .TextformfeildOutlineColor)),
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(
                                                                left: 10, right: 10),
                                                            child: Center(
                                                              child: Obx(
                                                                    () => DropdownButton<String>(
                                                                  hint:  const
                                                                  Text('Year'),
                                                                  padding: EdgeInsets.zero,
                                                                  value: controller.selectedYear.value,
                                                                  icon: const Icon(
                                                                      Icons.keyboard_arrow_down_outlined),
                                                                  iconSize: 24,
                                                                  elevation: 16,
                                                                  style: const TextStyle(
                                                                      color: Colors.black),
                                                                  underline: Container(),
                                                                  onChanged: (newValue) {
                                                                    controller.selectedYear.value =
                                                                        newValue;
                                                                  },
                                                                  items: yearOptions.map((int year) {
                                                                    return DropdownMenuItem<String>(
                                                                      value: year.toString(),
                                                                      child: Text(year.toString()),
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )),
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
                                                            maxLength: 3,
                                                            controller:
                                                            controller.cvvController,
                                                            obscureText:
                                                            controller.obscureText.value,
                                                            hintText: "CVV",
                                                            keyboardType: TextInputType.text,
                                                            suffixIcon: IconButton(
                                                              onPressed: () {
                                                                controller
                                                                    .togglePasswordVisibility();
                                                                //  controller.obscureText.value = !controller.obscureText.value;
                                                              },
                                                              icon: Obx(() =>
                                                              controller.obscureText.value
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

                                      SizedBox(
                                        height:
                                        MediaQuery.of(context).size.height /
                                            50,
                                      ),
                                      Textwidget(
                                        text: "Card Holder’s Name",
                                      ),
                                      SizedBox(
                                        height:
                                        MediaQuery.of(context).size.height /
                                            100,
                                      ),
                                      TextFieldDesignedOutline(
                                        controller: controller.cardholderNameController,
                                        keyboardType: TextInputType.text,
                                        maxLength: 35,
                                        hintText: "Name on Card",
                                      ),
                                      SizedBox(
                                        height:
                                        MediaQuery.of(context).size.height /
                                            20,
                                      ),
                                      Padding(
                                          padding:
                                          MediaQuery.of(context).viewInsets,
                                          child: controller.isLoadingAddCard.isTrue
                                              ?ShowLoader.isLoadingProgress(controller.isLoadingAddCard.value)
                                              :MyButton(
                                            text: 'Save card & Proceed',
                                            onPressed: () {
                                              controller.addCardApi();
                                              // Get.offNamed(Routes
                                              //     .PAYMENT_SUCCESSFUL_SCREEN);
                                            },
                                            color: AppStyles.appThemeColor,
                                            TextColor: AppStyles.backgroundColor,
                                          )

                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  icon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/icons/add.png",
                        height: 25,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Textwidget(
                        text: "Add New Card",
                        fontWeight: FontWeight.w500,
                        color: AppStyles.GraylightTextColor,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),),
      bottomNavigationBar: Obx((){
        return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 8, top: 8),
            child: InkWell(
                onTap:  controller.isOpenLoadingSheet.value == true
                    ?(){}
                    :() async {
                  controller.isOpenLoadingSheet.value = true;
                  await StripePaymentHandle().stripeMakePayment();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 7.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: AppStyles.appThemeColor),
                  child: Center(
                      child: controller.isOpenLoadingSheet.value == true
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                          :Text(
                        "Proceed to Pay",
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontFamily: "JosefinSans",
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      )
                  ),
                )
            )

          // MyButton(
          //   onPressed: () {
          //     // Get.toNamed(Routes.PAYMENT_SUCCESSFUL_SCREEN);
          //     // if(controller.serviceId.value == "1" || controller.serviceId.value == "2" || controller.serviceId.value == "4"){
          //     //   double cf = double.parse(controller.total_commision_price.value);
          //     //   double tp = double.parse(addRequirementCleanerController.totalPayment.value);
          //     //   double final_price = tp + cf;
          //     //   controller.totalPrice.value = final_price.toString();
          //     // }else if(controller.serviceId.value == "3" || controller.serviceId.value == "6"){
          //     //   controller.totalPrice.value = addRequirementCleanerController.totalSqftPrice.value;
          //     // }else{
          //     //   controller.totalPrice.value = addRequirementCleanerController.totalHourlyPrice.value;
          //     // }
          //
          //     payment.StripePaymentHandle().stripeMakePayment();
          //   },
          //   text: "Proceed to Pay",
          //   color: AppStyles.appThemeColor,
          //   TextColor: AppStyles.backgroundColor,
          // ),
        );
      }),
    );
  }
}
