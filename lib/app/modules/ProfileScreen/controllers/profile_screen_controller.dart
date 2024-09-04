import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:power_maids/Utils/api_service.dart';
import 'package:power_maids/app/modules/SignIn/controllers/sign_in_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileScreenController extends GetxController {
  //TODO: Implement ProfileScreenController

  final count = 0.obs;
  final fname = ''.obs;
  final lname = ''.obs;
  final email = ''.obs;
  final image = ''.obs;
  final number = ''.obs;

  logout() async {
    final prefs = await SharedPreferences.getInstance();
   // prefs.clear();
    prefs.remove('auth_token');

    Get.offAllNamed(Routes.SIGN_IN);


  }

  @override
  void onInit() {
    super.onInit();
    retriveData();
  }



  retriveData() async {


    final prefs = await SharedPreferences.getInstance();

    image.value =  prefs.getString('image')??"";
    fname.value = prefs.getString('firstname')??"";
    lname.value = prefs.getString('lastname')??"";
    email.value = prefs.getString('email')??"";
    number.value =  prefs.getString('mobile')??"";

    // numberController.text =  mobile;
  }
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Sign out
  Future<void> signOutGoogle() async {
    try {
      // Create an instance of GoogleSignIn
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Sign out the current user
      await googleSignIn.signOut();
      await auth.signOut();

      log('User signed out successfully');
    } catch (e) {
      // Handle any errors that occur during sign-out
      log('Error signing out: $e');
    }
  }
  Future<void> deleteToken() async {
    try {
      // Delete FCM token
      await _firebaseMessaging.deleteToken();

      // Perform any additional cleanup if necessary, e.g., deleting user data from Firestore
      String uid = auth.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'fcmToken': FieldValue.delete(),
      });

    } catch (e) {
      log('Error signing out: $e');
    }
  }
  Future<void> signOutApple() async {
    // Clear the user token from secure storage
    await SecureStorage.deleteUserInfo();
  }
  Future<void> signOutFacebook() async {
    // Clear the user token from secure storage
    FacebookAuth.instance.logOut();
  }
  final isLoading = false.obs;
  Future logOut(context) async {

    try {
       isLoading(true);

      var response = await ApiService().logOut();

      if (response['status'] == true) {

        await signOutGoogle();
        await deleteToken();
        await signOutFacebook();
        await signOutApple();
        await logout();
        Navigator.pop(context);



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
