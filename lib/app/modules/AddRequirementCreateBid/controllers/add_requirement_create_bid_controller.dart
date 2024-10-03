import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:power_maids/GoogleMap/google_map_and_places.dart';
import 'package:power_maids/Utils/ShowToast.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/app/modules/AddRequirementCleaner/sqr_feel_model.dart';
import 'package:power_maids/app/modules/CreateBidForCleanerAndCohost/model/service_list_model.dart';
import 'package:power_maids/app/routes/app_pages.dart';

import '../property_list.dart';


class AddRequirementCreateBidController extends GetxController {
  //TODO: Implement AddRequirementCreateBidController
  final  nameTextController = TextEditingController().obs;
  // final TextEditingController addressTextController = TextEditingController();
  final TextEditingController needsTextController = TextEditingController();
  final GoogleMapServiceController googleMapService = Get.put(GoogleMapServiceController());

  final count = 0.obs;

  final isChecked = false.obs;
  // final isSwitched = false.obs; // "obs" makes it observable
  // final isSwitchedprovide = false.obs; // "obs" makes it observable
  final title = "".obs;
  final id = "".obs;

  final selectedBid = 0.obs;
  final isLoading= false.obs;

  void selectIndex(int index) {
    selectedBid.value = index;
  }



  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  Rx<TimeOfDay?> selectedTime = Rx<TimeOfDay?>(null);

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppStyles.appThemeColor, // <-- SEE HERE
                  onPrimary: Colors.white, // <-- SEE HERE
                  onSurface: Colors.black, // <-- SEE HERE
                  background: Colors.white,
                ),
              ),
              child: child!);
        });

    if (picked != null && picked != selectedDate.value) {
      selectedDate(picked);
    }
  }
  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppStyles.appThemeColor, // <-- SEE HERE
                  onPrimary: Colors.white, // <-- SEE HERE
                  onSurface: Colors.black, // <-- SEE HERE
                  background: Colors.white,
                  onSecondary: Colors.white,
                  onBackground: Colors.white,
                  secondary: AppStyles.appThemeColor,
                ),
              ),
              child: child!);
        });

    if (picked != null && picked != selectedTime.value) {
      selectedTime(picked);
    }
  }

  String? formatTimeOfDay(TimeOfDay? timeOfDay) {
    if (timeOfDay == null) return null;

    int hour = timeOfDay.hour;
    final minute = timeOfDay.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';

    if (hour == 0) {
      hour = 12; // Midnight case
    } else if (hour > 12) {
      hour -= 12; // Convert to 12-hour format
    }

    final formattedHour = hour.toString().padLeft(2, '0');
    return '$formattedHour:$minute $period';
  }

  void updateDate(String dateString) {
    try {
      DateFormat format = DateFormat("dd-MM-yyyy");
      DateTime date = format.parse(dateString);
      selectedDate.value = date;
    } catch (e) {
      log("Error parsing date: $e");
    }
  }

  // String formatDate(DateTime? date) {
  //   if (date == null) {
  //     return 'No date selected';
  //   } else {
  //     return DateFormat("dd-MM-yyyy").format(date);
  //   }
  // }


  // void toggleSwitch() {
  //   isSwitched.toggle();
  // }
  //
  // void toggleSwitchone() {
  //   isSwitchedprovide.toggle();
  // }


  // Rx<String?> selectedValue = Rx<String?>(null);
  //
  // List<String> options = [
  //   "Under 1000 sq. ft",
  //   "Under 2000 sq. ft",
  //   "Under 3000 sq. ft",
  //   "Under 7000 sq. ft",
  //   "Under 10000 sq. ft",
  // ];

  validation(context) {
    if (nameTextController.value.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration:  const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please enter name",color: Colors.white,)),
      ));
    } else if (googleMapService.addressController.value.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please enter address",color: Colors.white,)),
      ));
    } else if (propertySizeSQFT.value == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please select your property",color: Colors.white,)),
      ));
    }else if (selectedDate.value == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please select date",color: Colors.white,)),
      ));
    } else if (selectedTime.value == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please select time",color: Colors.white,)),
      ));
    }else if (needsTextController.value.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please describe your cleaning needs",color: Colors.white,)),
      ));
    } else {
      customerPropertyAddApi();
    }
  }

  final selectedServiceTypeId = "".obs;
  final serviceId = "".obs;
  final serviceName = "".obs;
  final userType = "".obs;
  final zipCode = "".obs;
  final show = false.obs;
  final show2 = false.obs;

  @override
  void onInit() {
    userType.value = Get.parameters['user_type']!;
    zipCode.value = Get.parameters['zip_code']!;
    serviceId.value = Get.parameters['service_id']!;
    serviceName.value = Get.parameters['service_name']!;
    super.onInit();
    serviceListApi();
    propertyListApi();
    squareFeetListApi();
  }

  var sqrFeetList = <SqrFeelModel>[].obs;
  Rx<String?> propertySizeSQFT = Rx<String?>(null);
  Rx<String?> propertySizeId = Rx<String?>(null);
  squareFeetListApi() async {
    sqrFeetList.clear();
    try {
      isLoading(true);

      var response = await ApiService().squareFeetListApi();

      if (response['status'] == true) {
        isLoading(false);

        List dataList = response['data'].toList();
        sqrFeetList.value = dataList.map((json) => SqrFeelModel.fromJson(json)).toList();
        show.value = false;

        update();

      } else if (response['status'] == false) {

        isLoading(false);
        update();
      }
    } finally {
      isLoading(false);
      update();
    }
  }

  var propertyList = <PropertyListModel>[].obs;
  Rx<String?> propertySizeSQFT_pro = Rx<String?>(null);
  Rx<String?> selectPropertyId = Rx<String?>(null);
  propertyListApi() async {
    propertyList.clear();
    try {
      isLoading(true);

      var response = await ApiService().customerPropertyListt();

      if (response['status'] == true) {
        isLoading(false);

        List dataList = response['data'].toList();
        propertyList.value = dataList.map((json) => PropertyListModel.fromJson(json)).toList();
        show2.value = false;
        show.value = false;

        update();

      } else if (response['status'] == false) {

        isLoading(false);
        update();
      }
    } finally {
      isLoading(false);
      update();
    }
  }

  final serviceTypeList = <ServicesTypeModel>[].obs;
  Future serviceListApi() async {
    serviceTypeList.clear();
    try {
      isLoading(true);

      var response = await ApiService().serviceTypeApi();

      if (response['status'] == true) {

        List dataList = response['data'].toList();
        serviceTypeList.value = dataList.map((json) => ServicesTypeModel.fromJson(json)).toList();

        update();
        isLoading(false);
      } else if (response['status'] == false) {

        isLoading(false);
        update();
      }
    } finally {
      isLoading(false);
      update();

    }
  }

  customerPropertyAddApi() async {
    try {
      isLoading(true);
      var response = await ApiService().customerPropertyAddApi(
          nameTextController.value.text,
        googleMapService.addressController.value.text,
        propertySizeSQFT.value,
          "0",
          selectedDate.value.toString(),
          formatTimeOfDay(selectedTime.value),
          needsTextController.text,
          userType.value,
           zipCode.value,
          serviceId.value,
          "1",
        googleMapService.latitude.toString(),
        googleMapService.longitude.toString(),
        selectPropertyId.value??""
      );
      if (response['status'] == true) {

        ToastClass.showToast('${response['message']}',);

        googleMapService.latitude.value = '';
        googleMapService.longitude.value = '';
        googleMapService.addressController.value.text = '';

        var data = {
          "property_id":response['data']['id'].toString(),
          "service_name":serviceName.value,
        };

        Get.offNamed(Routes.CREATE_BID_SUMMARY,parameters: data);

        isLoading(false);

      } else if (response['status'] == false) {
        ToastClass.showToast('${response['message']}',);
        isLoading(false);
      }

    } finally {

      isLoading(false);

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
