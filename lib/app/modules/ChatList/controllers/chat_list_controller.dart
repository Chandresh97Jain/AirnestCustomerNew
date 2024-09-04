import 'dart:developer';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatListController extends GetxController {
  //TODO: Implement ChatListController

  final count = 0.obs;
  final isLoading = false.obs;
  final firebaseUserId = ''.obs;
  RxList userData=[].obs;


  @override
  void onInit() {
    super.onInit();
    getPref();
    // getChatUsers(firebase_user_id.value);

  }

  getPref() async {

  final prefs = await SharedPreferences.getInstance();
  firebaseUserId.value  = prefs.getString('firebase_user_id')!;
  log("userID ------ firebase ${firebaseUserId.value}");
    getChatRoomsStream(firebaseUserId.value);

  }

  @override
  void onReady() {
    super.onReady();
    // getPref();
  }

  @override
  void onClose() {
    super.onClose();
    userData.clear();
  }

  Stream<QuerySnapshot> getChatRoomsStream(String userId) {
    CollectionReference chatRoomsCollection = FirebaseFirestore.instance.collection('chats');

    return chatRoomsCollection
        .where('users', arrayContains: userId)
        .snapshots(); // Using snapshots() to get a stream
  }

  Stream<List<DocumentSnapshot>> getUserDetailsStream(List<String> userIDs) async* {
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

    List<DocumentSnapshot> userDocs = [];
    for (String userID in userIDs) {
      DocumentSnapshot userDoc = await usersCollection.doc(userID).get();
      if (userDoc.exists) {
        userDocs.add(userDoc);
      }
    }

    yield userDocs;
  }

  // getChatUsers(String userId) async {
  //
  //   isLoading(true);
  //   userData.clear();
  //   print("userDAta List ${userData.length}");
  //   // printrint("qwdfghjkl;12");
  //   // Reference to the "chatRooms" collection in Firestore
  //   CollectionReference chatRoomsCollection = FirebaseFirestore.instance.collection('chats');
  //
  //   try {
  //     // Query chat rooms where the current user is a participant
  //     QuerySnapshot chatRoomQuerySnapshot = await chatRoomsCollection
  //         .where('users', arrayContains: userId)
  //         .get();
  //
  //     // Extract user IDs from chat room documents
  //     List<String> userIDs = [];
  //     // print("querySnapshot $chatRoomQuerySnapshot");
  //     chatRoomQuerySnapshot.docs.forEach((chatRoomDoc) {
  //      // print("chatlist ${chatRoomDoc.data()}");
  //       Map<String, dynamic>? data = chatRoomDoc.data() as Map<String, dynamic>? ;
  //       if (data != null && data.containsKey('users')) {
  //         List<dynamic>? users = data['users'];
  //         if (users != null) {
  //           users.forEach((user) {
  //             if (user != userId && !userIDs.contains(user)) {
  //               userIDs.add(user);
  //
  //             }
  //           });
  //         }
  //       }
  //     });
  //     // print("userIDs -==p-=-=== ${userIDs.toString()}");
  //     // Reference to the "users" collection in Firestore
  //     CollectionReference usersCollection =
  //     FirebaseFirestore.instance.collection('users');
  //
  //     // Query user documents using the extracted user IDs
  //     List<DocumentSnapshot> userDocs = [];
  //     for (String userID in userIDs) {
  //       DocumentSnapshot userDoc = await usersCollection.doc(userID).get();
  //       // print("userData $userDoc");
  //       if (userDoc.exists) {
  //         // userDocs.add(userDoc);
  //         isLoading(false);
  //         userData.add(userDoc);
  //       }else{
  //         print("  jaydeep - - - - - -  - -");
  //       }
  //     }
  //   } catch (error) {
  //     isLoading(false);
  //     print('Error retrieving chat users: $error');
  //     return [];
  //   }
  //   update();
  // }

  void increment() => count.value++;
}
