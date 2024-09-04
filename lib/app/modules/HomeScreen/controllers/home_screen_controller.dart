

import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:power_maids/GoogleMap/google_map_and_places.dart';
import 'package:power_maids/app/modules/CreateBidForCleanerAndCohost/model/service_list_model.dart';
import 'package:power_maids/app/modules/HomeScreen/home_models.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Utils/api_service.dart';

class HomeScreenController extends GetxController {
  //TODO: Implement HomeScreenController
  RefreshController refreshController = RefreshController(initialRefresh: false);

  final GoogleMapServiceController googleMapService = Get.put(GoogleMapServiceController());

  // void toggleItemSelection(String item) {
  //   if (recommendedmaidname.contains(item)) {
  //     recommendedmaidname.remove(item);
  //   } else {
  //     recommendedmaidname.add(item);
  //   }
  // }
  //
  // bool isItemSelected(String item) {
  //   return recommendedmaidname.contains(item);
  // }
  //
  // final WhatAreYouLokingForList = [
  //   "assets/images/demo1.png",
  //   "assets/images/demo2.png",
  // ];
  // final WhatAreYouLokingForTittleList = [
  //   "House Keeping Office/Shops Cleanup Services",
  //   "Move out - Move In Cleaning",
  //   "One time Cleaning"
  // ];


  final count = 0.obs;
  final isLoading = false.obs;
  final isLoadingFavUnfav = false.obs;
  final firstname = ''.obs;
  final lastname = ''.obs;
  final address = ''.obs;
  final lat = ''.obs;
  final lng = ''.obs;
  final currentTime = ''.obs;
  final formattedTime = ''.obs;
  final greeting = ''.obs;

  Rx<DateTime> now = DateTime.now().obs;
  LocationData? _currentLocation;

  @override
  void onInit() {
    super.onInit();
    getData();
    fetchAndMergeServiceList(serviceFor1: "1",serviceFor2: "2");
    // fatchServiceList("1");
    //  fatchServiceListt("2");
    nearByMaidApi();
    recommendedListApi();
  }

  refrshApi()async{
    await getData();
    fetchAndMergeServiceList(serviceFor1: "1",serviceFor2: "2");
    await nearByMaidApi();
    await recommendedListApi();
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();
     firstname.value = prefs.getString('firstname')!;
     lastname.value = prefs.getString('lastname')!;
     address.value = prefs.getString('address')??"";
     lat.value = prefs.getString('lat')??"";
     lng.value = prefs.getString('lng')??"";
     address.value = prefs.getString('address')??"";

    if(address.value.isEmpty){
      await googleMapService.getCurrentLocation();
      address.value = googleMapService.addressController.value.text;
      lat.value = googleMapService.latitude.value.toString();
      lng.value = googleMapService.longitude.value.toString();
    }


    log("latitude home  = ${lat.value}, longitude = ${lng.value}");

     formattedTime.value = DateFormat('hh:mm a').format(now.value);

    int hour = now.value.hour;

    if (hour >= 12 && hour < 16) {
      greeting.value = 'Good Afternoon';
    } else if (hour >= 16 && hour <= 23) {
      greeting.value = 'Good Evening';
    } else {
      greeting.value = 'Good Morning';
    }

     log("formattedTime = = = =  = ${greeting}");
  }



  String getLocationString(LocationData locationData) {
    if (locationData == null) {
      return "Location not available";
    } else {
      double? latitude = locationData.latitude;
      double? longitude = locationData.longitude;
      return "$latitude, $longitude";
    }
  }


  final serviceList = <ServicesListModel>[].obs;


  Future fatchServiceList(serviceFor) async {
  //  serviceList.clear();
    try {

      isLoading(true);

      var response = await ApiService().serviceListApi(serviceFor);

      if (response['status'] == true) {

        List dataList = response['data'].toList();
        serviceList.value = dataList.map((json) => ServicesListModel.fromJson(json)).toList();
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
  Future fatchServiceListt(serviceFor) async {
   // serviceList.clear();
    try {
      isLoading(true);

      var response = await ApiService().serviceListApi(serviceFor);

      if (response['status'] == true) {

        List dataList = response['data'].toList();
        serviceList.value = dataList.map((json) => ServicesListModel.fromJson(json)).toList();

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

  Future<void> fetchAndMergeServiceList({required String serviceFor1, required String serviceFor2}) async {
    try {
      isLoading(true);

      // Clear the list before fetching new data
      serviceList.clear();
      print("serviceList cleared. Current length: ${serviceList.length}");

      // Use a Map to ensure uniqueness based on ID
      Map<String, ServicesListModel> serviceMap = {};

      // Function to process API response and store items in the map
      void processApiResponse(List dataList) {
        for (var item in dataList) {
          var service = ServicesListModel.fromJson(item);
          serviceMap[service.id.toString()] = service;
        }
      }

      // Fetch data from the first API
      var response1 = await ApiService().serviceListApi(serviceFor1);
      if (response1['status'] == true) {
        List dataList1 = response1['data'].toList();
        print("Data from API 1: ${dataList1.length} items.");
        processApiResponse(dataList1);
      }


      // Fetch data from the second API
      var response2 = await ApiService().serviceListApi(serviceFor2);
      if (response2['status'] == true) {
        List dataList2 = response2['data'].toList();
        print("Data from API 2: ${dataList2.length} items.");
        processApiResponse(dataList2);
      }

      // Convert the map back to a list and update the observable
      serviceList.value = serviceMap.values.toList();
    //  serviceList.refresh(); // Explicitly refresh the list

      print("Final merged list length: ${serviceList.length}");

      update(); // Notify the UI of the data changes
    } finally {
      isLoading(false);
      update();
    }
  }



  // Future<void> fetchAndMergeServiceList({required String serviceFor1, required String serviceFor2}) async {
  //   try {
  //     isLoading(true);
  //
  //     // Clear the list before fetching new data
  //     serviceList.clear();
  //     print("serviceList cleared. Current length: ${serviceList.length}");
  //
  //     // Use a Map to ensure uniqueness based on ID
  //     Map<String, ServicesListModel> serviceMap = {};
  //
  //     // Function to process API response and store items in the map
  //     void processApiResponse(List dataList) {
  //       for (var item in dataList) {
  //         var service = ServicesListModel.fromJson(item);
  //         serviceMap[service.id.toString()] = service;
  //       }
  //     }
  //
  //     // Fetch data from the first API
  //     var response1 = await ApiService().serviceListApi(serviceFor1);
  //     if (response1['status'] == true) {
  //       List dataList1 = response1['data'].toList();
  //       print("Data from API 1: ${dataList1.length} items.");
  //       processApiResponse(dataList1);
  //       update();
  //
  //     }
  //
  //     // Fetch data from the second API
  //     var response2 = await ApiService().serviceListApi(serviceFor2);
  //     if (response2['status'] == true) {
  //       List dataList2 = response2['data'].toList();
  //       print("Data from API 2: ${dataList2.length} items.");
  //       processApiResponse(dataList2);
  //       update();
  //
  //     }
  //
  //
  //     // Convert the map back to a list
  //     serviceList.value = serviceMap.values.toList();
  //
  //     print("Final merged list length: ${serviceList.length}");
  //
  //     update(); // Notify the UI of the data changes
  //   } finally {
  //     isLoading(false);
  //     update();
  //   }
  // }







  final nearByMaid = <NearByListModel>[].obs;
  Future nearByMaidApi() async {
    nearByMaid.clear();
    try {
      isLoading(true);

      log("Near-- by-- maid");


      var response = await ApiService().nearByMaidApi();

      if (response['status'] == true) {

        List dataList = response['data'].toList();
        nearByMaid.value = dataList.map((json) => NearByListModel.fromJson(json)).toList();

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

  final recommendedList = <RecommendedListModel>[].obs;
  Future recommendedListApi() async {
    recommendedList.clear();
    try {
      isLoading(true);

      var response = await ApiService().recommendedListApi();

      if (response['status'] == true) {


        List dataList = response['data'].toList();
        recommendedList.value = dataList.map((json) => RecommendedListModel.fromJson(json)).toList();

        for (var item in recommendedList) {
          isFavorite[item.id.toString()] = item.isFavorite == 1;
        }

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

  // final recommended_list = <RecommendedListModel>[].obs;
  // Future Faviourite_Unfaviourite(cleaner_co_host_id) async {
  //   try {
  //     isLoading(true);
  //
  //     var response = await ApiService().Favorite_Unfavorite(cleaner_co_host_id);
  //
  //     if (response['status'] == true) {
  //
  //       Recommended_List_Api();
  //       update();
  //       isLoading(false);
  //     } else if (response['status'] == false) {
  //
  //       isLoading(false);
  //       update();
  //     }
  //   } finally {
  //     isLoading(false);
  //     update();
  //   }
  // }

  var isFavorite = <String, bool>{}.obs; // Maintain favorite status per item


  Future<void> toggleFavorite(String id) async {
    // Update the UI immediately
    isFavorite[id] = !isFavorite[id]!;
    update();

    try {
      isLoadingFavUnfav(true);
      var response = await ApiService().favoriteUnfavoriteApi(id);

      if (response['status'] == true) {
       //       await Recommended_List_Api();
      }
    } finally {
      isLoadingFavUnfav(false);
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
