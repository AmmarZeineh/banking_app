class User {
  final int id;
  final String name;
  final String email;
  final String nationalId;
  final bool isEmailVerified;
  final int roleId;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.nationalId,
    required this.isEmailVerified,
    required this.roleId,
  });
}
