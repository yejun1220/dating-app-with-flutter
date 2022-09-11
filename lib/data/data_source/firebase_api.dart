import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/domain/model/chat_room_listing.dart';
import 'package:dating_app/domain/model/freeboard_info.dart';
import 'package:dating_app/domain/model/manager.dart';
import 'package:dating_app/domain/model/message_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseApi {
  final _firestore = FirebaseFirestore.instance;

  Future<List<Manager>> getManagerListings() async {
    final collectionRef = _firestore.collection('user').where('role', isEqualTo: 'manager');
    QuerySnapshot querySnapshot = await collectionRef.get();
    final List allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allData.map((e) => Manager.fromJson(e)).toList();
  }

  Future<List<FreeBoardInfo>> getFreeBoardListings() async {
    final collectionRef = _firestore.collection('board').orderBy('timestamp', descending: true);
    QuerySnapshot querySnapshot = await collectionRef.get();
    final List allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allData.map((e) => FreeBoardInfo.fromJson(e)).toList();
  }

  Future<FreeBoardInfo> getFreeBoard(String id) async {
    // TODO : 코드 최적화 필요
    final collectionRef = _firestore.collection('board').where('id', isEqualTo: id);
    QuerySnapshot querySnapshot = await collectionRef.get();
    final List allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allData.map((e) => FreeBoardInfo.fromJson(e)).toList().first;
  }

  Future<void> insertFreeBoard(FreeBoardInfo freeBoardInfo) async {
    var collectionRef = _firestore.collection('board');
    await collectionRef.add({
      'title': freeBoardInfo.title,
      'content': freeBoardInfo.content,
      'userName': freeBoardInfo.userName,
      'timestamp': freeBoardInfo.timestamp,
      'isPressedList': freeBoardInfo.isPressedList,
      'comments': freeBoardInfo.comments,
      // 'user_uid': AuthController.instance.authentication.currentUser!.uid
    }).then(
      (documentRef) => documentRef.update({
        'id': documentRef.id,
      }),
    );
  }

  Future<void> updateFreeBoard(FreeBoardInfo freeBoardInfo) async {
    var documentRef = _firestore.collection('board').doc(freeBoardInfo.id);
    await documentRef.update({
      'title': freeBoardInfo.title,
      'content': freeBoardInfo.content,
      // TODO : User_uid 필요한가?
      // 'user_uid': AuthController.instance.authentication.currentUser!.uid
    });
  }

  Future<void> deleteFreeBoard(String id) async {
    var documentRef = _firestore.collection('board').doc(id);
    await documentRef.delete();
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  User? getUser() {
    return FirebaseAuth.instance.currentUser;
  }

  Stream<User?> authStateChanges() {
    return FirebaseAuth.instance.authStateChanges();
  }

  Future<void> sendMessage(MessageInfo messageInfo, ChatRoomListing chatRoomListing) async {
    final collectionRef1 = _firestore.collection("chat").doc(messageInfo.to).collection('message');
    await collectionRef1.add(messageInfo.toJson()).then(
          (documentRef) => documentRef.update({
            'id': documentRef.id,
          }),
        );
    final collectionRef2 = _firestore.collection("chat").doc(messageInfo.from).collection('message');
    await collectionRef2.add(messageInfo.toJson()).then(
          (documentRef) => documentRef.update({
            'id': documentRef.id,
          }),
        );

    final collectionRef3 = _firestore.collection("chat").doc(messageInfo.to).collection('chat_list');
    await collectionRef3.doc(messageInfo.from).set(chatRoomListing.toJson());

    final collectionRef4 = _firestore.collection("chat").doc(messageInfo.from).collection('chat_list');
    await collectionRef4.doc(messageInfo.to).set(chatRoomListing.toJson());
  }

  Stream<List<MessageInfo>> getMessages(String myId, String opponentId) {
    return _firestore
        .collection("chat")
        .doc(myId)
        .collection('message')
        .where('opponentId', isEqualTo: opponentId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.docs
              .map(
                (documentSnapshot) => MessageInfo(
                  type: documentSnapshot.data()['type'],
                  timestamp: documentSnapshot.data()['timestamp'],
                  to: documentSnapshot.data()['to'],
                  message: documentSnapshot.data()['message'],
                  from: documentSnapshot.data()['from'],
                  opponentId: documentSnapshot.data()['opponentId'],
                ),
              )
              .toList(),
        );
  }

  Stream<List<ChatRoomListing>> getChatRoomListings(String myId) {
    return _firestore.collection("chat").doc(myId).collection('chat_list').orderBy('timestamp', descending: true).snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map(
                (documentSnapshot) => ChatRoomListing(
                  opponentId: documentSnapshot.data()['opponentId'],
                  imageUrl: documentSnapshot.data()['imageUrl'],
                  title: documentSnapshot.data()['title'],
                  area: documentSnapshot.data()['area'],
                  content: documentSnapshot.data()['content'],
                  timestamp: documentSnapshot.data()['timestamp'],
                ),
              )
              .toList(),
        );
  }

// Future<void> updateHeartFirebase() async {
//     for (int index = 0; index < managerList.length; index++) {
//       var manager = managerList[index];
//       var documentSnapshot = await _firestore.collection('user').doc(manager.userUID).get();
//       if (documentSnapshot.data()!['isPressedList'].contains(AuthController.instance.authentication.currentUser!.uid) !=
//           manager.isPressedList!.contains(AuthController.instance.authentication.currentUser!.uid)) {
//         if (documentSnapshot.data()!['isPressedList'].contains(AuthController.instance.authentication.currentUser!.uid)) {
//           _firestore.collection('user').doc(manager.userUID).update({
//             'heart': documentSnapshot.data()!['heart'] - 1,
//             'isPressedList': FieldValue.arrayRemove([AuthController.instance.authentication.currentUser!.uid])
//           });
//           _firestore.collection('user').doc(AuthController.instance.authentication.currentUser!.uid).update({
//             'wishList': FieldValue.arrayRemove([manager.userUID.trim()])
//           });
//         } else {
//           _firestore.collection('user').doc(manager.userUID).update({
//             'heart': documentSnapshot.data()!['heart'] + 1,
//             'isPressedList': FieldValue.arrayUnion([AuthController.instance.authentication.currentUser!.uid])
//           });
//           _firestore.collection('user').doc(AuthController.instance.authentication.currentUser!.uid).update({
//             'wishList': FieldValue.arrayUnion([manager.userUID.trim()])
//           });
//         }
//       }
//     }
//   }
}
