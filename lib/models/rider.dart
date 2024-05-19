class Rider {
  final String riderID;
  final String userID;
  // Add other rider-specific fields as needed

  Rider({
    required this.riderID,
    required this.userID,
  });

  factory Rider.fromMap(Map<String, dynamic> data) {
    return Rider(
      riderID: data['riderID'],
      userID: data['userID'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'riderID': riderID,
      'userID': userID,
    };
  }
}
