import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'dart:async';

class UserPresenceService extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxString userId = (FirebaseAuth.instance.currentUser?.email?? 'anonymous').obs;
  Timer? _heartbeatTimer;

  @override
  void onInit() {
    super.onInit();
    startHeartbeat(); // App শুরু হলে heartbeat চালু
  }

  @override
  void onClose() {
    stopHeartbeat(); // App বন্ধ হলে heartbeat বন্ধ
    super.onClose();
  }

  void startHeartbeat() {
    _updateLastActive();
    _heartbeatTimer = Timer.periodic(Duration(minutes: 2), (timer) {
      _updateLastActive();
    });
  }

  Future<void> _updateLastActive() async {
    try {
      await _firestore.collection('users').doc(userId.value).set({
        'lastActive': FieldValue.serverTimestamp(),
        'status': 'online',
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error updating heartbeat: $e');
      Get.snackbar('Error', 'Failed to update presence: $e');
    }
  }

  void stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _firestore.collection('users').doc(userId.value).update({'status': 'offline'});
  }

  Stream<DocumentSnapshot> getUserStatus(String otherUserId) {
    return _firestore.collection('users').doc(otherUserId).snapshots();
  }

  String getStatusFromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>?;
    final lastActive = data?['lastActive'] as Timestamp?;
    if (lastActive == null) return 'offline';
    final now = DateTime.now();
    final diff = now.difference(lastActive.toDate()).inMinutes;
    return diff < 2 ? 'online' : 'offline';
  }
}