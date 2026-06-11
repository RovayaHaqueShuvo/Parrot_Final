import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String chatId;
  final List<String> participants;
  final String lastMessage;
  final Timestamp lastMessageTime;
  final Timestamp createdAt;
  final String type; // "one_to_one" or "group"

  ChatModel({
    required this.chatId,
    required this.participants,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.createdAt,
    required this.type,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map, String id) {
    return ChatModel(
      chatId: id,
      participants: List<String>.from(map['participants']),
      lastMessage: map['lastMessage'] ?? '',
      lastMessageTime: map['lastMessageTime'] ?? Timestamp.now(),
      createdAt: map['createdAt'] ?? Timestamp.now(),
      type: map['type'] ?? 'one_to_one',
    );
  }
}