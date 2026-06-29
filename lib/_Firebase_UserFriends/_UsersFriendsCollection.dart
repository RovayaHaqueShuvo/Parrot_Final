import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parrot_messaging/Utills/_constant.dart';

class UsersFriendsCollection {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentUseremailId = FirebaseAuth.instance.currentUser!.email;
  final currentUseruid = FirebaseAuth.instance.currentUser!.uid;

  Future<List<String>> userFriends() async {
    List<String> otherUserIds = [];

    try {
      print("Current UID: $currentUseruid");

      // Query 1: UID দিয়ে
      final query1 =
          await _firestore
              .collection(CHATS)
              .where('participants', arrayContains: currentUseruid)
              .get();

      // Query 2: Email দিয়ে (যদি ব্যবহার করো)
      final query2 =
          await _firestore
              .collection(CHATS)
              .where('participants', arrayContains: currentUseremailId)
              .get();

      final allDocs = {...query1.docs, ...query2.docs};

      for (var doc in allDocs) {
        final data = doc.data();

        if (data['participants'] is List) {
          List participants = data['participants'];

          for (var participant in participants) {
            if (participant != null &&
                participant != currentUseruid &&
                participant != currentUseremailId &&
                participant is String &&
                participant.isNotEmpty) {
              if (!otherUserIds.contains(participant)) {
                otherUserIds.add(participant);
              }
            }
          }
        }
      }

      // ====================== FRIEND LIST UPDATE ======================
      if (otherUserIds.isNotEmpty) {
        final userRef = _firestore.collection(USER_DETAILS).doc(currentUseruid);

        await userRef.update({
          "friends": otherUserIds, // Friend list এ অ্যাড
          "updatedAt": DateTime.now().toIso8601String(),
        });

        print("✅ Friends List Updated in Firestore!");
      }
      // ============================================================

      print("✅ Total Friends found: ${otherUserIds.length}");
      print("Friends: $otherUserIds");

      return otherUserIds;
    } catch (e) {
      print("❌ Error: $e");
      return [];
    }
  }
}
