import 'package:cloud_firestore/cloud_firestore.dart';

class Connect {
  final CollectionReference connectCollection =
      FirebaseFirestore.instance.collection('connect');
  List _friendRequest = [];
  List _sentRequest = [];
  List _friends = [];
  Future<void> friendRequest(
    String userId,
    String friendId,
  ) async {
    _friendRequest.add(userId);
    return await connectCollection.doc(friendId).set(
      {
        'friendRequest': _friendRequest,
        'sentRequest': _sentRequest,
        'friends': _friends,
      },
    );
  }

  Future<void> sentRequest(
    String userId,
    String friendId,
  ) async {
    _sentRequest.add(friendId);
    return await connectCollection.doc(userId).set(
      {
        'friendRequest': _friendRequest,
        'sentRequest': _sentRequest,
        'friends': _friends,
      },
    );
  }

  Future<void> unSentRequest(
    String userId,
    String friendId,
  ) async {
    _sentRequest.remove(friendId);
    return await connectCollection.doc(userId).set(
      {
        'friendRequest': _friendRequest,
        'sentRequest': _sentRequest,
        'friends': _friends,
      },
    );
  }
}
