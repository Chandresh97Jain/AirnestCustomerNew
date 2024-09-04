import 'package:get_storage/get_storage.dart';
import 'package:power_maids/Utils/api_service.dart';


  final userData = GetStorage();

    final user_id  = userData.read('user_id');
    final firstname  = userData.read('firstname')??"";
    final lastname  = userData.read('lastname')??"";
    final image  = userData.read('image')??"";
    final email  = userData.read('email')??"";
    final mobile  = userData.read('mobile')??"";
    final name  = userData.read('name')??"";
    final addressss  = userData.read('address')??"";
    final your_introduction  = userData.read('your_introduction')??"";
    final experience  = userData.read('experience')??"";
    final zipcode  = userData.read('zipcode')??"";
    final business_name  = userData.read('business_name')??"";
    final website  = userData.read('website')??"";
    final role  = userData.read('role')??"";



