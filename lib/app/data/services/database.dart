import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference inforCollection =
      FirebaseFirestore.instance.collection('roads');

  Future updateUserData(String sugars, String name, int strength) async {
    return await inforCollection.doc(uid).set(
      {
        'sugars': sugars,
        'name': name,
        'strength': strength,
      },
    );
  }
}
