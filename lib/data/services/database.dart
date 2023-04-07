import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  Future updateUserData(
    String id,
    String userName,
    String email,
    String password,
    String fullName,
    String dateOfBirth,
    String phoneNumber,
    String country,
    String province,
    String city,
    String school,
    bool expert,
    double latitude,
    double longtitude,
  ) async {
    return await usersCollection.doc(uid).set(
      {
        'id': uid,
        'userName': userName,
        'email': email,
        'password': password,
        'fullName': fullName,
        'dateOfBirth': dateOfBirth,
        'phoneNumber': phoneNumber,
        'country': country,
        'province': province,
        'city': city,
        'school': school,
        'expert': expert,
        'latitude': latitude,
        'longtitude': longtitude,
      },
    );
  }
}
