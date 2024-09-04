import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/GoogleMap/google_map_and_places.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/app/modules/AddRequirementCleaner/sqr_feel_model.dart';
import 'package:power_maids/app/modules/MaidDetails/model/details_model.dart';
import 'package:power_maids/app/routes/app_pages.dart';

import '../../AddRequirementCreateBid/property_list.dart';


class AddRequirementCleanerController extends GetxController {
  //TODO: Implement AddRequirementCleanerController

  final  nameTextController = TextEditingController().obs;
  // final TextEditingController addressTextController = TextEditingController();
  final TextEditingController needsTextController = TextEditingController();
  final TextEditingController hourQtyController = TextEditingController();

  final GoogleMapServiceController googleMapService = Get.put(GoogleMapServiceController());

  final count = 0.obs;
  final isChecked = false.obs;
  final isSwitched = false.obs; // "obs" makes it observable
  final isSwitchedProvide = false.obs; // "obs" makes it observable
  final title = "".obs;
  final id = "".obs;

  final selectServiceStandardDeep = "0".obs;
  final selectServiceWeeklyHourly = "0".obs;
  final selectServiceWeeklySqrFeel = "0".obs;

  final washTowels = '0'.obs;
  final cleanerSupplies = '0'.obs;
  final bedroomCount = "0".obs;




  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
//  Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;
  Rx<TimeOfDay?> selectedTime = Rx<TimeOfDay?>(null);

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate:DateTime.now(),
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

    if (picked != null) {
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

  final serviceTypeList = ["Standard", "Deep"];
  final serviceTypeListPerHour = ["Weekly", "Bi Weekly", "Monthly"].obs;

  void toggleSwitch() {
    isSwitched.toggle();
  }

  void toggleSwitchone() {
    isSwitchedProvide.toggle();
  }

  final isLoading = false.obs;
  final isLoadingPropertyAdd = false.obs;
  final serviceId = "".obs;
  final serviceName = "".obs;
  final userType = "".obs;
  final zipCode = "".obs;
  final cleanerCohostId = "".obs;
  final show = false.obs;
  final show2 = false.obs;

  // final ItemModel serviceList = Get.arguments;

  final bedroomQty = 0.obs;
  final bathroomQty = 0.obs;
  final perHourQty = 0.obs;

  // hourly price
  final hourQty = "".obs;
  final totalHourlyPrice = "".obs;
  final actualHourlyPrice = "".obs;

  // squer feet

  final propertySizeSqrFeet = ''.obs;
  final totalSqftPrice = ''.obs;
  final sQft = ''.obs;

  final serviceLableId = [].obs;
  final serviceTitleList = [].obs;
  final serviceQtyList = [].obs;
  final serviceTotalPriceList = [].obs;
  final serviceActualPrice = [].obs;
  final totalPayment = "".obs;

  validationSD(context) {
    isLoadingPropertyAdd(true);
    if (nameTextController.value.text.isEmpty) {
      isLoadingPropertyAdd(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please enter your property name",color: Colors.white,)),
      ));
    } else if (googleMapService.addressController.value.text.isEmpty) {
      isLoadingPropertyAdd(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please enter property address",color: Colors.white,)),
      ));
    } else if (propertySizeSQFT.value == null) {
      isLoadingPropertyAdd(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please select property size",color: Colors.white,)),
      ));
    }else if (selectedDate.value == null) {
      isLoadingPropertyAdd(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please select date",color: Colors.white,)),
      ));
    } else if (selectedTime.value == null) {
      isLoadingPropertyAdd(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please enter your password",color: Colors.white,)),
      ));
    } else if(needsTextController.text.isEmpty){
      isLoadingPropertyAdd(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please describe your needs",color: Colors.white,)),
      ));
    }else if(serviceLableId.isEmpty){
      isLoadingPropertyAdd(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please select services",color: Colors.white,)),
      ));
    } else {

      if(serviceId.value == "1" || serviceId.value == "2" || serviceId.value == "4"){
        var total = 0;
        for(int i=0; i<serviceTotalPriceList.length;i++){
          total = serviceTotalPriceList[i]+total;
        }
        totalPayment.value = total.toString();
      }else{
        // for cohost and othet services
      }

      isLoadingPropertyAdd(false);
      var data = {
        "title": title.value.toString(),
        "id": id.value.toString(),
        "zip_code": zipCode.toString(),
        "user_type":userType.value.toString(),
        "cleaner_cohost_id":cleanerCohostId.value.toString(),
        "service_id":serviceId.value.toString(),
        "service_name":serviceName.value.toString(),
      };
      Get.toNamed(Routes.EXTRAWORK_ADD_SCREEN, parameters: data);
    }
  }
  validationHourly(context) {
    isLoadingPropertyAdd(true);
    if (nameTextController.value.text.isEmpty) {
      isLoadingPropertyAdd(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please enter your property name",color: Colors.white,)),
      ));
    } else if (googleMapService.addressController.value.text.isEmpty) {
      isLoadingPropertyAdd(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please enter property address",color: Colors.white,)),
      ));
    } else if (propertySizeSQFT.value == null) {
      isLoadingPropertyAdd(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please select property size",color: Colors.white,)),
      ));
    }else if (selectedDate.value == null) {
      isLoadingPropertyAdd(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please select date",color: Colors.white,)),
      ));
    } else if (selectedTime.value == null) {
      isLoadingPropertyAdd(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please enter your password",color: Colors.white,)),
      ));
    } else if(needsTextController.text.isEmpty){
      isLoadingPropertyAdd(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please describe your needs",color: Colors.white,)),
      ));
    }else if(hourQty.isEmpty){
      isLoadingPropertyAdd(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please enter hours",color: Colors.white,)),
      ));
    } else {
      isLoadingPropertyAdd(false);
      var data = {
        "title": title.value.toString(),
        "id": id.value.toString(),
        "zip_code": zipCode.toString(),
        "user_type":userType.value.toString(),
        "cleaner_cohost_id":cleanerCohostId.value.toString(),
        "service_id":serviceId.value.toString(),
        "service_name":serviceName.value.toString(),
      };
      Get.toNamed(Routes.EXTRAWORK_ADD_SCREEN, parameters: data);
    }
  }
  validationSquerFeet(context) {
    isLoadingPropertyAdd(true);
    if (nameTextController.value.text.isEmpty) {
      isLoadingPropertyAdd(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please enter your property name",color: Colors.white,)),
      ));
    } else if (googleMapService.addressController.value.text.isEmpty) {
      isLoadingPropertyAdd(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please enter property address",color: Colors.white,)),
      ));
    } else if (propertySizeSQFT.value == null) {
      isLoadingPropertyAdd(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please select property size",color: Colors.white,)),
      ));
    }else if (selectedDate.value == null) {
      isLoadingPropertyAdd(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please select date",color: Colors.white,)),
      ));
    } else if (selectedTime.value == null) {
      isLoadingPropertyAdd(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please enter your password",color: Colors.white,)),
      ));
    } else if(needsTextController.text.isEmpty){
      isLoadingPropertyAdd(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please describe your needs",color: Colors.white,)),
      ));
    }else if(sQft.isEmpty){
      isLoadingPropertyAdd(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 1),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: AppStyles.appThemeColor,
        content: Center(child: Textwidget(text: "Please select property size",color: Colors.white,)),
      ));
    } else {
      isLoadingPropertyAdd(false);
      var data = {
        // "title": title.value.toString(),
        // "id": id.value.toString(),
        "zip_code": zipCode.toString(),
        "user_type":userType.value.toString(),
        "cleaner_cohost_id":cleanerCohostId.value.toString(),
        "service_id":serviceId.value.toString(),
        "service_name":serviceName.value.toString(),
      };
      Get.toNamed(Routes.EXTRAWORK_ADD_SCREEN, parameters: data);
    }
  }


  @override
  void onInit() {
    title.value = Get.parameters['title'] ?? "";
    id.value = Get.parameters['id'] ?? "";
    zipCode.value = Get.parameters['zip_code']!;
    cleanerCohostId.value = Get.parameters['cleaner_cohost_id']!;
    userType.value = Get.parameters['user_type']!;
    serviceId.value = Get.parameters['service_id']!;
    serviceName.value = Get.parameters['service_name']!;
    super.onInit();
    onInitCall();
    propertyListApi();
    squareFeetListApi();
  }

  onInitCall()async{
    if(serviceId.value == "1" || serviceId.value == "2" || serviceId.value == "4"){
     await serviceDetailsApi();
    }else if(serviceId.value == "3" || serviceId.value == "6"){
      await coHostServicesPriceApi();
    }else{
      await cleanerCoHostPerHourPriceApi();
    }
  }

  List<PriceLabel> parsePriceLabels(Map<String, dynamic> json) {
    List<String> ids = List<String>.from(json['price_label_id']);
    List<String> texts = List<String>.from(json['price_label_text']);
    List<String> standardPrices = List<String>.from(json['price_label_standard_price']);
    List<String> deepPrices = List<String>.from(json['price_label_deep_price']);

    List<PriceLabel> priceLabels = [];
    for (int i = 0; i < ids.length; i++) {
      priceLabels.add(
        PriceLabel(
          id: ids[i],
          text: texts[i],
          standardPrice: standardPrices[i],
          deepPrice: deepPrices[i],
        ),
      );
    }
    return priceLabels;
  }

  // Service Detail
  final serviceListDetails = <ServiceDetailsModel>[].obs;
  final priceLabels = <PriceLabel>[].obs;

  final serviceLabelQty = [].obs;
  final serviceLabelUnitPrice = [].obs;

  serviceDetailsApi() async {
    serviceListDetails.clear();
    try {
      isLoading(true);

      var response = await ApiService().serviceDetailsApi(serviceId.value,cleanerCohostId.value); // service_id,cleaner_cohost_id

      if (response['status'] == true) {
        isLoading(false);
        List dataList = response['data'].toList();
        serviceListDetails.value = dataList.map((json) => ServiceDetailsModel.fromJson(json)).toList();

        Map<String, dynamic> jsonData = {
          "price_label_id": serviceListDetails[0].priceLabelId,
          "price_label_text": serviceListDetails[0].priceLabelText,
          "price_label_standard_price": serviceListDetails[0].priceLabelStandardPrice,
          "price_label_deep_price": serviceListDetails[0].priceLabelDeepPrice
        };
        priceLabels.value = parsePriceLabels(jsonData);

        // if(service_id.value == 1 || service_id.value == 2 || service_id.value == 4){
        //   Map<String, dynamic> jsonData = {
        //     "price_label_id": service_list_details[0].priceLabelId,
        //     "price_label_text": service_list_details[0].priceLabelText,
        //     "price_label_standard_price": service_list_details[0].priceLabelStandardPrice,
        //     "price_label_deep_price": service_list_details[0].priceLabelDeepPrice
        //   };
        //   priceLabels.value = parsePriceLabels(jsonData);
        // }
        // else if(service_id.value == 3){
        //   CoHost_Services_Price_Api(cleaner_cohost_id.value);  // sqr feet
        // }else{
        //   Cleaner_CoHost_Per_HourPrice_Api(cleaner_cohost_id.value);  // per hour
        // }

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

  // Service  -- Office Space/Shops  (sq ft)
  final weeklyList = <BiWeekly>[].obs;
  final biWeeklyList = <BiWeekly>[].obs;
  final monthlyList = <BiWeekly>[].obs;
  final sqFtListStatus= true.obs;
  Future coHostServicesPriceApi() async {
    weeklyList.clear();
    biWeeklyList.clear();
    monthlyList.clear();
    try {
      isLoading(true);

      var response = await ApiService().coHostServicesPriceApi(cleanerCohostId.value,id.value == "0"?"1":"2");

      if (response['status'] == true) {


        if (response['data']['1'] != null) {
          List wlist = response['data']['1'].toList();
          weeklyList.value =    wlist.map((json) => BiWeekly.fromJson(json)).toList();
        }

        if (response['data']['2'] != null) {
          List blist = response['data']['2'].toList();
          biWeeklyList.value =   blist.map((json) => BiWeekly.fromJson(json)).toList();
        }

        if (response['data']['3'] != null) {
          List mlist = response['data']['3'].toList();
          monthlyList.value =   mlist.map((json) => BiWeekly.fromJson(json)).toList();
        }



        // List blist = response['data']['bi_weekly'].toList();
        // bi_weekly_list.value = await blist.map((json) => BiWeekly.fromJson(json)).toList();
        //
        // List mlist = response['data']['monthly'].toList();
        // monthly_list.value = await mlist.map((json) => BiWeekly.fromJson(json)).toList();

        update();
        isLoading(false);
      } else if (response['status'] == false) {
        sqFtListStatus.value = false;
        isLoading(false);
        update();
      }
    } finally {
      isLoading(false);
      update();
    }
  }

  // Service  -- Misc. (Home Org/Cooking/Laundry) (Hourly)
  final weeklyListH = <BiWeeklyPrice>[].obs;
  final biWeeklyListH = <BiWeeklyPrice>[].obs;
  final monthlyListH = <BiWeeklyPrice>[].obs;
  final houryListStatus = true.obs;
  Future cleanerCoHostPerHourPriceApi() async {
    weeklyListH.clear();
    biWeeklyListH.clear();
    monthlyListH.clear();
    try {
      isLoading(true);

      var response = await ApiService().cleanerCoHostPerHourPriceApi(cleanerCohostId.value);

      if (response['status'] == true) {


        List wlist = response['data']['weekly'].toList();
        weeklyListH.value = wlist.map((json) => BiWeeklyPrice.fromJson(json)).toList();

        List blist = response['data']['bi-weekly'].toList();
        biWeeklyListH.value = blist.map((json) => BiWeeklyPrice.fromJson(json)).toList();

        List mlist = response['data']['monthly'].toList();
        monthlyListH.value = mlist.map((json) => BiWeeklyPrice.fromJson(json)).toList();

        update();
        isLoading(false);
      } else if (response['status'] == false) {
        houryListStatus.value = false;
        isLoading(false);
        update();
      }
    } finally {
      isLoading(false);
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
