class UserModel {
  final String email;
  final String name;
  final String photoUrl;
  final String uid;
  final bool isActive; // 🔥 new field

  UserModel({
    required this.email,
    required this.name,
    required this.photoUrl,
    required this.uid,
    required this.isActive,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      email: data['EMAIL'] ?? "",
      name: data['NAME'] ?? "",
      photoUrl: data['PHOTO_URL'] ?? "",
      uid: data['UID'] ?? "",
      isActive: data['isActive'] ?? false, // 🔥 default false
    );
  }
}

