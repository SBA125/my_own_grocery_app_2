import 'package:cloud_firestore/cloud_firestore.dart';
class Location {
  final String userID;
  final double latitude;
  final double longitude;
  final DateTime timestamp;

  Location({
    required this.userID,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  factory Location.fromMap(Map<String, dynamic> data) {
    return Location(
      userID: data['userID'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp,
    };
  }
}


