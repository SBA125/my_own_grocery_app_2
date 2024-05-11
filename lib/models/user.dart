class User {
  final String id;
  final String name;
  final String email;
  final String password;
  // Add more fields as needed

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    // Add more fields as needed
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        password: json['password'] as String
        // Add more fields as needed
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      // Add more fields as needed
    };
  }
}
