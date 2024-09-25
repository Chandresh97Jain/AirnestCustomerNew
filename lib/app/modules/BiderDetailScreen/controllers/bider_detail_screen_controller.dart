import 'dart:developer';
import 'package:get/get.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/routes/app_pages.dart';



class BiderDetailScreenController extends GetxController {
  //TODO: Implement BiderDetailScreenController

  final count = 0.obs;

  final bidId = ''.obs;
  final cleanerId = ''.obs;
  final cleanerName = ''.obs;
  final cleanerImage = ''.obs;
  final totalPrice = ''.obs;
  final servicePrice = ''.obs;
  final address = ''.obs;
  final ratting = ''.obs;
  final review = ''.obs;
  final remoteFirebaseId = ''.obs;
  final remoteUserId = ''.obs;
  final otherUserName = ''.obs;

  final serviceId = ''.obs;
  final serviceName = ''.obs;
  final userType = ''.obs;
  final zipCode = ''.obs;
  final propertyId = ''.obs;

  final about = ''.obs;
  final location = ''.obs;
  final airWork = ''.obs;
  final platformFee = ''.obs;
  final bidDate = ''.obs;
  final bidTime = ''.obs;
  final totalPlatformFee = ''.obs;

  final isLoading = false.obs;


  @override
  void onInit() {
    bidId.value = Get.parameters['bid_id']!;
    cleanerId.value = Get.parameters['cleaner_id']!;
    cleanerName.value = Get.parameters['cleaner_name']!;
    cleanerImage.value = Get.parameters['cleaner_image']!;
    servicePrice.value = Get.parameters['price']!;
    address.value = Get.parameters['address']!;
    ratting.value = Get.parameters['ratting']!;
    review.value = Get.parameters['review']!;
    remoteFirebaseId.value = Get.parameters['remote_firebase_id']!;
    remoteUserId.value = Get.parameters['remote_user_id']!;
    otherUserName.value = Get.parameters['other_user_name']!;

    serviceId.value = Get.parameters['service_id']!;
    serviceName.value = Get.parameters['service_name']!;
    userType.value = Get.parameters['user_type']!;
    zipCode.value = Get.parameters['zip_code']!;
    propertyId.value = Get.parameters['property_id']!;

    about.value = Get.parameters['about']!;
    location.value = Get.parameters['location']!;
    airWork.value = Get.parameters['air_work']!;
    platformFee.value = Get.parameters['platform_fee']!;
    bidDate.value = Get.parameters['bid_date']!;
    bidTime.value = Get.parameters['bid_time']!;

    priceCalculation();
    super.onInit();
  }

  priceCalculation(){
    double service_price = double.parse(servicePrice.value);
    double admin_fees = double.parse(platformFee.value);

    double adminFee = (admin_fees / 100) * service_price;
    double total = service_price+adminFee;

    totalPlatformFee.value = adminFee.toString();
    totalPrice.value = total.toString();
  }

  // zip_code.value = Get.parameters['zip_code']!;
  // user_type.value = Get.parameters['user_type']!;
  // cleaner_cohost_id.value = Get.parameters['cleaner_cohost_id']!;
  // service_id.value = Get.parameters['service_id']!;
  // service_name.value = Get.parameters['service_name']!;
  // property_id.value = Get.parameters['property_id']!;
  // bid_id.value = Get.parameters['bid_id']!;


  Future acceptRejectBidRequestApi(status) async {
    try {
      isLoading(true);

      log("bid_id ----- ${bidId.value}");
      log("cleaner_id ----- ${cleanerId.value}");

      var response = await ApiService().bidRequestAcceptRejectByCustomerApi(bidId.value,cleanerId.value,status);  // status

      if (response['status'] == true) {

        if(status == "1"){

          // var total =  int.parse(totalPrice.value)+int.parse(platformFee.value);
          var data = {
            "zip_code": zipCode.value.toString(),
            "user_type": userType.value.toString(),
            "cleaner_cohost_id": cleanerId.value.toString(),
            "service_id": serviceId.value.toString(),
            "service_name": serviceName.value.toString(),
            "property_id": propertyId.value.toString(),
            "bid_id": bidId.value.toString(),
            "cleaner_name": cleanerName.value.toString(),
            "price": totalPrice.value.toString(),
            "platform_price": totalPlatformFee.value.toString(),
            "total_price": totalPrice.toString(),
            "about": about.toString(),
            "service_price": servicePrice.toString(),
            "platform_persent": platformFee.toString(),
            "bid_date" : bidDate.toString(),
            "bid_time" : bidTime.toString(),
          };
          Get.toNamed(Routes.BIDSUMMARYBOOKING,parameters: data);

        }else{
          Get.back();
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
