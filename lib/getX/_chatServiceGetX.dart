import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:parrot_messaging/Utills/_constant.dart';

class ChatService extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxString currentUserId = FirebaseAuth.instance.currentUser!.email!.obs;

  // Message পাঠানো
  Future<void> sendMessage(String receiverId, String message) async {
    try {
      final chatId = getChatId(currentUserId.value, receiverId);
      await _firestore
          .collection(CHATS)
          .doc(chatId)
          .collection(MESSAGES)
          .add({
        'senderId': currentUserId.value,
        'receiverId': receiverId,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
        'read': false,
      });
      print('Message sent successfully');
    } catch (e) {
      print('Error sending message: $e');
      Get.snackbar('Error', 'Failed to send message: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Chat ID তৈরি
  String getChatId(String user1Id, String user2Id) {
    return user1Id.compareTo(user2Id) < 0
        ? '${user1Id}_${user2Id}'
        : '${user2Id}_${user1Id}';
  }

  // Messages real-time পড়া
  Stream<QuerySnapshot> getMessages(String otherUserId) {
    final chatId = getChatId(currentUserId.value, otherUserId);
    return _firestore
        .collection(CHATS)
        .doc(chatId)
        .collection(MESSAGES)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}