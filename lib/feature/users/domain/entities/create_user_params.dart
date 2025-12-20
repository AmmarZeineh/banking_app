class CreateUserParams {
  final String email;
  final String name;
  final String password;
  final int roleId;
  final String nationalId;

  CreateUserParams({
    required this.email,
    required this.name,
    required this.password,
    required this.roleId,
    required this.nationalId,
  });

  Map<String, Object> toJson() => {
    'email': email,
    'name': name,
    'password': password,
    'roleId': roleId,
    'nationalID': nationalId,
  };
}
