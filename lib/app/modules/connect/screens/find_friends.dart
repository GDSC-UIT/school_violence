import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/core/values/app_colors.dart';
import 'package:school_violence_app/app/data/services/connect.dart';
import 'package:school_violence_app/app/modules/connect/connect_controller.dart';

class FindFriends extends StatelessWidget {
  FindFriends({super.key});
  final ConnectController ctrl = Get.find<ConnectController>();

  void searchFromFirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('userName', isEqualTo: query)
        .get();
    ctrl.updateSearchResult(result.docs.map((e) => e.data()).toList());
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
                        return Obx(
                          () => ListTile(
                            title: Text(ctrl.searchResult[index]['fullName']),
                            subtitle: Text(ctrl.searchResult[index]['school']),
                            trailing: ElevatedButton(
                              style: (!ctrl.sent.value)
                                  ? ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryColor,
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
                              onPressed: () {
                                ctrl.updateSent();
                                Connect().friendRequest(
                                    ctrl.searchResult[index]['id']);
                              },
                              child: (!ctrl.sent.value)
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
