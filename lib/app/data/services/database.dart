import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference inforCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(
      String userName,
      String email,
      String password,
      String fullName,
      String dateOfBirth,
      String phoneNumber,
      String country,
      String province,
      String city,
      String school) async {
    return await inforCollection.doc(uid).set(
      {
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
      },
    );
  }
}
