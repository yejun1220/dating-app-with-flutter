import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dataing_app/model/manager.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';

class ManagerController extends GetxController {
  var managerList = <Manager>[].obs;

  @override
  void onInit() async {
    await fetchManagerData();
    super.onInit();
  }

  @override
  void onClose() async {
    await updateHeartFirebase();
    super.onClose();
  }

  Future<void> fetchManagerData() async {
    final _collectionRef = FirebaseFirestore.instance.collection('user').where('role', isEqualTo: 'manager');
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final List allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    List<Manager> managerData = allData.map((e) => Manager.fromJson(e)).toList();
    managerList.value = managerData;
  }

  Future<void> updateHeartFirebase() async {
    for (int index = 0; index < managerList.length; index++) {
      var manager = managerList[index];
      var documentSnapshot = await FirebaseFirestore.instance.collection('user').doc(manager.userUID).get();
      if (documentSnapshot.data()!['isPressedList'].contains(AuthController.instance.authentication.currentUser!.uid) !=
          manager.isPressedList!.contains(AuthController.instance.authentication.currentUser!.uid)) {
        if (documentSnapshot.data()!['isPressedList'].contains(AuthController.instance.authentication.currentUser!.uid)) {
          FirebaseFirestore.instance.collection('user').doc(manager.userUID).update({
            'heart': documentSnapshot.data()!['heart'] - 1,
            'isPressedList': FieldValue.arrayRemove([AuthController.instance.authentication.currentUser!.uid])
          });
          FirebaseFirestore.instance.collection('user').doc(AuthController.instance.authentication.currentUser!.uid).update({
            'wishList': FieldValue.arrayRemove([manager.userUID.trim()])
          });
        } else {
          FirebaseFirestore.instance.collection('user').doc(manager.userUID).update({
            'heart': documentSnapshot.data()!['heart'] + 1,
            'isPressedList': FieldValue.arrayUnion([AuthController.instance.authentication.currentUser!.uid])
          });
          FirebaseFirestore.instance.collection('user').doc(AuthController.instance.authentication.currentUser!.uid).update({
            'wishList': FieldValue.arrayUnion([manager.userUID.trim()])
          });
        }
      }
    }
  }
}
