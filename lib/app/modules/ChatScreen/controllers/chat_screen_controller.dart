import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:power_maids/Chat/chat_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:vibration/vibration.dart';


class ChatScreenController extends GetxController {
  //TODO: Implement ChatScreenController

 // final  TextEditingController TextMessagescontroller = TextEditingController();

 Rx<TextEditingController> messageController = TextEditingController().obs;
 // final ChatApiService chatService = ChatApiService();
 final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

 final ChatServiceCustomer chatService = ChatServiceCustomer();
 final GroupedItemScrollController itemScrollController = GroupedItemScrollController();

 final ScrollController scrollController = ScrollController();
 final emojiShowing = false.obs;

 final count = 0.obs;
 final icon1 ="assets/icons/microphone.png".obs;
 final icon2 ="assets/icons/send1.png".obs;

 final currentUserID = ''.obs;
 final userId = ''.obs;
 final currentUserFName = ''.obs;
 final currentUserLName = ''.obs;
 final remoteUserProfile = ''.obs;
 final otherUserID = ''.obs;
 final remoteUserId = ''.obs;
 final otherUserName = ''.obs;
 final lastSeen = ''.obs;
 final focusNode = FocusNode().obs;

 void onEmojiSelected(emoji) {
  messageController.value
   ..text += emoji.emoji
   ..selection = TextSelection.fromPosition(
       TextPosition(offset: messageController.value.text.length));
 }

 void vibrate() async {
  // Check if the device can vibrate
  bool canVibrate = await Vibration.hasVibrator() ?? false;

  if (canVibrate) {
   Vibration.vibrate(duration: 200); // Vibrate for 200ms
  }
 }

 void toggleEmojiPicker() {
  if (emojiShowing.value) {
   focusNode.value.requestFocus();
  } else {
   focusNode.value.unfocus();
  }
   // emojiShowing.value = !emojiShowing.value;
 }

 DateTime convertTimestampToDateTime(Timestamp timestamp) {

  return timestamp.toDate();
 }

 Timestamp convertStringToTimestamp(String dateTimeString) {
  // Parse the string into a DateTime object
  DateTime dateTime = DateTime.parse(dateTimeString);

  // Convert the DateTime object to a Timestamp object
  return Timestamp.fromDate(dateTime);
 }

 String readTimestamp(String timestampString) {
  // Extract the seconds part from the string
  final secondsMatch = RegExp(r'seconds=(\d+)').firstMatch(timestampString);
  if (secondsMatch == null) {
   throw ArgumentError('Invalid timestamp format');
  }

  // Convert the extracted seconds part to an integer
  final int timestamp = int.parse(secondsMatch.group(1)!);

  var now = DateTime.now();
  var format = DateFormat('hh:mm a');
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var diff = now.difference(date);
  var time = '';

  if (diff.inSeconds <= 0 ||
      (diff.inSeconds > 0 && diff.inMinutes == 0) ||
      (diff.inMinutes > 0 && diff.inHours == 0) ||
      (diff.inHours > 0 && diff.inDays == 0)) {
   time = format.format(date);
  } else if (diff.inDays > 0 && diff.inDays < 7) {
   if (diff.inDays == 1) {
    time = diff.inDays.toString() + ' day ago';
   } else {
    time = diff.inDays.toString() + ' days ago';
   }
  } else {
   if (diff.inDays == 7) {
    time = (diff.inDays / 7).floor().toString() + ' week ago';
   } else {
    time = (diff.inDays / 7).floor().toString() + ' weeks ago';
   }
  }

  return time;
 }

 getPref() async {
  final prefs = await SharedPreferences.getInstance();
  currentUserID.value  = prefs.getString('firebase_user_id')!;
  userId.value  = prefs.getString('user_id')!;
  log("userID ------- firebase ${currentUserID.value}");

 }


  @override
  void onInit() {
    super.onInit();
    focusNode.value.unfocus();
    getPref();
    otherUserID.value = Get.parameters['remote_firebase_id']!;
    remoteUserId.value = Get.parameters['remote_user_id']!;
    otherUserName.value =  Get.parameters['other_user_name']!;
    chatService.getMessages(currentUserID.value,otherUserID.value,scrollController);
    getUserData();
  }

 Future<void> getUserData() async {
  log("user -----name  ${currentUserID.value}");
  DateTime? lastSeenTimestamp = await chatService.getLastSeenTimestamp(otherUserID.value);
  lastSeen.value = lastSeenTimestamp.toString();
  try {
   String uid = currentUserID.value;
   DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
   currentUserFName.value = userDoc['first_name'];
   currentUserLName.value = userDoc['last_name'];
   remoteUserProfile.value = userDoc['profile'];

   // Add user_id parameter field
   addNewField({'user_id': userId.value});

  } catch (e) {
   log('Error getting user data: $e');
  }
 }

 void addNewField(Map<String, dynamic> newField) {
 String uid = currentUserID.value;
 FirebaseFirestore.instance.collection('users').doc(uid).update(newField).then((_) {
   log("Field added successfully");
  }).catchError((error) {
   log("Failed to add field: $error");
  });
 }

 void scrollToBottom() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
   if (scrollController.hasClients) {
    scrollController.animateTo(
     scrollController.position.maxScrollExtent,
     duration:  const Duration(milliseconds: 300),
     curve: Curves.easeOut,
    );
   }
  });
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

