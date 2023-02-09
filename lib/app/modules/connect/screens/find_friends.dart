import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/data/services/connect.dart';
import 'package:school_violence_app/app/modules/connect/connect_controller.dart';

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
                        // bool check = ((await getData(
                        //         ctrl.userId.value,
                        //         ctrl.searchResult[index]['id'],
                        //         'sentRequest')) == false);
                        return FutureBuilder(
                          future: getData(ctrl.userId.value,
                              ctrl.searchResult[index]['id'], 'sentRequest'),
                          builder: (context, snapshot) {
                            return Obx(
                              () => ListTile(
                                title:
                                    Text(ctrl.searchResult[index]['fullName']),
                                subtitle:
                                    Text(ctrl.searchResult[index]['school']),
                                trailing: ElevatedButton(
                                  onPressed: () {
                                    if (snapshot.data == false) {
                                      _connect.sentRequest(
                                        ctrl.userId.value,
                                        ctrl.searchResult[index]['id'],
                                      );
                                    } else {
                                      _connect.unSentRequest(ctrl.userId.value,
                                          ctrl.searchResult[index]['id']);
                                    }
                                  },
                                  style: (snapshot.data == false)
                                      ? ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                        )
                                      : ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.white,
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                        ),
                                  child: (snapshot.data == false)
                                      ? Text('Add')
                                      : Text(
                                          'Sent ✓',
                                          style: TextStyle(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                ),
                              ),
                            );
                          },
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
