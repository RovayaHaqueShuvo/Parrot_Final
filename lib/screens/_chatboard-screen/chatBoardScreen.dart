import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:parrot_messaging/getX/_screenManagement.dart';
import 'package:parrot_messaging/screens/_userProfile-screen/_userProfileSetting.dart';
import '../../_gobal-supply/_loggedUser.dart';
import '../../getX/_chatServiceGetX.dart';
import '../../getX/_userPresenceService.dart';
import '../../globalWidget/_customWidget.dart';
import '_chatBarStyleGlobalUser.dart';
import '_chatBarStyleLoggedUser.dart';

class ChatController extends GetxController {
  final TextEditingController chatsTextController = TextEditingController();
  final ChatService chatService = Get.put(ChatService());
  final UserPresenceService presenceService = Get.put(UserPresenceService());

  @override
  void onClose() {
    chatsTextController.dispose();
    super.onClose();
  }

  void sendMessage(String otherUserId) {
    if (chatsTextController.text.trim().isNotEmpty) {
      chatService.sendMessage(otherUserId, chatsTextController.text.trim());
      chatsTextController.clear();
    }
  }
}

class Chatboardscreen extends StatelessWidget {
  final Map<String, dynamic> userData; // Map নিলাম
  const Chatboardscreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.put(ChatController());
    final CurrentLoggedUser controllerCurrentLogged = Get.put(CurrentLoggedUser());


    //Map থেকে সব value বের করা
    final _uid = userData['UID'] is String ? userData['UID'].toString() : (userData['UID']?['id'] ?? '').toString();
    final _name = userData['NAME'] is String ? userData['NAME'].toString() : 'Unknown';
    final _email = userData['EMAIL'] is String ? userData['EMAIL'].toString() : '';
    final _photoUrl = userData['PHOTO_URL'] is String ? userData['PHOTO_URL'].toString() : '';



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
            onTap: (){
              Get.to(() => UserProfileSetting(
                isCurrentUser: false,
                golbeUserName: _name,
                golbeUserUID: _uid,
                golbeUserEmail: _email,
                golbeUserPhotoURL: _photoUrl,
                golbeUserActiveStues: true,
              ));
            },
            child: Row(
              children: [
                // ✅ Profile Picture Placeholder
                NetworkImages(imageName: _photoUrl, size: 45),
                const SizedBox(width: 10),
                // ✅ Dynamic Name + Presence
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(_email)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Text("Loading...",
                          style: TextStyle(color: Colors.white));
                    }

                    final status =
                    controller.presenceService.getStatusFromSnapshot(
                        snapshot.data!);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, ),
                        ),
                        Text(
                          status == 'online' ? 'Online' : 'Offline',
                          style: TextStyle(
                            fontSize: 14,
                            color: status == 'online'
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
                onPressed: () {
                  print("User UID: $_uid");
                  print("User Name: $_name");
                  print("User Email: $_email");
                  print("User Photo: $_photoUrl");
                }, icon: const Icon(Icons.call, color: Colors.white)),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.videocam, color: Colors.white)),
          ],
        ),
        body: Column(
          children: [
            // ✅ Messages Stream
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: controller.chatService.getMessages(_email),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final messages = snapshot.data!.docs;

                  // 🔥 Unread Count বের করা
                  final unreadCount = messages
                      .where((msg) =>
                  msg['receiverId'] ==
                      controller.chatService.currentUserId.value &&
                      msg['read'] == false)
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
                            final msg =
                            messages[index].data() as Map<String, dynamic>;
                            final isMe = msg['senderId'] ==
                                controller.chatService.currentUserId.value;

                            // ✅ যদি আমি receiver হই, তখন read = true update করে দেবে
                            if (!isMe && msg['read'] == false) {
                              messages[index].reference.update({'read': true});
                            }

                            return Row(
                              mainAxisAlignment: isMe
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                isMe
                                    ? ChatBarStyleLogedUser(
                                    userPhoto: controllerCurrentLogged.photourl.value,
                                    massage: msg['message'])
                                    : ChatBarStyleGlobalUser(
                                    userPhoto: _photoUrl,
                                    massage: msg['message']),
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

            // ✅ Input Bar
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: BottomAppBar(
                color: const Color(0xFF012B0D),
                child: Row(
                  children: [
                    IconButton(
                        icon: const Icon(Icons.attach_file_outlined,
                            color: Colors.white),
                        onPressed: () {}),
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
                              horizontal: 12, vertical: 8),
                        ),
                      ),
                    ),
                    IconButton(
                        icon: const Icon(Icons.send, color: Colors.blue),
                        onPressed: () =>
                            controller.sendMessage(_email)),
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
