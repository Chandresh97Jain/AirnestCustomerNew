import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart' as foundation;
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart' as emoji_picker;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:power_maids/Chat/chat_services.dart';
import 'package:power_maids/Utils/ShowToast.dart';
import 'package:power_maids/Utils/color_style.dart';
import 'package:power_maids/Utils/global_text.dart';
import 'package:power_maids/Utils/loader.dart';
import 'package:power_maids/Utils/textformfield_ui_global.dart';
import 'package:power_maids/app/modules/ChatScreen/controllers/chat_screen_controller.dart';
import 'package:power_maids/app/modules/PhotoViewMaidDetails/views/photo_view_maid_details_view.dart';
import 'package:power_maids/app/routes/app_pages.dart';

class ChatScreenView extends GetView<ChatScreenController> {
  const ChatScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ChatScreenController controller = Get.put(ChatScreenController());

    Timer(
      const Duration(milliseconds: 300),
      () => controller.scrollController.jumpTo(
        controller.scrollController.position.maxScrollExtent,
      ),
    );

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          surfaceTintColor: AppStyles.backgroundColor,
          titleSpacing: 5,
          toolbarHeight: 70,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: AppStyles.backgroundColor,
          title: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Get.back();
                      },
                      icon: Card(
                          margin: EdgeInsets.zero,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          child: Container(
                            decoration:
                                BoxDecoration(color: AppStyles.backgroundColor),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(Icons.arrow_back),
                            ),
                          )),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Textwidget(
                          text: controller.otherUserName.value,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        Textwidget(
                          text: "",
                          fontSize: 10.5,
                          color: AppStyles.Blacklightbuttoncolor,
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: controller.chatService.isRemoteBlock.value == true
                            ?(){ Fluttertoast.showToast(msg: 'You cannot send a message because you are blocked!');}
                            :() {
                          var data = {
                            'remote_user_id': controller.remoteUserId.value,
                            'remote_user_name': controller.otherUserName.value,
                            'remoteUserProfile': controller.remoteUserProfile.value,
                          };
                          if(!controller.chatService.isBlockedUser.value){
                            Get.toNamed(Routes.AUDIO_CALL,parameters: data);
                          }else{
                            Fluttertoast.showToast(msg: 'You cannot send a message because you have blocked this user.');
                          }
                        },
                        icon: const Icon(Icons.call)

                        // Image.asset(
                        //   "assets/icons/CallIvons1.png",
                        //   scale: 4,
                        // )

                        ),
                    IconButton(
                        onPressed: controller.chatService.isRemoteBlock.value == true
                            ?(){ Fluttertoast.showToast(msg: 'You cannot send a message because you are blocked!');}
                            :() {
                          var data = {
                            'remote_user_id': controller.remoteUserId.value,
                            'remote_user_name': controller.otherUserName.value,
                          };
                          if(!controller.chatService.isBlockedUser.value){
                            Get.toNamed(Routes.VIDEO_CALL,parameters: data);
                          }else{
                            Fluttertoast.showToast(msg: 'You cannot send a message because you have blocked this user.');
                          }
                        },
                        icon: Image.asset(
                          "assets/icons/facetime-button.png",
                          scale: 21,
                        )),
                    if(controller.chatService.isRemoteBlock.value == true)
                      SizedBox()
                    else
                      PopupMenuButton<String>(
                        icon: Image.asset(
                          "assets/icons/more.png",
                          height: 25,
                        ),
                        itemBuilder: (BuildContext context) {
                          bool blocked =  controller.chatService.isBlockedUser.value;
                          return {
                            !blocked ? 'Block' : "Unblock",
                          }.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                              onTap: () {
                                if (!blocked) {
                                  controller.chatService.blockUser(
                                      controller.currentUserID.value,
                                      controller.otherUserID.value
                                  );
                                  Get.back();
                                  // controller.chatService.getMessages(controller.currentUserID.value,controller.otherUserID.value,controller.scrollController);
                                  // controller.chatService.isUserBlocked(controller.currentUserID.value,controller.otherUserID.value);
                                } else {
                                  controller.chatService.unblockUser(
                                      controller.currentUserID.value,
                                      controller.otherUserID.value);
                                  // controller.chatService.getMessages(controller.currentUserID.value,controller.otherUserID.value,controller.scrollController);
                                  // controller.chatService.isUserBlocked(controller.currentUserID.value,controller.otherUserID.value);
                                  Get.back();
                                }
                              },
                            );
                          }).toList();
                        },
                      ),

                  ],
                )
              ],
            ),
          ),
          centerTitle: false,
        ),
        body: Obx(
          () => Column(
            children: [
              Expanded(
                child: StreamBuilder<List<Message>>(
                  stream: controller.chatService.getMessages(
                      controller.currentUserID.value,
                      controller.otherUserID.value,
                      controller.scrollController),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: ShowLoader.isLoadingProgress(true));
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(''),
                      );
                    }
                    // if (snapshot.hasData) {
                    //   return Center(
                    //     child: NoDataFound(height: MediaQuery.of(context).size.height/2,),
                    //   );
                    // }
                    List<Message>? messages = snapshot.data;

                    return ListView.builder(
                      reverse: false,
                      controller: controller.scrollController,
                      shrinkWrap: true,
                      // padding: EdgeInsets.only(top: 10,bottom: 10),
                      itemCount: messages!.length,
                      itemBuilder: (context, index) {
                        Message message = messages[index];
                        print("messages $message");
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: (message.senderId ==
                                    controller.currentUserID.value)
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context)
                                            .size
                                            .width *
                                        0.75), // Ensure the message container doesn't exceed 75% of the screen width
                                padding: message.message.isEmpty
                                    ? const EdgeInsets.all(0)
                                    : const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: message.senderId ==
                                          controller.currentUserID.value
                                      ? AppStyles.appThemeColor
                                      : AppStyles.TextformfeildOutlineColo,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(message.senderId ==
                                            controller.currentUserID.value
                                        ? 10
                                        : 0),
                                    topRight: const Radius.circular(10),
                                    bottomLeft: const Radius.circular(10),
                                    bottomRight: Radius.circular(
                                        message.senderId ==
                                                controller.currentUserID.value
                                            ? 0
                                            : 10),
                                  ),
                                ),
                                child: message.message.isEmpty
                                    ? const SizedBox()
                                    : Textwidget(
                                        text: message.message,
                                        color: message.senderId ==
                                                controller.currentUserID.value
                                            ? Colors.white
                                            : Colors.black,
                                        maxLines: 20,
                                        fontSize: 16,
                                      ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              if (message.images.isNotEmpty)
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.75,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      // color: message.senderId == controller.currentUserID.value
                                      //     ? AppStyles.appThemeColor
                                      //     : AppStyles.TextformfeildOutlineColo,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(message
                                                    .senderId ==
                                                controller.currentUserID.value
                                            ? 10
                                            : 0),
                                        topRight: const Radius.circular(10),
                                        bottomLeft: const Radius.circular(10),
                                        bottomRight: Radius.circular(message
                                                    .senderId ==
                                                controller.currentUserID.value
                                            ? 0
                                            : 10),
                                      ),
                                      border: Border.all(
                                          color: AppStyles.appThemeColor)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount:
                                              message.images.length == 1
                                                  ? 1
                                                  : 2,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 5,
                                        ),
                                        itemCount: message.images.length,
                                        itemBuilder: (context, imageIndex) {
                                          return InkWell(
                                            onTap: () {
                                              Get.to(
                                                  PhotoViewMaidDetailsView(
                                                    photos: message.images,
                                                    index: imageIndex,
                                                    isfirebaseImage: true,
                                                  ),
                                                  transition: Transition
                                                      .rightToLeftWithFade);
                                            },
                                            child: Image.network(
                                              message.images[imageIndex],
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: (message.senderId ==
                                    controller.currentUserID.value)
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Textwidget(
                                  text: controller
                                      .readTimestamp(message.timestamp),
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Obx(() {
                return controller.chatService.selectedImages.isNotEmpty
                    ? SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              controller.chatService.selectedImages.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.file(
                                  controller.chatService.selectedImages[index]),
                            );
                          },
                        ),
                      )
                    : Container();
              }),
              Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Flexible(
                            child: TextFieldDesignedforchatScreen(
                          keyboardType: TextInputType.text,
                          controller: controller.messageController.value,
                          focusNode: controller.focusNode.value,
                          // prefixIcon: IconButton(
                          //   onPressed: () {
                          //     controller.toggleEmojiPicker();
                          //   },
                          //   icon: Image.asset(
                          //     "assets/icons/emojyIcon.png",
                          //     scale: 2.8,
                          //   ),
                          // ),
                          prefixIcon: IconButton(
                              onPressed: () {
                                if(controller.chatService.isRemoteBlock.value == true){
                                  Fluttertoast.showToast(msg: 'You cannot send a message because you are blocked!');
                                }else{
                                  controller.chatService.pickImage();
                                }
                              },
                              icon: const Icon(Icons.camera_alt)

                              // Image.asset(
                              //   "assets/icons/Cemeraicon.png",
                              //   scale: 2.2,
                              // )

                              ),
                          hintText: "Type a message ...",
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Obx(() => CircleAvatar(
                            radius: 25,
                            backgroundColor: AppStyles.appThemeColor,
                            child: controller.chatService.loading.isFalse
                                ? IconButton(
                                    onPressed: () async {
                                      String messageText = controller.messageController.value.text;

                                      bool blocked = controller.chatService.isBlockedUser.value;

                                      // Regular expressions to detect phone numbers and email addresses
                                      RegExp phoneRegex = RegExp(r'(\+?\d{1,4}[\s-])?(?!0+\s+,?$)\d{8,13}');
                                      RegExp emailRegex = RegExp(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}');
                                      RegExp numberRegex = RegExp(r'^\d{1,7}$'); // For checking numbers with at most 7 digits

                                      List<String> imageUrls = [];
                                      if (controller.chatService.selectedImages.isNotEmpty) {
                                        imageUrls = await controller.chatService.uploadImages(controller.chatService.selectedImages);
                                        controller.chatService.selectedImages.clear();
                                      }

                                      log("Image array -- $imageUrls");

                                      if(controller.chatService.isRemoteBlock.value == true){
                                        Fluttertoast.showToast(msg: 'You cannot send a message because you are blocked!');
                                      }else{
                                        if (messageText.isEmpty && imageUrls.isEmpty) {
                                          ToastClass.showToast("Please write a message ...");
                                        } else if (phoneRegex.hasMatch(messageText) || emailRegex.hasMatch(messageText)) {
                                          Fluttertoast.showToast(msg: 'Sending personal information or taking cash is a violation and the profile will be removed');
                                          controller.vibrate();
                                          // ToastClass.showToast("Sending personal information or taking cash is a violation and the profile will be removed");
                                        } else {
                                          controller.chatService.sendMessage(controller.currentUserID.value,
                                            "${controller.currentUserFName.value} ${controller.currentUserLName.value}",
                                            controller.otherUserID.value,
                                            controller.messageController.value.text,
                                            controller.scrollController,
                                            imageUrls,
                                          );
                                          controller.messageController.value.clear();
                                        }
                                      }
                                    },
                                    icon: Image.asset(
                                      controller.icon2.value.toString(),
                                      scale: 4.5,
                                    ))
                                : const CircularProgressIndicator(
                                    color: Colors.white,
                                  )

                            // controller.messageController.value.text.isEmpty
                            //     ? IconButton(
                            //     onPressed: () {},
                            //     icon: Image.asset(
                            //       controller.icon1.toString(),
                            //       scale: 4.5,
                            //     ))
                            //     : IconButton(
                            //     onPressed: () {
                            //       controller.sendMessage(
                            //           controller.currentUserID.value,
                            //           controller.otherUserID.value,
                            //           controller.messageController.value.text
                            //       );
                            //       controller.messageController.value.clear();
                            //     },
                            //     icon: Image.asset(
                            //       controller.icon2.value.toString(),
                            //       scale: 4.5,
                            //     )
                            // )
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
