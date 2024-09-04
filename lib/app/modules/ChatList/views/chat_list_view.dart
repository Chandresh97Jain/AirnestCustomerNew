import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_maids/Utils/cached_netword_image.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/app/modules/ChatList/controllers/chat_list_controller.dart';
import 'package:power_maids/app/routes/app_pages.dart';

class ChatListView extends GetView<ChatListController> {
  const ChatListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: AppStyles.backgroundColor,
          automaticallyImplyLeading: false,
          elevation: 1,
          backgroundColor: AppStyles.backgroundColor,
          title: Textwidget(
            text: "Chat",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          centerTitle: false,
        ),
        body: Obx(() =>
       Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
       Expanded(child: StreamBuilder<QuerySnapshot>(
           stream: controller.getChatRoomsStream(controller.firebaseUserId.value),
          builder: (context, chatRoomsSnapshot) {
            if (chatRoomsSnapshot.connectionState == ConnectionState.waiting) {
              return ShowLoader.isLoadingProgress(true);
            }

            if (!chatRoomsSnapshot.hasData || chatRoomsSnapshot.data!.docs.isEmpty) {
              return Center(
                child: Textwidget(
                  text: 'No chat users found.',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              );
            }

            // Extract user IDs and last message details from chat room documents
            List<String> userIDs = [];
            List<Map<String, dynamic>> lastMessageDetails = [];

            chatRoomsSnapshot.data!.docs.forEach((chatRoomDoc) {
              Map<String, dynamic>? data = chatRoomDoc.data() as Map<String, dynamic>?;
              if (data != null && data.containsKey('users')) {
                List<dynamic>? users = data['users'];
                if (users != null) {
                  users.forEach((user) {
                    if (user != controller.firebaseUserId.value && !userIDs.contains(user)) {
                      userIDs.add(user);
                      lastMessageDetails.add({
                        'lastMessage': data['lastMessage'],
                        'lastTimestamp': data['lastTimestamp']
                      });
                    }
                  });
                }
              }
            });

            // Use another StreamBuilder to get user details
            return StreamBuilder<List<DocumentSnapshot>>(
              stream: controller.getUserDetailsStream(userIDs),
              builder: (context, userSnapshot) {

                // print("chat ----- --------no users found> ${userSnapshot.hasData}");
                // print("chat ----- --------> ${userSnapshot.data!.isEmpty}");

                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return ShowLoader.isLoadingProgress(true);
                }

                if (!userSnapshot.hasData || userSnapshot.data!.isEmpty) {
                  return const Center(child:   Text('No users found.'));
                }

                List<DocumentSnapshot> userDocs = userSnapshot.data!;

                return ListView.builder(
                  itemCount: userDocs.length,
                  itemBuilder: (context, index) {
                    var userData = userDocs[index].data() as Map<String, dynamic>;
                    var lastMessage = lastMessageDetails[index]['lastMessage'] ?? 'No messages yet';
                    var lastTimestamp = lastMessageDetails[index]['lastTimestamp'] != null
                        ? (lastMessageDetails[index]['lastTimestamp'] as Timestamp).toDate()
                        : null;

                    return InkWell(
                      onTap: () {
                        var data = {
                          'remote_firebase_id': userData['id'].toString(),
                          'remote_user_id': userData['user_id'].toString(),
                          'other_user_name': "${userData['first_name']} ${userData['last_name']}",
                        };
                        Get.toNamed(Routes.CHAT_SCREEN, parameters: data);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    SizedBox(
                                      height: 90,
                                      child: Container(
                                        height: 90,
                                        width: 90,
                                        decoration:   BoxDecoration(shape: BoxShape.circle,border: Border.all(color: AppStyles.appThemeColor)),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: ProfileImage(image: userData['profile'].toString(), fit: BoxFit.fill,),
                                        ),
                                      ),
                                    ),
                                    // CircleAvatar(
                                    //   radius: 18,
                                    //   backgroundColor: AppStyles.appThemeColor,
                                    //   child: Textwidget(
                                    //     textscalefector: 1,
                                    //     text: "20",
                                    //     fontSize: 12,
                                    //     color: Colors.white,
                                    //   ),
                                    // )
                                  ],
                                ),
                                const SizedBox(width: 15),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Textwidget(
                                              textAlign: TextAlign.start,
                                              maxLines: 3,
                                              text: "${userData['first_name']} ${userData['last_name']}",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Flexible(
                                            child: Textwidget(
                                              text: lastTimestamp != null
                                                  ? "${lastTimestamp.hour}:${lastTimestamp.minute} ${lastTimestamp.hour >= 12 ? 'PM' : 'AM'}"
                                                  : '',
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Textwidget(
                                        maxLines: 5,
                                        text: lastMessage,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: AppStyles.GrayTextColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Divider(
                              thickness: 1,
                              height: 0,
                              color: AppStyles.deviderColor,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),)
          ],
        )
        )
    );
  }
}
