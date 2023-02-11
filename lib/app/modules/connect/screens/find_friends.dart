import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/data/services/connect.dart';
import 'package:school_violence_app/app/modules/connect/connect_controller.dart';
import 'package:school_violence_app/app/modules/connect/widgets/add_friend_button.dart';

class FindFriends extends StatelessWidget {
  FindFriends({super.key});
  final ConnectController ctrl = Get.find<ConnectController>();
  final Connect _connect = Connect();

  void searchFromFirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('userName', isEqualTo: query)
        .get();
    ctrl.updateSearchResult(result.docs.map((e) => e.data()).toList());
    if (result != null && result.docs.length >= 1) {
      ctrl.updateIsSent(await getData(ctrl.userId.value,
              ctrl.searchResult.first['id'], 'sentRequest') ==
          false);
    }
  }

  Future<bool> getData(userId, friendId, type) async {
    DocumentSnapshot snap = await _connect.connectCollection.doc(userId).get();
    if (snap.data() != null) {
      List sentRequest = (snap.data()! as dynamic)[type];
      return sentRequest.contains(friendId);
    } else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back),
              iconSize: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Search Here",
                ),
                onChanged: (query) {
                  searchFromFirebase(query);
                },
              ),
            ),
            Obx(
              () => Expanded(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: 700,
                    child: ListView.builder(
                      itemCount: ctrl.searchResult.length,
                      itemBuilder: (context, index) {
                        return Obx(
                          () => ListTile(
                            title: Text(ctrl.searchResult[index]['fullName']),
                            subtitle: Text(ctrl.searchResult[index]['school']),
                            trailing: AddFriendButton(
                                ctrl: ctrl, connect: _connect, index: index),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
