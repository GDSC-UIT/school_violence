import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:school_violence_app/app/data/services/emergency.dart';
import 'package:school_violence_app/app/modules/home_page/widgets/emergency_dialog.dart';

void helpDialog(String userId) async {
  final CollectionReference emergencyCollection =
      FirebaseFirestore.instance.collection('emergency');
  DocumentSnapshot snap = await emergencyCollection.doc(userId).get();
  final Emergency emergency = Emergency();
  List friendId = [];
  if (snap.data() != null) {
    friendId = (snap.data()! as dynamic)['friendId'];
  } else {
    friendId = [];
  }
  if (friendId.isNotEmpty && Get.isDialogOpen == false) {
    //EmergencyDialog();
    Get.dialog(const EmergencyDialog());
    emergency.resetData(userId);
  }
}
