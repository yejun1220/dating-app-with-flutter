import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dataing_app/model/freeboard.dart';
import 'package:get/get.dart';

class FreeBoardController extends GetxController {
  var freeBoardList = <FreeBoard>[].obs;

  @override
  void onInit() async {
    await fetchFreeBoardData();
    super.onInit();
  }

  Future<void> fetchFreeBoardData() async {
    final _collectionRef = FirebaseFirestore.instance.collection('board').orderBy('timestamp', descending: true);
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final List allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    List<FreeBoard> freeBoardData = allData.map((e) => FreeBoard.fromJson(e)).toList();

    freeBoardList.value = freeBoardData;
  }
}
