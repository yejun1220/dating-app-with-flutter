import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/domain/model/freeboard_info.dart';
import 'package:dating_app/domain/model/manager.dart';

class FirebaseApi {
  Future<List<Manager>> getManagerListings() async {
    final collectionRef = FirebaseFirestore.instance.collection('user').where('role', isEqualTo: 'manager');
    QuerySnapshot querySnapshot = await collectionRef.get();
    final List allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allData.map((e) => Manager.fromJson(e)).toList();
  }

  Future<List<FreeBoardInfo>> getFreeBoardListings() async {
    final collectionRef = FirebaseFirestore.instance.collection('board').orderBy('timestamp', descending: true);
    QuerySnapshot querySnapshot = await collectionRef.get();
    final List allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allData.map((e) => FreeBoardInfo.fromJson(e)).toList();
  }

  Future<FreeBoardInfo> getFreeBoard(String id) async {
    // TODO : 코드 최적화 필요
    final collectionRef = FirebaseFirestore.instance.collection('board').where('id', isEqualTo: id);
    QuerySnapshot querySnapshot = await collectionRef.get();
    final List allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allData.map((e) => FreeBoardInfo.fromJson(e)).toList().first;
  }

  Future<void> insertFreeBoard(FreeBoardInfo freeBoardInfo) async {
    var collectionRef = FirebaseFirestore.instance.collection('board');
    await collectionRef.add({
      'title': freeBoardInfo.title,
      'content': freeBoardInfo.content,
      'userName': freeBoardInfo.userName,
      'timestamp': freeBoardInfo.timestamp,
      'isPressedList': freeBoardInfo.isPressedList,
      'comments': freeBoardInfo.comments,
      // TODO : User_uid 필요한가?
      // 'user_uid': AuthController.instance.authentication.currentUser!.uid
    }).then(
      (documentRef) => documentRef.update({
        'id': documentRef.id,
      }),
    );
  }

  Future<void> updateFreeBoard(FreeBoardInfo freeBoardInfo) async {
    var documentRef = FirebaseFirestore.instance.collection('board').doc(freeBoardInfo.id);
    await documentRef.update({
      'title': freeBoardInfo.title,
      'content': freeBoardInfo.content,
      // TODO : User_uid 필요한가?
      // 'user_uid': AuthController.instance.authentication.currentUser!.uid
    });
  }

  Future<void> deleteFreeBoard(String id) async {
    var documentRef = FirebaseFirestore.instance.collection('board').doc(id);
    await documentRef.delete();
  }

// Future<void> updateHeartFirebase() async {
//     for (int index = 0; index < managerList.length; index++) {
//       var manager = managerList[index];
//       var documentSnapshot = await FirebaseFirestore.instance.collection('user').doc(manager.userUID).get();
//       if (documentSnapshot.data()!['isPressedList'].contains(AuthController.instance.authentication.currentUser!.uid) !=
//           manager.isPressedList!.contains(AuthController.instance.authentication.currentUser!.uid)) {
//         if (documentSnapshot.data()!['isPressedList'].contains(AuthController.instance.authentication.currentUser!.uid)) {
//           FirebaseFirestore.instance.collection('user').doc(manager.userUID).update({
//             'heart': documentSnapshot.data()!['heart'] - 1,
//             'isPressedList': FieldValue.arrayRemove([AuthController.instance.authentication.currentUser!.uid])
//           });
//           FirebaseFirestore.instance.collection('user').doc(AuthController.instance.authentication.currentUser!.uid).update({
//             'wishList': FieldValue.arrayRemove([manager.userUID.trim()])
//           });
//         } else {
//           FirebaseFirestore.instance.collection('user').doc(manager.userUID).update({
//             'heart': documentSnapshot.data()!['heart'] + 1,
//             'isPressedList': FieldValue.arrayUnion([AuthController.instance.authentication.currentUser!.uid])
//           });
//           FirebaseFirestore.instance.collection('user').doc(AuthController.instance.authentication.currentUser!.uid).update({
//             'wishList': FieldValue.arrayUnion([manager.userUID.trim()])
//           });
//         }
//       }
//     }
//   }
}
