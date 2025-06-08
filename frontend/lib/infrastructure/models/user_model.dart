class UserModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String role;
  final String profilePicture;
  final String token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.profilePicture,
    required this.token,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    if (!map.containsKey('id') || !map.containsKey('token')) {
      throw Exception("Invalid API response: Missing required fields.");
    }

    return UserModel(
      id: map['id'],
      name: map['name'],  // ✅ Handle missing name
      email: map['email'],
      password: map.containsKey('password') ? map['password'] : '',
      role: map['role'] ?? 'user',
      profilePicture: map['profilePicture'] ?? 'default.png',
      token: map['token'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'profilePicture': profilePicture,
      'token': token,
    };
  }
}