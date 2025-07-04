class UserEntity {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? profilePicture;
  final String token;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.profilePicture,
    required this.token,
  });
}