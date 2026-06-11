import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:parrot_messaging/Utills/_constant.dart';
import 'Chat_Model_Class/_chatModel.dart';
import 'Chat_Model_Class/_massageModel.dart';

class ChatService extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxString currentUserId =
      FirebaseAuth.instance.currentUser!.email!.obs;

  // ─── Chat ID তৈরি ────────────────────────────────────────────────────────

  String getChatId(String user1Id, String user2Id) {
    return user1Id.compareTo(user2Id) < 0
        ? '${user1Id}_${user2Id}'
        : '${user2Id}_${user1Id}';
  }

  // ─── Presence Tracking ───────────────────────────────────────────────────

  /// Chat screen এ ঢুকলে call করুন
  Future<void> enterChat(String chatId) async {
    await _firestore
        .collection('users')
        .doc(currentUserId.value)
        .update({'activeChat': chatId});
  }

  /// Chat screen থেকে বের হলে call করুন
  Future<void> leaveChat() async {
    await _firestore
        .collection('users')
        .doc(currentUserId.value)
        .update({'activeChat': null});
  }

  // ─── Message পাঠানো ──────────────────────────────────────────────────────

  Future<void> sendMessage({
    required String receiverId,
    required String text,
    String? imageUrl,
    String type = 'text',
  }) async {
    try {
      final chatId = getChatId(currentUserId.value, receiverId);
      final now = Timestamp.now();

      // Message document তৈরি
      final messageRef = _firestore
          .collection(CHATS)
          .doc(chatId)
          .collection(MESSAGES)
          .doc();

      final messageData = {
        'messageId': messageRef.id,
        'senderId': currentUserId.value,
        'receiverId': receiverId,
        'text': text,
        if (imageUrl != null) 'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
        'isRead': false,
        'type': type,
      };

      // Chat room document update (lastMessage, lastMessageTime)
      final chatData = {
        'chatId': chatId,
        'participants': [currentUserId.value, receiverId],
        'lastMessage': type == 'text' ? text : '📷 Image',
        'lastMessageTime': now,
        'type': 'one_to_one',
      };

      // Batch write — message ও chat room একসাথে update
      final batch = _firestore.batch();
      batch.set(messageRef, messageData);
      batch.set(
        _firestore.collection(CHATS).doc(chatId),
        chatData,
        SetOptions(merge: true),
      );
      await batch.commit();
    } catch (e) {
      Get.snackbar('Error', 'Failed to send message: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // ─── Messages real-time stream (MessageModel list) ───────────────────────

  Stream<List<MessageModel>> getMessages(String otherUserId) {
    final chatId = getChatId(currentUserId.value, otherUserId);
    return _firestore
        .collection(CHATS)
        .doc(chatId)
        .collection(MESSAGES)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => MessageModel.fromMap(doc.data(), doc.id))
        .toList());
  }

  // ─── Current user এর সকল Chat list (ChatModel list) ─────────────────────

  Stream<List<ChatModel>> getMyChats() {
    return _firestore
        .collection(CHATS)
        .where('participants', arrayContains: currentUserId.value)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => ChatModel.fromMap(doc.data(), doc.id))
        .toList());
  }

  // ─── Chat Room তৈরি বা খোঁজা ─────────────────────────────────────────────

  Future<ChatModel> getOrCreateChat(String otherUserId) async {
    final chatId = getChatId(currentUserId.value, otherUserId);
    final chatRef = _firestore.collection(CHATS).doc(chatId);
    final chatDoc = await chatRef.get();

    if (chatDoc.exists) {
      return ChatModel.fromMap(chatDoc.data()!, chatDoc.id);
    }

    // নতুন chat room তৈরি
    final now = Timestamp.now();
    final newChatData = {
      'participants': [currentUserId.value, otherUserId],
      'lastMessage': '',
      'lastMessageTime': now,
      'createdAt': now,
      'type': 'one_to_one',
    };

    await chatRef.set(newChatData);
    return ChatModel.fromMap(newChatData, chatId);
  }

  // ─── Message পড়া (isRead update) ─────────────────────────────────────────

  Future<void> markMessagesAsRead(String otherUserId) async {
    final chatId = getChatId(currentUserId.value, otherUserId);

    final unreadMessages = await _firestore
        .collection(CHATS)
        .doc(chatId)
        .collection(MESSAGES)
        .where('senderId', isEqualTo: otherUserId)
        .where('isRead', isEqualTo: false)
        .get();

    if (unreadMessages.docs.isEmpty) return;

    final batch = _firestore.batch();
    for (final doc in unreadMessages.docs) {
      batch.update(doc.reference, {'isRead': true});
    }
    await batch.commit();
  }

  // ─── Unread message count ─────────────────────────────────────────────────

  Stream<int> getUnreadCount(String otherUserId) {
    final chatId = getChatId(currentUserId.value, otherUserId);
    return _firestore
        .collection(CHATS)
        .doc(chatId)
        .collection(MESSAGES)
        .where('senderId', isEqualTo: otherUserId)
        .where('isRead', isEqualTo: false)
        .snapshots()
        .map((snap) => snap.docs.length);
  }

  // ─── Single ChatModel fetch ───────────────────────────────────────────────

  Future<ChatModel?> getChatById(String chatId) async {
    final doc = await _firestore.collection(CHATS).doc(chatId).get();
    if (!doc.exists) return null;
    return ChatModel.fromMap(doc.data()!, doc.id);
  }
}
