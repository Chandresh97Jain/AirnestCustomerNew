import 'dart:developer';

import 'package:get/get.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/modules/MaidDetails/model/details_model.dart';


class MaidDetailsController extends GetxController {
  //TODO: Implement MaidDetailsController

  final count = 0.obs;
  final isChecked = false.obs;

  final id = "".obs;
  final title = "".obs;
  final cleanerCohostId = ''.obs;
  final userType = "".obs;
  final serviceId = "".obs;
  final address = "".obs;
  final serviceName = "".obs;


  final isLoading = false.obs;
  final customTileExpanded = false.obs;
  final isSelectService = false.obs;


  @override
  void onInit() {

    isSelectService.value = Get.arguments??false;

    id.value = Get.parameters['id']??"";
    title.value = Get.parameters['title']??"";
    address.value = Get.parameters['address']??"";
    cleanerCohostId.value = Get.parameters['cleaner_cohost_id']??"";
    userType.value = Get.parameters['user_type']??"";
    serviceId.value = Get.parameters['service_id']??"";
    serviceName.value = Get.parameters['service_name']??"";
    cleanerPhotosListApi(cleanerCohostId.value);
    cleanerCoHostDetailsApi(cleanerCohostId.value);


    super.onInit();
  }

  // Photos array
  final photoList = <PhotoListModel>[].obs;
  cleanerPhotosListApi(cleanerCohostId) async {


    photoList.clear();
    try {
      isLoading(true);

      var response = await ApiService().servicePhotoList(cleanerCohostId); // service_id,cleaner_cohost_id
      if (response['status'] == true) {
        isLoading(false);
        List dataList = response['data'].toList();
        photoList.value = dataList.map((json) => PhotoListModel.fromJson(json)).toList();

        log("photoList === ${photoList.length}");

        update();

      } else if (response['status'] == false) {
        log("photoList === ${photoList.length}");
        isLoading(false);
        update();
      }
    } finally {
      isLoading(false);
      update();
    }
  }

  // Basic details and common services
  final details = <DetailsModel>[].obs;
  final basicDetails = {}.obs;
  final about = ''.obs;
  final bgImage = ''.obs;
  final profileImage = ''.obs;
  final cleanerCoHostName = ''.obs;
  final rating = 0.0.obs;
  final reviewListt = <ReviewList>[].obs;
  final serviceList = <ServiceTestModel>[].obs;
  final serviceNameArray = [].obs;
  final serviceIdArray = [].obs;
  final standardArray1 = <Standard>[].obs;
  final deepArray1 = <Deep>[].obs;
  final standardArray2 = <Standard>[].obs;
  final deepArray2 = <Deep>[].obs;
  final standardArray4 = <Standard>[].obs;
  final deepArray4 = <Deep>[].obs;

  Future cleanerCoHostDetailsApi(cleanerCohostId) async {
    details.clear();
    serviceList.clear();
    reviewListt.clear();
    serviceNameArray.clear();
    serviceIdArray.clear();
    try {
      isLoading(true);

      var response = await ApiService().cleanerCoHostDetailsApi(cleanerCohostId);

      if (response['status'] == true) {

        // Basic Details
        List dataList = response['data'].toList();
        details.value = dataList.map((json) => DetailsModel.fromJson(json)).toList();

        var rat;
        rat =   details[0].toJson();
        rating.value =   double.parse(rat['rating']);
        basicDetails.value =   details[0].toJson(); // Assuming toJson() method is available to convert PropertySummaryModel to a map.
        cleanerCoHostName.value = (basicDetails['firstname']+' '+basicDetails['lastname']);
        profileImage.value = basicDetails['avatar'];
     //   bgImage.value = basicDetails['bgimage'];

        log("Cleaner email -uuu----------- $basicDetails");
        log("Cleaner details -uuu----------- $response");

        // About Details
        about.value = response['about']['about']??"";
        bgImage.value = response['bgimage'] ?? "";

        print("bgImage-//--$bgImage");




        // Review Details
        List reviewList = response['review'].toList();
        reviewListt.value = reviewList.map((json) => ReviewList.fromJson(json)).toList();


        List ser = response['service'].toList();
        serviceList.value = ser.map((json) => ServiceTestModel.fromJson(json)).toList();

        for(int i=0;i<serviceList.length;i++){
          isLoading(false);

          print(" role --- ${id.value}");

          if(id.value == "0"){   //   role 0 = for cleaner

            print("👉🏻👉🏻👉🏻👉🏻👉🏻👉🏻👉🏻👉🏻👉🏻👉🏻 Cleaner ");
            serviceNameArray.add(serviceList[i].title);
            serviceIdArray.add(serviceList[i].serviceId);

            if(serviceList[i].serviceId == 1 || serviceList[i].serviceId == 2 || serviceList[i].serviceId == 4){

              if(serviceList[i].serviceId == 1){
                List s_list =  ser[i][serviceList[i].title]['Standard'].toList();
                standardArray1.value = s_list.map((json) => Standard.fromJson(json)).toList();
                List d_list =  ser[i][serviceList[i].title]['Deep'].toList();
                deepArray1.value = d_list.map((json) => Deep.fromJson(json)).toList();

              }else if(serviceList[i].serviceId == 2){
                List s_list =  ser[i][serviceList[i].title]['Standard'].toList();
                standardArray2.value = s_list.map((json) => Standard.fromJson(json)).toList();
                List d_list =  ser[i][serviceList[i].title]['Deep'].toList();
                deepArray2.value = d_list.map((json) => Deep.fromJson(json)).toList();
              }else{
                List s_list =  ser[i][serviceList[i].title]['Standard'].toList();
                standardArray4.value = s_list.map((json) => Standard.fromJson(json)).toList();
                List d_list =  ser[i][serviceList[i].title]['Deep'].toList();
                deepArray4.value = d_list.map((json) => Deep.fromJson(json)).toList();
              }



            } else if(serviceList[i].serviceId == 3){     // office space - sqr feet
              await coHostServicesPriceApi(cleanerCohostId);
            } else{       // else -  service_list[i].serviceId == 5
              await cleanerCoHostPerHourPriceApi(cleanerCohostId);
            }
          }else{
            log("👉🏻👉🏻👉🏻👉🏻👉🏻👉🏻👉🏻👉🏻👉🏻👉🏻 Co Host ");

            serviceNameArray.add(serviceList[i].title);
            serviceIdArray.add(serviceList[i].serviceId);
            await coHostServicesPriceApi(cleanerCohostId);  //  sqr feet
          }

        }

        update();
        // isLoading(false);
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

  Future coHostServicesPriceApi(cleanerCohostId) async {
    weeklyList.clear();
    biWeeklyList.clear();
    monthlyList.clear();
    log("Jaydeppp --------------❌-----------------------------------");
    try {
      isLoading(true);

      var response = await ApiService().coHostServicesPriceApi(cleanerCohostId,id.value == "0"?"1":"2");

      if (response['status'] == true) {


        if (response['data']['1'] != null) {
          List wlist = response['data']['1'].toList();
          weeklyList.value =    wlist.map((json) => BiWeekly.fromJson(json)).toList();
        }

        if (response['data']['2'] != null) {
          List blist = response['data']['2'].toList();
          biWeeklyList.value =     blist.map((json) => BiWeekly.fromJson(json)).toList();
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
  Future cleanerCoHostPerHourPriceApi(cleanerCohostId) async {
    weeklyListH.clear();
    biWeeklyListH.clear();
    monthlyListH.clear();
    try {
      isLoading(true);

      var response = await ApiService().cleanerCoHostPerHourPriceApi(cleanerCohostId);

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
