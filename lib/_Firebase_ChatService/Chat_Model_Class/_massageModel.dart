import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String messageId;
  final String senderId;
  final String text;
  final String? imageUrl;
  final Timestamp timestamp;
  final bool isRead;
  final String type; // text, image, video, call

  MessageModel({
    required this.messageId,
    required this.senderId,
    required this.text,
    this.imageUrl,
    required this.timestamp,
    required this.isRead,
    required this.type,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map, String id) {
    return MessageModel(
      messageId: id,
      senderId: map['senderId'],
      text: map['text'] ?? '',
      imageUrl: map['imageUrl'],
      timestamp: map['timestamp'] ?? Timestamp.now(),
      isRead: map['isRead'] ?? false,
      type: map['type'] ?? 'text',
    );
  }
}