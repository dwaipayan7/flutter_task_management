class UserModel {
  final String id;
  final String name;
  final String email;
  final String token;
  final String password;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    required this.password,
  });

  // Convert a UserModel instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'token': token,
      'password': password,
    };
  }

  // Create a UserModel instance from a JSON object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      token: json['token'],
      password: json['password'],
    );
  }

  // Override toString for better debugging and logging
  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email, token: $token, password: $password}';
  }
}
