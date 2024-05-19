class Admin {
  final String adminID;
  final String userID;

  Admin({
    required this.adminID,
    required this.userID,
  });

  factory Admin.fromMap(Map<String, dynamic> data) {
    return Admin(
      adminID: data['adminID'],
      userID: data['userID'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'adminID': adminID,
      'userID': userID,
    };
  }
}
