import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:power_maids/Utils/ShowToast.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/modules/AddRequirementCleaner/controllers/add_requirement_cleaner_controller.dart';
import 'package:power_maids/app/modules/BookingSummary/model/card_list_model.dart';
import 'package:power_maids/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';



class BookingSummaryController extends GetxController {
  //TODO: Implement BookingSummaryController

  final  TextEditingController  cardNumberController  = TextEditingController();
  TextEditingController  cardholderNameController  = TextEditingController();
  TextEditingController  cvvController  = TextEditingController();
  AddRequirementCleanerController addRequirementCleanerController = Get.put(AddRequirementCleanerController());


  final count = 0.obs;
  final isChecked = false.obs;
  final obscureText = true.obs;

  final paymentSelected = "".obs;


  void togglePasswordVisibility() {
    obscureText.toggle();
    update();
  }




  Rx<String?> selectedMonth = Rx<String?>(null);
  Rx<String?> selectedYear = Rx<String?>(null);
  String formatDateString(String dateString) {
    // Parse the input date string
    DateTime parsedDate = DateTime.parse('20$dateString'); // Add '20' prefix to make it a valid DateTime

    // Format the date
    String formattedDate = DateFormat('EEEE, MMM d').format(parsedDate);

    return formattedDate;
  }
  List<String> options = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12'
  ];


  List<int> generateYears() {
    // Generate a list of recent years, adjust the range as needed
    int currentYear = DateTime.now().year;
    return List.generate(50, (index) => currentYear + index);
  }

  // final title ="".obs;
  // final id ="".obs;
  final userType ="".obs;
  final cleanerCohostId ="".obs;
  final serviceId ="".obs;
  final serviceName ="".obs;
  final zipCode ="".obs;
  final isLoading =false.obs;
  final isOpenLoadingSheet = false.obs;

  final fName ="".obs;
  final lName ="".obs;
  final address ="".obs;
  final number ="".obs;
  final propertyId ="".obs;
  final bidId ="".obs;

  final totalPrice ="".obs;

  final bookingPrice ="".obs;

  final adminFees = 0.0.obs;
  final adminFeesShow = "".obs;
  final totalCommisionPrice ="".obs;
  // final total_commision_show ="".obs;

  String? formatTimeOfDay(TimeOfDay? timeOfDay) {
    if (timeOfDay == null) return null;
    final hour = timeOfDay.hour.toString().padLeft(2, '0');
    final minute = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  void onInit() {
  // title.value = Get.parameters['title']??"";
  // id.value = Get.parameters['id']??"";
  zipCode.value = Get.parameters['zip_code']!;
  userType.value = Get.parameters['user_type']!;
  cleanerCohostId.value = Get.parameters['cleaner_cohost_id']!;
  serviceId.value = Get.parameters['service_id']!;
  serviceName.value = Get.parameters['service_name']!;
  propertyId.value = Get.parameters['property_id']!;
  bidId.value = Get.parameters['bid_id']!;
  getSession();
  adminFee();
  super.onInit();
  cardListApi();
}

  getSession()async{
    final prefs = await SharedPreferences.getInstance();
     fName.value = prefs.getString('firstname')!;
     lName.value = prefs.getString('lastname')!;
     address.value = prefs.getString('address')!;
     number.value = prefs.getString('mobile')!;

     log("mobile ------ ${number.value}");
     log("mobile ------ ${number.value}");
  }

  final cardList = <CardListModel>[].obs;
  Future cardListApi() async {
    cardList.clear();
    try {
      isLoading(true);

      var response = await ApiService().cardListApi();

      if (response['status'] == true) {

        List dataList = response['data'].toList();
          cardList.value = dataList.map((json) => CardListModel.fromJson(json)).toList();

        update();
        isLoading(false);
      } else if (response['status'] == false) {
        // ToastClass.showToast('${response['message']}',);
        isLoading(false);
        update();
      }
    } finally {
      isLoading(false);
      update();

    }
  }

  final isLoadingAddCard = false.obs;
  Future addCardApi() async {
    cardList.clear();
    try {
      isLoadingAddCard(true);

      var response = await ApiService().addCard(
          cardholderNameController.text,
          cardNumberController.text,
          selectedMonth.value,
          selectedYear.value,
          cvvController.text
      );

      if (response['status'] == true) {
        Get.back();
        cardListApi();

        cardholderNameController.clear();
        cardNumberController.clear();
        selectedMonth.value = "";
        selectedYear.value = "";
        cvvController.clear();

        ToastClass.showToast('${response['message']}',);
        isLoadingAddCard(false);
      } else if (response['status'] == false) {
        ToastClass.showToast('${response['message']}',);
        isLoadingAddCard(false);
        update();
      }
    } finally {
      isLoadingAddCard(false);
      update();

    }
  }

  final isLoadingCheckOut = false.obs;
  Future checkOutApi(transactionId) async {

    try {
      isLoadingCheckOut(true);

      var response = await ApiService().checkOutApi(
          cleanerCohostId.value,
          propertyId.value, // property_id
          transactionId,
          addRequirementCleanerController.selectedDate.value.toString(),
          formatTimeOfDay(addRequirementCleanerController.selectedTime.value),
          serviceId.value,
          totalPrice.value,
          bidId.value,
        "0",
          bookingPrice.value
      );

      if (response['status'] == true) {

        var data ={
          'booking_id': response['data']['id'].toString()
        };

        Get.offAllNamed(Routes.PAYMENT_SUCCESSFUL_SCREEN,parameters: data);

        ToastClass.showToast('${response['message']}',);
        isLoadingCheckOut(false);
      } else if (response['status'] == false) {
        ToastClass.showToast('${response['message']}',);
        isLoadingCheckOut(false);
        update();
      }
    } finally {
      isLoadingCheckOut(false);
      update();

    }
  }

  Future adminFee() async {
    try {

      var response = await ApiService().adminFees();

      if (response['status'] == true) {
        adminFees.value = double.parse(response['data']['admin_commission']);

        adminFeesShow.value = response['data']['admin_commission'];

        log('admin_commission --- ${adminFees.value}');
        double af = adminFees.value;

        if(addRequirementCleanerController.serviceId.value == "1" || addRequirementCleanerController.serviceId.value == "2" || addRequirementCleanerController.serviceId.value == "4"){
          double tp = double.parse(addRequirementCleanerController.totalPayment.value);
          double totalCommissionPrice = (af / 100) * tp;
          double finalTotal = tp+totalCommissionPrice;
          totalPrice.value = finalTotal.toString();
          bookingPrice.value = addRequirementCleanerController.totalPayment.value;

          totalCommisionPrice.value = totalCommissionPrice.toStringAsFixed(2).toString();
          log("Total amount admin fees: \$${totalCommisionPrice.value}");

        }else if(addRequirementCleanerController.serviceId.value == "3" || addRequirementCleanerController.serviceId.value == "6"){
          double tsp = double.parse(addRequirementCleanerController.totalSqftPrice.value);
          double totalCommissionPrice = (af / 100) * tsp;
          double finalTotal = tsp+totalCommissionPrice;
          totalPrice.value = finalTotal.toString();
          bookingPrice.value = addRequirementCleanerController.totalSqftPrice.value;

          totalCommisionPrice.value = totalCommissionPrice.toStringAsFixed(2).toString();
          log("Total amount admin fees: \$${totalCommisionPrice.value}");

        }else{
          double thp = double.parse(addRequirementCleanerController.totalHourlyPrice.value);
          double totalCommissionPrice = (af / 100) * thp;
          double finalTotal = thp+totalCommissionPrice;
          totalPrice.value = finalTotal.toString();
          bookingPrice.value = addRequirementCleanerController.totalHourlyPrice.value;

          totalCommisionPrice.value = totalCommissionPrice.toStringAsFixed(2).toString();
          log("Total amount admin fees: \$${totalCommisionPrice.value}");

        }


      } else if (response['status'] == false) {
        update();
      }
    } finally {
      update();

    }
  }


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
