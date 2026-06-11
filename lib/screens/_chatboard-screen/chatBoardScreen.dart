import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:parrot_messaging/Utills/_constant.dart';

import 'package:parrot_messaging/screens/_userProfile-screen/_userProfileSetting.dart';
import '../../_Firebase_ChatService/Chat_Model_Class/_massageModel.dart';
import '../../firebase-Database/FirebaseDataBase.dart';
import '../../_Firebase_ChatService/_chatServiceGetX.dart';

import '../../getX/_userPresenceService.dart';
import '../../globalWidget/_customWidget.dart';
import '_chatBarStyleGlobalUser.dart';
import '_chatBarStyleLoggedUser.dart';

class ChatController extends GetxController {
  final TextEditingController chatsTextController = TextEditingController();
  final ChatService chatService = Get.put(ChatService());
  final UserPresenceService presenceService = Get.put(UserPresenceService());

  final String otherUserId;
  late final String chatId;

  ChatController({required this.otherUserId});

  @override
  void onInit() {
    super.onInit();
    // Chat screen এ ঢুকলে presence set করো
    chatId = chatService.getChatId(
      chatService.currentUserId.value,
      otherUserId,
    );
    chatService.enterChat(chatId);
    // সব unread message read করে দাও
    chatService.markMessagesAsRead(otherUserId);
  }

  @override
  void onClose() {
    chatsTextController.dispose();
    // Chat screen থেকে বের হলে presence clear করো
    chatService.leaveChat();
    super.onClose();
  }

  void sendMessage() {
    if (chatsTextController.text.trim().isNotEmpty) {
      chatService.sendMessage(
        receiverId: otherUserId,
        text: chatsTextController.text.trim(),
      );
      chatsTextController.clear();
    }
  }
}

class Chatboardscreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  const Chatboardscreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    // uid আগে বের করো — ChatController constructor এ দরকার
    final String uid =
        userData['UID'] is String
            ? userData['UID'].toString()
            : (userData['UID']?['id'] ?? '').toString();
    final String name =
        userData['NAME'] is String ? userData['NAME'].toString() : 'Unknown';
    final String email =
        userData['EMAIL'] is String ? userData['EMAIL'].toString() : '';
    final String photoUrl =
        userData['PHOTO_URL'] is String ? userData['PHOTO_URL'].toString() : '';

    // uid constructor এ pass করো — onInit() এর আগেই set হবে
    final ChatController controller = Get.put(
      ChatController(otherUserId: uid),
      tag: uid,
    );
    final FirebaseDataBase controllerCurrentLogged = Get.put(
      FirebaseDataBase(),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color(0xFF1D4321),
          leading: IconButton(
            onPressed: Get.back,
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: InkWell(
            onTap: () {
              Get.to(
                () => UserProfileSetting(
                  isCurrentUser: false,
                  golbeUserName: name,
                  golbeUserUID: uid,
                  golbeUserEmail: email,
                  golbeUserPhotoURL: photoUrl,
                  golbeUserActiveStues: true,
                ),
              );
            },
            child: Row(
              children: [
                NetworkImages(imageName: photoUrl, size: 45),
                const SizedBox(width: 10),
                StreamBuilder<DocumentSnapshot>(
                  stream:
                      FirebaseFirestore.instance
                          .collection(USER_DETAILS)
                          .doc(uid)
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Text(
                        "Loading...",
                        style: TextStyle(color: Colors.white),
                      );
                    }
                    final status = controller.presenceService
                        .getStatusFromSnapshot(snapshot.data!);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          status == 'online' ? 'Online' : 'Offline',
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                status == 'online'
                                    ? Colors.greenAccent
                                    : Colors.grey,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.call, color: Colors.white),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.videocam, color: Colors.white),
            ),
          ],
        ),
        body: Column(
          children: [
            // ─── Messages Stream (MessageModel list) ───────────────────
            Expanded(
              child: StreamBuilder<List<MessageModel>>(
                stream: controller.chatService.getMessages(uid),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final messages = snapshot.data!;

                  // Unread count (isRead field ব্যবহার)
                  final unreadCount =
                      messages
                          .where(
                            (msg) =>
                                msg.senderId !=
                                    controller
                                        .chatService
                                        .currentUserId
                                        .value &&
                                !msg.isRead,
                          )
                          .length;

                  return Column(
                    children: [
                      if (unreadCount > 0)
                        Container(
                          padding: const EdgeInsets.all(6),
                          margin: const EdgeInsets.only(top: 8, bottom: 4),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "$unreadCount Unread Messages",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      Expanded(
                        child: ListView.builder(
                          reverse: true,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final MessageModel msg = messages[index];
                            final bool isMe =
                                msg.senderId ==
                                controller.chatService.currentUserId.value;

                            // Time format করা (MessageModel.timestamp থেকে)
                            final DateTime dateTime = msg.timestamp.toDate();
                            final String formattedTime =
                                '${dateTime.hour.toString().padLeft(2, '0')}:'
                                '${dateTime.minute.toString().padLeft(2, '0')}';

                            return Row(
                              mainAxisAlignment:
                                  isMe
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                              children: [
                                isMe
                                    ? ChatBarStyleLogedUser(
                                      userPhoto:
                                          controllerCurrentLogged
                                              .photourl
                                              .value,
                                      massage: msg.text, // 'message' → 'text'
                                      sentTime: formattedTime,
                                    )
                                    : ChatBarStyleGlobalUser(
                                      userPhoto: photoUrl,
                                      massage: msg.text, // 'message' → 'text'
                                      sentTime: formattedTime,
                                    ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // ─── Input Bar ─────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: BottomAppBar(
                color: const Color(0xFF012B0D),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.attach_file_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller.chatsTextController,
                        maxLines: 2,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Type a message...",
                          hintStyle: const TextStyle(color: Colors.white54),
                          filled: true,
                          fillColor: Colors.white12,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.blue),
                      onPressed: controller.sendMessage,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
