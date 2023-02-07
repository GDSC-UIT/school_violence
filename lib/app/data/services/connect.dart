import 'package:cloud_firestore/cloud_firestore.dart';

class Connect {
  final CollectionReference friendsCollection =
      FirebaseFirestore.instance.collection('connect');
  Future<void> friendRequest(
    // String userId,
    String friendId,
  ) async {
    CollectionReference friendRequest =
        friendsCollection.doc(friendId).collection('sentRequest');
    // DocumentSnapshot snap = await sentRequest.doc(uid).get();
    // CollectionReference? friends = (snap.data() as dynamic)['friends'];
    print(friendId);
  }
}
