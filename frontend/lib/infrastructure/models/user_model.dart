class UserModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String role;
  final String profilePicture; // Default empty profile picture

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.profilePicture,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      role: map['role'],
      profilePicture: map['profilePicture'] ?? "", // Handle optional profile picture
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "password": password,
      "role": role,
      "profilePicture": profilePicture,
    };
  }
}