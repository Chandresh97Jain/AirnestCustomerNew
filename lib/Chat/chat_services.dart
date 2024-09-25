import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Notifications/PushNotificationService.dart';
import '../Utils/ShowToast.dart';

class ChatServiceCustomer {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List get imageFiles => _imageFiles!.obs.value;

  RxList<XFile>? _imageFiles = RxList<XFile>([]).obs.value;

  var selectedImages = <File>[].obs;

  final loading = false.obs;
  final isBlockedUser = false.obs;
  final picker = ImagePicker();
  final isRemoteBlock = false.obs;

  Future<void> pickImage() async {
    final pickedFile = await picker.pickMultiImage(
      // source: ImageSource.gallery,
      imageQuality: 90,
    );
    if (pickedFile != null && pickedFile.length <= 10) {
      _imageFiles!.value = pickedFile;

      selectedImages.value = pickedFile.map((file) => File(file.path)).toList();

    } else {
      ToastClass.showToast("You can select up to 10 images.");
    }
  }

  Future<List<String>> uploadImages(List<File> imageFiles) async {
    loading.value = true;
    List<String> downloadUrls = [];
    try {
      for (var imageFile in imageFiles) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('chat_images')
            .child('${DateTime.now().toIso8601String()}.png');
        await ref.putFile(imageFile);
        final downloadUrl = await ref.getDownloadURL();
        downloadUrls.add(downloadUrl);
      }
    } on FirebaseException catch (e) {
      if (e.code == 'unauthorized') {
        log('User is not authorized to perform the desired action.');
      } else {
        log('FirebaseException: ${e.message}');
      }
    } catch (e) {
      log('Error uploading images: $e');
    } finally {
      loading.value = false;
    }
    return downloadUrls;
  }


  Future<void> sendMessage(String senderId,String senderName, String receiverId, String message,ScrollController scrollController,List<String> imageUrls) async {
    loading.value = true;
    try {
      print("jaydeepvm==========  = == =  = = == = =");

      // Check if the sender or receiver is blocked
      bool isBlocked = await isUserBlocked(senderId, receiverId);
      if (isBlocked) {
        ToastClass.showToast("Cannot send message, user is blocked.");
        loading.value = false;
        return;
      }

      String ChatroomId = await createChatRoom(senderId, receiverId ,message);

      await _firestore.collection('chats').doc(ChatroomId).collection("messages").add({
        'senderId': senderId,
        'senderName': senderName,
        'receiverId': receiverId,
        'message': message,
        'timestamp': DateTime.now(),
        'images': imageUrls,
      });

      // await _firestore.collection('chats').doc(ChatroomId).set({
      //   'lastMessage': message, // Replace with the actual last message
      //   'lastTimestamp': DateTime.now(),       // Removed the incorrect semicolon
      // });

      // Get the receiver's FCM token from Firestore
      DocumentSnapshot receiverSnapshot = await _firestore.collection('users').doc(receiverId).get();
      String? receiverToken = receiverSnapshot['fcmToken'];

      print("Chat ----- fcmToken - ${receiverToken}");

      if (receiverToken != null) {
        await sendPushNotificationWithOAuth(receiverToken, senderName, message);

      }

      scrollToBottom(scrollController);
      loading.value = false;
    } catch (e) {
      loading.value = false;
      print('Error sending message: $e');
    }
  }

  Future<String> getFirebaseOAuthToken() async {
    try{
      // Load the service account JSON file
      String jsonString = await rootBundle.loadString('assets/credentials/firebase_service_account.json');
      final accountCredentials = ServiceAccountCredentials.fromJson(jsonDecode(jsonString));

      // Set the scope for Firebase Cloud Messaging
      final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

      // Generate the OAuth token using the service account
      final authClient = await clientViaServiceAccount(accountCredentials, scopes);

      // Return the access token
      return authClient.credentials.accessToken.data;
    }catch(e){
      print("---  error-- $e");
      return '';
    }
  }


  /// Function to send FCM push notification using the OAuth token
  Future<void> sendPushNotificationWithOAuth(String fcmToken, String title, String body) async {
    try {
      // Get the OAuth token
      String oauthToken = await getFirebaseOAuthToken();

      print("---  oauthToken-- $oauthToken");
      print("---  title-- $title");
      // Set up Dio instance
      Dio dio = Dio();

      // Make the HTTP request to send the FCM notification using Dio
      final response = await dio.post('https://fcm.googleapis.com/v1/projects/airnests-app-39a0a/messages:send', // Replace with your Firebase project ID
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $oauthToken',
          },
        ),
        data: jsonEncode({
          'message': {
            'token': fcmToken,
            'notification': {
              'title': title,
              'body': body,
            },
            'data': {
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            },
          },
        }),
      );

      print('Push notification sent: ${response.statusCode}');
    } catch (e) {
      print('Error sending push notification: $e');
    }
  }

  // Future<void> sendPushNotification(String token, String senderName, String message) async {
  //   try {
  //     String serverKey = 'AAAAHGX8PJ0:APA91bG3hNSxdiW7vnO_997HggH34FvCAeqMEKriBKVINGzGY7ot_6NcXJVR4LmrLBOu0ZgjT4uUNuwkU21KGBEWB7VAABga_u0Zfwg_hd3NRLd8uyhi_mf5PoQW7pHEXRDN0Z-ltTqP'; // Replace with your FCM server key
  //
  //     await http.post(
  //       Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json',
  //         'Authorization': 'key=$serverKey',
  //       },
  //       body: jsonEncode({
  //         'to': token,
  //         'notification': {
  //           'title': 'New Message from $senderName',
  //           'body': message,
  //         },
  //         'data': {
  //           'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //           'senderId': senderName,
  //         },
  //       }),
  //     );
  //   } catch (e) {
  //     print('Error sending push notification: $e');
  //   }
  // }

   createChatRoom(String user1Id, String user2Id,message) async {
    try {
      // Generate a unique chat room ID
      String chatRoomId = user1Id.hashCode <= user2Id.hashCode
          ? '$user1Id-$user2Id'
          : '$user2Id-$user1Id';

      CollectionReference chatRoomsCollection = FirebaseFirestore.instance.collection('chats');

      // Create a map with the chat room data
      Map<String, dynamic> chatRoomData = {
        'users': [user1Id, user2Id],
        'lastMessage': message, // Replace with the actual last message
        'lastTimestamp': DateTime.now(),
        'unreadCount': FieldValue.increment(0)
        // You can add more metadata about the chat room here
      };

      // getUnreadCountLocally(chatRoomId);

      SetOptions(merge: true);

      // Set the chat room document with the generated chat room ID

      await chatRoomsCollection.doc(chatRoomId).set(chatRoomData);
      return chatRoomId;
      // Reference to the "chatRooms" collection in Firestore


      print('Chat room created successfully: $chatRoomId');
    } catch (error) {
      print('Error creating chat room: $error');
    }
  }

  Stream<List<Message>> getMessages(currentUserID,otherUserID,ScrollController scrollController)async* {

    // Check if the current user has blocked the other user or vice versa
    bool isBlocked = await isUserBlocked(currentUserID, otherUserID);
    isBlockedUser.value = await isUserBlocked(currentUserID, otherUserID);
    isRemoteBlock.value  = await hasRemoteUserBlockedMe(currentUserID, otherUserID);

    if (isBlocked) {
      // If blocked, return an empty stream
      yield* Stream.empty();
      ToastClass.showToast("Cannot load messages, user is blocked.");
      return;
    }


    String roomIds = currentUserID.hashCode <= otherUserID.hashCode
        ? '${currentUserID}-${otherUserID}'
        : '${otherUserID}-${currentUserID}';

    final result = _firestore
        .collection('chats')
        .doc(roomIds)
        .collection("messages")
        .orderBy('timestamp', descending: false) // Ensure messages are ordered by timestamp
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Message.fromFirestore(doc.data()))
        .toList());


    result.listen((messages) {
      // print("Received ${messages.length} messages for room $roomIds");
      scrollToBottom(scrollController);
      // Log the messages received for debugging purposes
      messages.forEach((message) {
        scrollToBottom(scrollController);
        // print("Message: ${message.toString()}, Sender: ${message.senderId}");
      });
    },
        onError: (error) {
      print("Error fetching messages for room $roomIds: $error");
    });
    isUserBlocked(currentUserID, otherUserID);

    yield* result;
  }

  void scrollToBottom(ScrollController scrollController) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // Function to retrieve last seen timestamp of a user from Firestore
  Future<DateTime?> getLastSeenTimestamp(String userId) async {

    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();

    // if (userSnapshot.exists) {
    //   Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
    //   // Assuming 'lastSeen' is the field storing last seen timestamp in Firestore
    //   Timestamp? lastSeenTimestamp = userData['isOnline'] as Timestamp?;
    //   return lastSeenTimestamp?.toDate();
    // }
    return null;
  }

  // Block User
  Future<void> blockUser(String currentUserId, String otherUserId) async {
    // Update the current user's blocked list
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('blocked_users')
        .doc(otherUserId)
        .set({'isBlocked': true});

    // Update the other user's blocked_by list
    await FirebaseFirestore.instance
        .collection('users')
        .doc(otherUserId)
        .collection('blocked_by')
        .doc(currentUserId)
        .set({'isBlocked': true});

    ToastClass.showToast("Blocked!");
  }

  Future<void> unblockUser(String currentUserId, String otherUserId) async {
    // Remove the user from the current user's blocked list
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('blocked_users')
        .doc(otherUserId)
        .delete();

    // Remove the current user from the other user's blocked_by list
    await FirebaseFirestore.instance
        .collection('users')
        .doc(otherUserId)
        .collection('blocked_by')
        .doc(currentUserId)
        .delete();
    ToastClass.showToast("UnBlocked!");
  }

  Future<bool> isUserBlocked(String currentUserId, String otherUserId) async {
    // Check if the current user has blocked the other user
    DocumentSnapshot blockedDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('blocked_users')
        .doc(otherUserId)
        .get();

    // Check if the other user has blocked the current user
    DocumentSnapshot blockedByDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(otherUserId)
        .collection('blocked_by')
        .doc(currentUserId)
        .get();

    return blockedDoc.exists || blockedByDoc.exists;
  }

  Future<bool> hasRemoteUserBlockedMe(String currentUserId, String remoteUserId) async {
    try {
      // Check if the current user is in the remote user's blocked list
      DocumentSnapshot blockedByDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(remoteUserId)
          .collection('blocked_users')
          .doc(currentUserId)
          .get();

      // Return true if the document exists, meaning the remote user has blocked the current user
      return blockedByDoc.exists;
    } catch (e) {
      log('Error checking if remote user blocked me: $e');
      return false;
    }
  }

}

class Message {
  final String senderId;
  final String receiverId;
  final String message;
  final String timestamp;
  final List<String> images;

  Message({required this.senderId, required this.receiverId, required this.message, required this.timestamp, required this.images});

  factory Message.fromFirestore(Map<String, dynamic> data) {
    return Message(
      senderId: data['senderId'],
      receiverId: data['receiverId'],
      message: data['message'],
      timestamp: data['timestamp'].toString(),
      images: List<String>.from(data['images'] ?? []),
    );
  }
}