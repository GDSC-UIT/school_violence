import 'package:cloud_firestore/cloud_firestore.dart';

class Emergency {
  final CollectionReference emergencyCollection =
      FirebaseFirestore.instance.collection('emergency');
  List _friendId = [];
  Future<void> needHelp(
    String userId,
    String friendId,
  ) async {
    DocumentSnapshot snap = await emergencyCollection.doc(friendId).get();
    if (snap.data() != null) {
      _friendId = (snap.data()! as dynamic)['friendId'];
    } else
      _friendId = [];
    _friendId.add(userId);
    return await emergencyCollection.doc(friendId).set(
      {
        'friendId': _friendId,
      },
    );
  }

  Future<void> resetData(String userId) async {
    return await emergencyCollection.doc(userId).set({
      'friendId': [],
    });
  }
}
