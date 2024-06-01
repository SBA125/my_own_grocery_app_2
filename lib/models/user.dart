class User {
  final String userID;
  final String username;
  final String email;
  final String role;

  User({
    required this.userID,
    required this.username,
    required this.email,
    required this.role,
  });

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      userID: data['userID'],
      username: data['username'],
      email: data['email'],
      role: data['role'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'username': username,
      'email': email,
      'role': role,
    };
  }
}
