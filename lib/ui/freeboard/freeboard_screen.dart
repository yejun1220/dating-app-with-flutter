import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/freeboard_controller.dart';
import 'widget/freeboard_card_widget.dart';
import 'write_post_screen.dart';

class FreeBoardScreen extends StatefulWidget {
  const FreeBoardScreen({Key? key}) : super(key: key);

  @override
  State<FreeBoardScreen> createState() => _FreeBoardState();
}

class _FreeBoardState extends State<FreeBoardScreen> {
  final FreeBoardController _freeBoardController = Get.put(FreeBoardController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "자유게시판",
            style: TextStyle(
              color: Color(0xff324755),
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xffffffff),
          actions: [
            IconButton(
              icon: Icon(
                EvaIcons.refresh,
                color: Color(0xff525252),
                size: 20.16,
              ),
              onPressed: () async {
                await _freeBoardController.fetchFreeBoardData();
              },
            )
          ],
        ),
        body: _freeBoardController.freeBoardList.length == 0
            ? Text("첫글을 작성해 보세요!")
            : ListView.builder(
                shrinkWrap: true,
                itemCount: _freeBoardController.freeBoardList.length,
                itemBuilder: (context, index) {
                  return FreeBoardCardWidget(index: index);
                },
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => WritePost());
          },
        ),
      );
    });
  }
}
