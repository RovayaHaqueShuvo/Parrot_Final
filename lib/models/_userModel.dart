class UserModel {
  final String email;
  final String name;
  final String photoUrl;
  final String uid;

  UserModel({
    required this.email,
    required this.name,
    required this.photoUrl,
    required this.uid,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      email: data['EMAIL'] ?? "",
      name: data['NAME'] ?? "",
      photoUrl: data['PHOTO_URL'] ?? "",
      uid: data['UID'] ?? "",
    );
  }
}
