import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FreeBoardViewModel {
  final _auth = FirebaseAuth.instance;

  String timeConvert(dynamic freeBoard, int index) {
    var time = freeBoard.time.toDate();
    var ampm = '';
    var writeTime = '';
    if (time.hour <= 12) {
      ampm = '오전';
    } else {
      ampm = '오후';
    }

    if (time.year == DateTime.now().year && time.month == DateTime.now().month && time.day == DateTime.now().day) {
      if (time.hour <= 12) {
        writeTime = '$ampm ${time.hour}:${time.minute}';
      } else {
        writeTime = '$ampm ${time.hour - 12}:${time.minute}';
      }
    } else if (DateTime.now().day - time.day == 1) {
      writeTime = '어제';
    } else {
      writeTime = '${time.year}-${time.month}-${time.day}';
    }
    return writeTime;
  }

  Future<void> writePost(BuildContext context, String title, String content) async {
    var documentReference = await FirebaseFirestore.instance.collection('board').add({
      'title': title,
      'content': content,
      'userName': _auth.currentUser!.displayName,
      'timestamp': Timestamp.now().toDate(),
      'isPressedList': FieldValue.arrayUnion([]),
      'comments': 0,
    });
    documentReference.update({'id': documentReference.id});
    Navigator.pop(context);
  }
}
