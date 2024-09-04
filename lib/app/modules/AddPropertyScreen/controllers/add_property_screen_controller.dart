import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:power_maids/GoogleMap/google_map_and_places.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/modules/AddRequirementCleaner/sqr_feel_model.dart';
import 'package:power_maids/app/modules/AddRequirementCreateBid/property_list.dart';


class AddPropertyScreenController extends GetxController {
  //TODO: Implement AddPropertyScreenController

  TextEditingController propertyNameController = TextEditingController();
  TextEditingController propertyNameUpdateController = TextEditingController();

  final show = false.obs;

  final propertySizeSqrFeet = ''.obs;

  final count = 0.obs;
  final isChecked = false.obs;
  final isLoadingGetProperty = false.obs;
  final isLoadingAddProperty = false.obs;
  final isLoadingUpdateProperty = false.obs;
  final isLoadingRemoveProperty = false.obs;
  final isLoading = false.obs;
  final propertyId = "".obs;

  final GoogleMapServiceController googleMapService = Get.put(GoogleMapServiceController());

  var propertyList = <PropertyListModel>[].obs;
  var sqrFeetList = <SqrFeelModel>[].obs;
  Rx<String?> propertySize = Rx<String?>(null);
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

  propertyListApi() async {
    propertyList.clear();
    try {
      isLoadingGetProperty(true);

      var response = await ApiService().customerPropertyListt();

      if (response['status'] == true) {
        isLoadingGetProperty(false);

        List dataList = response['data'].toList();
        propertyList.value =
            dataList.map((json) => PropertyListModel.fromJson(json)).toList();

        update();
      } else if (response['status'] == false) {
        isLoadingGetProperty(false);
        update();
      }
    } finally {
      isLoadingGetProperty(false);
      update();
    }
  }
  void clearFields(){
    googleMapService.latitude.value = '';
    googleMapService.longitude.value = '';
    googleMapService.addressController.value.text = '';
    propertyNameController.clear();
    propertySize.value = null;
    propertySizeId.value = null;
  }


  Future addProperty() async {
    try {
      isLoadingAddProperty(true);

      log('addProperty----------------');
      var response = await ApiService().addPropertyAPI(address: googleMapService.addressController.value.text.toString(), name: propertyNameController.text.toString(), latitude: googleMapService.latitude.value.toString(), longitude: googleMapService.longitude.value.toString(), propertySize: propertySize.toString());

      if (response['status'] == true) {
        googleMapService.latitude.value = '';
        googleMapService.longitude.value = '';
        googleMapService.addressController.value.text = '';
        propertyNameController.clear();
         propertySize.value == null;
        propertySizeId.value == "";
        print("jhjhjh${propertySizeId}");
        print("jhjhjh${propertySize}");

        propertyListApi();
        log('intro----------------$response');
      } else if (response['status'] == false) {
        isLoadingAddProperty(false);
      }
    } finally {
      isLoadingAddProperty(false);
    }
  }

  Future updateProperty({propertyId}) async {
    try {
      isLoadingUpdateProperty(true);

      log('updateProperty----------------');
      var response = await ApiService().updatePropertyAPI( propertyId: propertyId.toString(),address: googleMapService.addressController.value.text.toString(), name: propertyNameUpdateController.text.toString(), latitude: googleMapService.latitude.value.toString(), longitude: googleMapService.longitude.value.toString(), propertySize: propertySize.toString());

      if (response['status'] == true) {
        propertyListApi();
        log('intro----------------$response');
      } else if (response['status'] == false) {
        isLoadingUpdateProperty(false);
      }
    } finally {
      isLoadingUpdateProperty(false);
    }
  }

  Future removeProperty({propertyId, index}) async {
    try {
      isLoadingRemoveProperty(true);

      log('removeProperty----------------');
      var response = await ApiService().removePropertyAPI( propertyId: propertyId.toString(),);

      if (response['status'] == true) {
        propertyList.removeAt(index);
      //  propertyListApi();
        log('intro----------------$response');
      } else if (response['status'] == false) {
        isLoadingRemoveProperty(false);
      }
    } finally {
      isLoadingRemoveProperty(false);
    }
  }

  @override
  void onInit() {
    propertyListApi();
    squareFeetListApi();

    super.onInit();
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
