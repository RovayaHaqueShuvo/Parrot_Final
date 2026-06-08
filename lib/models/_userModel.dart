import '../Utills/_constant.dart';

class UserModel {
  final String uid;

  // Basic Info
  final String name;
  final String email;
  final String phoneNumber;
  final String photoUrl;

  // Auth Provider
  final String loginType;

  // Profile
  final String bio;
  final String username;

  // Status
  final bool isOnline;
  final bool isActive;
  final bool isVerified;

  // 🔥 PRIVACY SETTINGS (NEW)
  final HideUser hideUserOption;
  final ActiveStatus activeStatusOption;

  // System
  final DateTime createdAt;
  final DateTime lastSeen;
  final DateTime updatedAt;

  // Chat features
  final List<String> friends;
  final List<String> blockedUsers;

  // Notification
  final String pushToken;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.photoUrl,
    required this.loginType,
    required this.bio,
    required this.username,
    required this.isOnline,
    required this.isActive,
    required this.isVerified,

    // 🔥 NEW
    required this.hideUserOption,
    required this.activeStatusOption,

    required this.createdAt,
    required this.lastSeen,
    required this.updatedAt,
    required this.friends,
    required this.blockedUsers,
    required this.pushToken,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'] ?? "",
      name: data['name'] ?? "",
      email: data['email'] ?? "",
      phoneNumber: data['phoneNumber'] ?? "",
      photoUrl: data['photoUrl'] ?? "",
      loginType: data['loginType'] ?? "",

      bio: data['bio'] ?? "Hey there 👋",
      username: data['username'] ?? "",

      isOnline: data['isOnline'] ?? false,
      isActive: data['isActive'] ?? true,
      isVerified: data['isVerified'] ?? false,

      // 🔥 ENUM 1
      hideUserOption: HideUser.values.firstWhere(
            (e) => e.toString() == data['hideUserOption'],
        orElse: () => HideUser.nobody,
      ),

      // 🔥 ENUM 2
      activeStatusOption: ActiveStatus.values.firstWhere(
            (e) => e.toString() == data['activeStatusOption'],
        orElse: () => ActiveStatus.everyone,
      ),

      createdAt: DateTime.parse(data['createdAt']),
      lastSeen: DateTime.parse(data['lastSeen']),
      updatedAt: DateTime.parse(data['updatedAt']),

      friends: List<String>.from(data['friends'] ?? []),
      blockedUsers: List<String>.from(data['blockedUsers'] ?? []),

      pushToken: data['pushToken'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "photoUrl": photoUrl,
      "loginType": loginType,
      "bio": bio,
      "username": username,
      "isOnline": isOnline,
      "isActive": isActive,
      "isVerified": isVerified,

      // 🔥 ENUM 1
      "hideUserOption": hideUserOption.toString(),

      // 🔥 ENUM 2
      "activeStatusOption": activeStatusOption.toString(),

      "createdAt": createdAt.toIso8601String(),
      "lastSeen": lastSeen.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),

      "friends": friends,
      "blockedUsers": blockedUsers,
      "pushToken": pushToken,
    };
  }
}