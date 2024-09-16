import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:power_maids/Utils/sd_constand.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;
import 'get_storage.dart';

class ApiService {

  static late final BuildContext context;

  /// Airnest Local server
  // static const baseURL = 'https://airnests.manageprojects.in/api/';
  // static const imageURL = 'https://airnests.manageprojects.in/';

  /// Airnest live server
  static const baseURL = 'https://admin.airnests.com/api/';
  static const imageURL = 'https://admin.airnests.com/';

  static const String signUp = "auth/signUp";
  static const String signIn = "auth/signIn";
  static const String termsAndConditions = "termsAndConditions";
  static const String forgotPassword = "forgotPassword";
  static const String matchOTP = "matchOTP";
  static const String updateFirebaseID = "updateFirebaseID";
  static const String changePassword = "changePassword";
  static const String logout = "logout";
  static const String customerBasicDetails = "customerBasicDetails";
  static const String serviceList = "serviceList";
  static const String findCleanerCoHost = "findCleanerCoHost";
  static const String customerPropertyAdd = "customerPropertyAdd";
  static const String serviceType = "serviceType";
  static const String customerPropertySummary = "customerPropertySummary";
  static const String cardAdd = "cardAdd";
  static const String cardList = "cardList";
  static const String bookCleanerWithProperty = "bookCleanerWithProperty";
  static const String bookCleanerForPerHour = "bookCleanerForPerHour";
  static const String bookCoHostWithProperty = "bookCoHostWithProperty";
  static const String extraServicesList = "extraServicesList";
  static const String checkOut = "checkOut";
  static const String bookingTracking = "bookingTracking";
  static const String bidByCleaner = "bidByCleaner";
  static const String bidByCleanerList = "bidByCleanerList";
  static const String bidRequestAcceptRejectByCustomer = "bidRequestAcceptRejectByCustomer";
  static const String bookingRequest = "bookingRequest";
  static const String finalBookingSummary = "finalBookingSummary";
  static const String reviewByCustomer = "reviewByCustomer";
  static const String getProfile = "getProfile";
  static const String updateProfile = "updateProfile";
  static const String updatePasswordd = "updatePassword";

  static const String cleanerCoHostDetails = "cleanerCoHostDetails";
  static const String serviceDetails = "serviceDetails";
  static const String cleanerServicesPhotoList = "cleanerServicesPhotoList";
  static const String coHostServicesPrice = "coHostServicesPrice";
  static const String cleanerCoHostPerHourPrice = "cleanerCoHostPerHourPrice";

  static const String nearByMaid = "nearByMaid";
  static const String recommendedList = "recommendedList";
  static const String favoriteUnfavorite = "favoriteUnfavorite";
  static const String favoriteUnfavoriteList = "favoriteUnfavoriteList";
  static const String blogs = "blogs";
  static const String blogDetails = "blogDetails";
  static const String squareFeetList = "squareFeetList";
  static const String getAgoraToken = "getAgoraToken";
  static const String bidRemove = "bidRemove";
  static const String removeAccountEndPoint = "removeAccount";
  static const String cardRemoveEndPoint = "cardRemove";
  static const String notificationListEndpoint = 'notificationList';
  static const String readNotificationEndpoint = 'readNotification';
  static const String adminCommission = 'admin-commission';
  static const String searchCleanerEndpoint = 'search-cleaner';
  static const String helpCenterEndpoint = 'helpCenter';
  static const String termsAndConditionsEndpoint = 'termsAndConditions';
  static const String customerPropertyList = 'customerPropertyList';
  static const String addPropertyEndpoint = 'add-property';
  static const String updatePropertyEndpoint = 'update-property';
  static const String removePropertyEndpoint = 'remove-property';




  Future signUpApi(loginType,firstname,lastname,email,password,mobile,deviceId,address,latitude,longitude) async {

    final response = await http.post(Uri.parse(baseURL + signUp),
      body: ({

        "login_type":loginType,
        "firstname":firstname,
        "lastname":lastname,
        "email":email,
        "password":password,
        "mobile":mobile,
        "device_id":deviceId,
        "invitation_code":"", // optional
        "role":"0", // 0 = Customer,1 = Cleaner,2 = Co-host
        "address":address,
        "latitude":latitude,
        "longitude":longitude,

      }),
    );

    print("Sign_Up ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);

    return convertDataToJson;
  }
  Future signInApi(loginType,email,deviceId,password) async {


    final response = await http.post(Uri.parse(baseURL + signIn),
      body: ({
        "login_type":loginType,
        "email":email,
        "device_id":deviceId,
        "password":password,
        "role":"0",
      }),
    );

    print("Sign_In ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future googleSignIn(loginType,id,deviceId,email,firstname,lastname) async {

    final response = await http.post(Uri.parse(baseURL + signIn),
      body: ({
        "login_type":loginType,
        "id":id,
        "device_id":deviceId,
        "email":email,
        "firstname":firstname,
        "lastname":lastname,
        "role":"0",
      }),
    );

    print("Sign_In ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }
  Future googleSignUp(loginType,id,deviceId,email,firstname,lastname) async {

    final response = await http.post(Uri.parse(baseURL + signUp),
      body: ({
        "login_type":loginType,
        "id":id,
        "device_id":deviceId,
        "email":email,
        "firstname":firstname,
        "lastname":lastname,
        "role":"0",
      }),
    );

    print("Sign_In ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future updateFirebaseIDAPI(firebaseId,authToken) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    //
    // var authToken = prefs.getString(SDConstant.token);

    print("Authorization token $authToken");

    final response = await http.post(Uri.parse(baseURL + updateFirebaseID),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
        body: ({"firebase_id": firebaseId}));
    var convertDataToJson = jsonDecode(response.body);
    print('updateFirebaseID-----------------------------$convertDataToJson');
    return convertDataToJson;
  }


  Future termsAndConditionsApi() async {

    final response = await http.post(Uri.parse(baseURL + termsAndConditions),);

    print("TermsAndConditions ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future forgotPasswordApi(mobile) async {

    final response = await http.post(Uri.parse(baseURL + forgotPassword),
      body: ({
        "mobile":mobile
      }),
    );

    print("forgotPassword ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future otpVerify(mobile,otp) async {
    final response = await http.post(Uri.parse(baseURL + matchOTP),
      body: ({
        'mobile':mobile,
        'otp':otp,
      }),
    );

    print("matchOTP ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future logOut() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + logout),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    print("logout ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future signUpBasicDetails(authToken,whatYourMainGoalForjoiningairnests,howmanypropertiesdoyoumanage,doYouWorkWithAPMS) async {
    final response = await http.post(Uri.parse(baseURL + customerBasicDetails),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      body: ({
        "what_your_main_goal_for_joining_airnests":whatYourMainGoalForjoiningairnests,
        "how_many_properties_do_you_manage":howmanypropertiesdoyoumanage,
        "do_you_work_with_a_PMS":doYouWorkWithAPMS,
      }),
    );

    print("Sign_Up_Basic_details ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }
  Future resetPass(userId,password,passwordConfirmation) async {
    final response = await http.post(Uri.parse(baseURL + changePassword),
      body: ({
        'user_id':userId,
        'password':password,
        'password_confirmation':passwordConfirmation,
      }),
    );

    print("Reset_Pass ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future serviceListApi(serviceFor) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    print("Authorization token $authToken");
    final response = await http.post(Uri.parse(baseURL + serviceList),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      body: ({
        "service_for": serviceFor,
      }),
    );

    print("Service_List ========= ${response.body}");
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future findCleanerCoHostApi(userType,zipcode,serviceId) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + findCleanerCoHost),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      body: ({
        "user_type":userType,
        "zipcode":zipcode,
        "service_id":serviceId
      }),
    );

    print("Create_Bid ========= ${response.body}");
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }
  Future serviceTypeApi() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + serviceType),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    print("Service_Type ========= ${response.body}");
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }
  Future customerPropertyAddApi(
      name,
      address,
      propertySize,
      dontKnowPropertySize,
      propertyDate,
      propertyTime,
      description,
      userType,
      zipcode,
      serviceId,
      serviceType,
      latitude,
      longitude,
      propertyId
      ) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + customerPropertyAdd),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      body: ({
        "name":name,
        "address":address,
        "property_size":propertySize,
        "dont_know_property_size":dontKnowPropertySize,
        "property_date":propertyDate,
        "property_time":propertyTime,
        "description":description,
        "user_type":userType,
        "zipcode":zipcode,
        "services_id":serviceId,
        "service_type":serviceType,
        "latitude":latitude,
        "longitude":longitude,
        "property_id":propertyId,
      }),
    );

    print("Create_Bid & Customer_Property_Add  ========= ${response.body}");
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future propertySummary(propertyId) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + customerPropertySummary),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      body: ({
        "property_id": propertyId,
      }),
    );

    print("Service_Type ========= ${response.body}");
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }


  Future addCard(cardHolderName,cardNumber,expMonth,expYear,cvv) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + cardAdd),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      body: ({
        "card_holder_name":cardHolderName,
        "card_number":cardNumber,
        "exp_month":expMonth,
        "exp_year":expYear,
        "cvv":cvv,
      }),
    );

    print("Add_Card ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future adminFees() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.get(Uri.parse(baseURL + adminCommission),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      // body: ({
      //   "card_holder_name":cardHolderName,
      //   "card_number":cardNumber,
      //   "exp_month":expMonth,
      //   "exp_year":expYear,
      //   "cvv":cvv,
      // }),
    );

    print("Admin Fees ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future cardListApi() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + cardList),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    print("Card_List ========= ${response.body}");
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future cohostPropertyAdd(
      name,
      coHostId,
      userType,
      address,
      propertySize,
      bookingDate,
      bookingTime,
      describeYourNeed,
      serviceType,
      zipcode,
      cleanerNeedsToWashAndDryLinenAndTowels,
      iProvideCleaningSupplies,
      squareFeet,
      squareFeetPrice,
      servicesId,
      propertyId,
     ) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + bookCoHostWithProperty),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      body: ({
        "name":name,
        "co_host_id":coHostId,
        "user_type":userType,
        "address":address,
        "property_size":propertySize,
        "property_date":bookingDate,
        "property_time":bookingTime,
        "description":describeYourNeed,
        "service_type":serviceType,
        "zipcode":zipcode,
        "cleaner_needs_to_wash_and_dry_linen_and_towels":cleanerNeedsToWashAndDryLinenAndTowels, //  0/1
        "i_provide_cleaning_supplies":iProvideCleaningSupplies, //  0/1
        "square_feet":squareFeet,
        "square_feet_price":squareFeetPrice,
        "services_id":servicesId,
        "property_id":propertyId,
      }),
    );

    print("Cohost_Property_Add  ========= ${response.body}");
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future cleanerPropertyAdd(
      name,
      address,
      userType,
      propertySize,
      dontKnowPropertySize,
      propertyDate,
      propertyTime,
      description,
      zipcode,
      servicesId,
      serviceLabelId,
      serviceLabelTitle,
      serviceLabelQty,
      serviceLabelUnitPrice,
      serviceType,
      cleanerId,
      washTowels,
      cleanerSupplies,
      propertyId
      ) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + bookCleanerWithProperty),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      body: ({
        "name":name,
        "address":address,
        "user_type":userType,
        "property_size":propertySize,
        "dont_know_property_size":dontKnowPropertySize,
        "property_date":propertyDate,
        "property_time":propertyTime,
        "description":description, //  0/1
        "zipcode":zipcode,
        "services_id":servicesId,

        "service_label_id":serviceLabelId,
        "service_label_title":serviceLabelTitle,
        "service_label_qty":serviceLabelQty,
        "service_label_unit_price":serviceLabelUnitPrice,
        "service_type":serviceType,
        "cleaner_id":cleanerId,
        "cleaner_needs_to_wash_and_dry_linen_and_towels":washTowels,
        "i_provide_cleaning_supplies":cleanerSupplies,
        "property_id":propertyId,

      }),
    );

    print("Cohost_Property_Add  ========= ${response.body}");
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future cleanerPropertyAddForPerHour(
      name,
      address,
      userType,
      propertySize,
      dontKnowPropertySize,
      propertyDate,
      propertyTime,
      description,
      zipcode,
      servicesId,
      serviceLabelQty,
      serviceLabelUnitPrice,
      serviceType,
      cleanerId,
      washTowels,
      cleanerSupplies,
      propertyId
      ) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + bookCleanerForPerHour),
      headers: {
        'Authorization': 'Bearer $authToken',
      },

      body: ({
        "name":name,
        "address":address,
        "user_type":userType,
        "property_size":propertySize,
        "dont_know_property_size":dontKnowPropertySize,
        "property_date":propertyDate,
        "property_time":propertyTime,
        "description":description, //  0/1
        "zipcode":zipcode,
        "services_id":servicesId,
        "service_label_qty":serviceLabelQty,
        "service_label_unit_price":serviceLabelUnitPrice,
        "service_type":serviceType,
        "cleaner_id":cleanerId,
        "cleaner_needs_to_wash_and_dry_linen_and_towels":washTowels,
        "i_provide_cleaning_supplies":cleanerSupplies,
        "property_id":propertyId,

      }),
    );
    

    print("Cohost_Property_Add  ========= ${response.body}");
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future extraServiceList() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + extraServicesList),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    print("Extra_Service_List ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future checkOutApi(cleanerCoHostId,propertyId,transactionId,bookingDate,bookingTime,serviceId,total,bidId,booking_type,grand_total) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + checkOut),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      body: ({
        "cleaner_co_host_id":cleanerCoHostId,
        "property_id":propertyId,
        "transaction_id":transactionId,
        "booking_date":bookingDate,
        "booking_time":bookingTime,
        "service_id":serviceId,
        "total":total,
        // "card_id":"1",
        "bid_id":bidId,
        "booking_type":booking_type,
        "grand_total":grand_total
      }),
    );

    print("Check_Out ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future bookingTrackingApi(bookingId) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + bookingTracking),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      body: ({
        "booking_id":bookingId,
      }),
    );

    print("Booking_Tracking ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    print("response.body=====${response.body}");
    print("convertDataToJson=====$convertDataToJson");
    return convertDataToJson;
  }

  Future bidByCleanerApi(userType) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + bidByCleaner),
      headers: {
        'Authorization': 'Bearer $authToken',   },
      body: ({
        "user_type":userType // cleaner =1,co-host = 2

      }),
    );
    print("Bid_By_Cleaner ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future deleteBid(bidId) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + bidRemove),
      headers: {
        'Authorization': 'Bearer $authToken',      },
      body: ({
        "bid_id":bidId // cleaner =1,co-host = 2

      }),
    );
    print("Bid_By_Cleaner ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future bidByCleanerListApi(bidId) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + bidByCleanerList),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      body: ({
        "bid_id":bidId,
      }),
    );

    print("Bid_By_Cleaner_List ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future bidRequestAcceptRejectByCustomerApi(bidId,cleanerId,status) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + bidRequestAcceptRejectByCustomer),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      body: ({
        "bid_id":bidId,
        "cleaner_id":cleanerId,
        "status":status   // 1-for accept , 2-for reject
      }),
    );

    print("bidRequestAcceptRejectByCustomer ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future bookingRequestList(requestType) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + bookingRequest),
      headers: {
        'Authorization': 'Bearer $authToken',      },
      body: ({
        "request_type":requestType // request_type = history , for history
      }),
    );

    print("Booking_Request_List =====jj==== ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future finalBookingSummaryApi(bookingId) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + finalBookingSummary),
      headers: {
        'Authorization': 'Bearer $authToken'},
      body: ({
        "booking_id":bookingId
      }),
    );

    print("Final_Booking_Summary ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future reviewByCustomerApi(cleanerId,rating,title,review) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + reviewByCustomer),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      body: ({
        "cleaner_id":cleanerId,
        "rating":rating,
        "title":title,
        "review":review
      }),
    );

    print("Review_By_Customer ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }


  Future getProfileApi() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + getProfile),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    print("authToken = = = = = = = == ${authToken.toString()}");
    print("Get_Profile ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future updateProfileApi(firstname,lastname,mobile,image,address,latitude,longitude) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    Map<String, String> headers = {'Authorization': 'Bearer $authToken',};

    var request = http.MultipartRequest('POST', Uri.parse(baseURL + updateProfile),);
    request.headers.addAll(headers);

    request.fields['firstname'] = firstname;
    request.fields['lastname'] = lastname;
    request.fields['zipcode'] = "123456";
    request.fields['experience'] = experience??"";
    request.fields['mobile'] = mobile;
    request.fields['address'] = address;
    request.fields['latitude'] = latitude;
    request.fields['longitude'] = longitude;

    if (image.isNotEmpty) {
      // Open the image file
      File imageFile = File(image);

      // Add the image file
      var stream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile('avatar', stream, length, filename: imageFile.path);

      // Add the image file to the request
      request.files.add(multipartFile);
    }

    // request.files.add(http.MultipartFile('avatar', File(image).readAsBytes().asStream(),
    //   File(image).lengthSync(),
    //   filename: image.split("/").last,
    // ),
    // );

    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    var convertDataToJson = jsonDecode(respStr);

    print(convertDataToJson);
    return convertDataToJson;
  }

  Future updatePassword(oldPassword,newPassword,newPasswordConfirmation) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + updatePasswordd),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      body: ({
        "old_password":oldPassword,
        "new_password":newPassword,
        "new_password_confirmation":newPasswordConfirmation,
      }),
    );

    print("updatePassword ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future serviceDetailsApi(serviceId,cleanerCohostId) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + serviceDetails),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      body: ({
        "service_id": serviceId,
        "user_id": cleanerCohostId, // user_id = cleaner_id
      }),
    );

    print("Service_Details ========= ${response.body}");
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }
  Future servicePhotoList(cleanerCohostId) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + cleanerServicesPhotoList),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      body: ({
        "cleaner_co_host_id": cleanerCohostId,
      }),
    );

    print("Service_Photo_list ========= ${response.body}");
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future cleanerCoHostDetailsApi(cleanerCohostId) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + cleanerCoHostDetails),
      headers: {
        'Authorization': 'Bearer $authToken',      },
      body: ({
        "user_id": cleanerCohostId,
      }),
    );

    print("Cleaner_CoHost_Details ========= ${response.body}");
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  // co-host  -- square_feet
  Future coHostServicesPriceApi(coHostId,roleType) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + coHostServicesPrice),
      headers: {
        'Authorization': 'Bearer $authToken',      },
      body: ({
        "co_host_id": coHostId,  // cleaner_id and co-host_id
        "role": roleType
      }),

    );
    print("co_host_id ---  ${coHostId.toString()}");
    print("CoHost_Services_Price ========= ${response.body}");
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  // Hourly
  Future cleanerCoHostPerHourPriceApi(cleanerId) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + cleanerCoHostPerHourPrice),
      headers: {
        'Authorization': 'Bearer $authToken',      },
      body: ({
        "cleaner_id": cleanerId,   // cleaner_id and co-host_id
      }),
    );

    print("Cleaner_CoHost_Per_HourPrice ========= ${response.body}");
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future nearByMaidApi() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + nearByMaid),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      // body: ({
      //   "cleaner_id":cleaner_id,
      //   "rating":rating,
      //   "title":title,
      //   "review":review
      // }),
    );
    print("Near_by_Maid ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future recommendedListApi() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + recommendedList),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      // body: ({
      //   "cleaner_id":cleaner_id,
      //   "rating":rating,
      //   "title":title,
      //   "review":review
      // }),
    );
    print("Recommended_List ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future favoriteUnfavoriteApi(cleanerCoHostId) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + favoriteUnfavorite),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      body: ({
        "cleaner_co_host_id":cleanerCoHostId,
      }),
    );
    print("Favorite_Unfavorite ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future favoriteList() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + favoriteUnfavoriteList),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      // body: ({
      //   "cleaner_co_host_id":cleaner_co_host_id,
      // }),
    );
    print("Favorite_List ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future blogList() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + blogs),
      headers: {
        'Authorization': 'Bearer $authToken',
      },

    );
    print("Blog_List ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future squareFeetListApi() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + squareFeetList),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    print("squareFeetList ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future customerPropertyListt() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + customerPropertyList),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );
    print("customerPropertyListt ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future blogDetailsApi(blogId) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + blogDetails),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      body: ({
        "blog_id":blogId,
      }),

    );
    print("Blog_Details ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future startAudioCall(remoteUserId) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + getAgoraToken),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
        body: ({
          "remote_user_id": remoteUserId,
          "type": 'audio', // video , audio
        }));
    print("getAgoraToken ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }
  Future startVideoCall(remoteUserId) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + getAgoraToken),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
        body: ({
          "remote_user_id": remoteUserId,
          "type": 'video', // video , audio
        }));
    print("getAgoraToken ========= ${response.body}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future removeAccountApi() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + removeAccountEndPoint),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
        body: ({

        }));
    log("removeAccountApi ========= ${response.body.toString()}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future cardRemoveApi({cardId}) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    final response = await http.post(Uri.parse(baseURL + cardRemoveEndPoint),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
        body: ({

          "card_id":cardId

        }));
    log("cardRemoveApi ========= ${response.body.toString()}");

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future notificationListAPI() async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');

    log("Authorization token $authToken");

    final response = await http.post(Uri.parse(baseURL + notificationListEndpoint),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
        body: ({}));

    var convertDataToJson = jsonDecode(response.body);
    log('notificationListAPI-----------------------------$convertDataToJson');
    return convertDataToJson;
  }


  Future readNotificationAPI({notificationId}) async {
    final prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');

    log("Authorization token $authToken");

    final response = await http.post(Uri.parse(baseURL + readNotificationEndpoint),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
        body: ({"notification_id": notificationId}));

    var convertDataToJson = jsonDecode(response.body);
    log('readNotificationAPI-----------------------------$convertDataToJson');
    return convertDataToJson;
  }

  Future searchCleanerApi({search}) async {
    final prefs = await SharedPreferences.getInstance();

    var authToken = prefs.getString('auth_token');

    log("Authorization token $authToken");

    final response = await http.post(Uri.parse(baseURL + searchCleanerEndpoint),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
        body: ({"search": search}));

    var convertDataToJson = jsonDecode(response.body);
    log('searchCleanerApi-----------------------------$convertDataToJson');
    return convertDataToJson;
  }

  Future helpCenterAPI({type}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var authToken = prefs.getString('auth_token');

    log("Authorization token $authToken");

    final response = await http.post(Uri.parse(baseURL + helpCenterEndpoint),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
        body: ({"type": type}));

    var convertDataToJson = jsonDecode(response.body);
    log('HelpCenterAPI-----------------------------$convertDataToJson');
    return convertDataToJson;
  }

  Future addPropertyAPI({name, address, latitude, longitude, propertySize}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var authToken = prefs.getString('auth_token');

    log("Authorization token $authToken");

    final response = await http.post(Uri.parse(baseURL + addPropertyEndpoint),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
        body: ({

          "name": name,
          "address": address,
          "latitude": latitude,
          "longitude": longitude,
          "property_size": propertySize,


        }));

    var convertDataToJson = jsonDecode(response.body);
    log('addPropertyAPI-----------------------------$convertDataToJson');
    return convertDataToJson;
  }

  Future updatePropertyAPI({propertyId,name, address, latitude, longitude, propertySize}) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var authToken = prefs.getString('auth_token');

    log("Authorization token $authToken");

    final response = await http.post(Uri.parse(baseURL + updatePropertyEndpoint),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
        body: ({

          "property_id": propertyId,
          "name": name,
          "address": address,
          "latitude": latitude,
          "longitude": longitude,
          "property_size": propertySize,


        }));

    var convertDataToJson = jsonDecode(response.body);
    log('updatePropertyAPI-----------------------------$convertDataToJson');
    return convertDataToJson;
  }

  Future removePropertyAPI({propertyId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var authToken = prefs.getString('auth_token');

    log("Authorization token $authToken");

    final response = await http.post(Uri.parse(baseURL + removePropertyEndpoint),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
        body: ({

          "property_id": propertyId,



        }));

    var convertDataToJson = jsonDecode(response.body);
    log('removePropertyAPI-----------------------------$convertDataToJson');
    return convertDataToJson;
  }

  Future getTermsAndConditions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('auth_token');
    log("Authorization token/////---- $authToken");

    final response = await http.get(
      Uri.parse(baseURL + termsAndConditionsEndpoint),
      headers: {'Authorization': 'Bearer $authToken'},
    );
    var convertDataToJson = jsonDecode(response.body.toString());

    log('GetTermsAndConditions-----------------------------$convertDataToJson');
    return convertDataToJson;
  }






}