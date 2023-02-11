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
    DocumentSnapshot snap = await connectCollection.doc(friendId).get();
    if (snap.data() != null) {
      _friendRequest = (snap.data()! as dynamic)['friendRequest'];
      _sentRequest = (snap.data()! as dynamic)['sentRequest'];
      _friends = (snap.data()! as dynamic)['friends'];
    } else {
      _friendRequest = [];
      _sentRequest = [];
      _friends = [];
    }
    _friendRequest.add(userId);
    return await connectCollection.doc(friendId).set(
      {
        'friendRequest': _friendRequest,
        'sentRequest': _sentRequest,
        'friends': _friends,
      },
    );
  }

  Future<void> unFriendRequest(
    String userId,
    String friendId,
  ) async {
    DocumentSnapshot snap = await connectCollection.doc(friendId).get();
    if (snap.data() != null) {
      _friendRequest = (snap.data()! as dynamic)['friendRequest'];
      _sentRequest = (snap.data()! as dynamic)['sentRequest'];
      _friends = (snap.data()! as dynamic)['friends'];
    } else {
      _friendRequest = [];
      _sentRequest = [];
      _friends = [];
    }
    _friendRequest.remove(userId);
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
    DocumentSnapshot snap = await connectCollection.doc(userId).get();
    if (snap.data() != null) {
      _friendRequest = (snap.data()! as dynamic)['friendRequest'];
      _sentRequest = (snap.data()! as dynamic)['sentRequest'];
      _friends = (snap.data()! as dynamic)['friends'];
    } else {
      _friendRequest = [];
      _sentRequest = [];
      _friends = [];
    }
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
    DocumentSnapshot snap = await connectCollection.doc(userId).get();
    if (snap.data() != null) {
      _friendRequest = (snap.data()! as dynamic)['friendRequest'];
      _sentRequest = (snap.data()! as dynamic)['sentRequest'];
      _friends = (snap.data()! as dynamic)['friends'];
    } else {
      _friendRequest = [];
      _sentRequest = [];
      _friends = [];
    }
    _sentRequest.remove(friendId);
    return await connectCollection.doc(userId).set(
      {
        'friendRequest': _friendRequest,
        'sentRequest': _sentRequest,
        'friends': _friends,
      },
    );
  }

  Future<void> friends(
    String userId,
    String friendId,
  ) async {
    DocumentSnapshot snapUserId = await connectCollection.doc(userId).get();
    if (snapUserId.data() != null) {
      _friendRequest = (snapUserId.data()! as dynamic)['friendRequest'];
      _sentRequest = (snapUserId.data()! as dynamic)['sentRequest'];
      _friends = (snapUserId.data()! as dynamic)['friends'];
    } else {
      _friendRequest = [];
      _sentRequest = [];
      _friends = [];
    }
    _friends.add(friendId);
    return await connectCollection.doc(userId).set(
      {
        'friendRequest': _friendRequest,
        'sentRequest': _sentRequest,
        'friends': _friends,
      },
    );
  }
}
