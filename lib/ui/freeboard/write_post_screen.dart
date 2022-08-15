import 'package:dataing_app/controller/freeboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'freeboard_view_model.dart';

class WritePost extends StatefulWidget {
  @override
  _WriteScreenState createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WritePost> {
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  final freeBoardViewModel = FreeBoardViewModel();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Write post",
            style: TextStyle(
              color: Color(0xff324755),
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Color(0xff324755),
          ),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: '제목을 입력하세요', border: InputBorder.none),
              ),
              Divider(
                thickness: 1,
                indent: 16.35,
                endIndent: 16.35,
              ),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(hintText: "내용을 입력하세요", border: InputBorder.none),
              ),
              GetBuilder<FreeBoardController>(
                builder: (freeBoardController) {
                  return TextButton(
                      onPressed: () async {
                        if (titleController.text.trim().isEmpty || contentController.text.trim().isEmpty) {
                          Get.snackbar(
                            "Error message",
                            "User message",
                            backgroundColor: Colors.red,
                            titleText: Text("게시판 작성"),
                            messageText: Text(
                              "제목 혹은 내용에 값이 없습니다.",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        } else {
                          Navigator.pop(context);
                          await freeBoardViewModel.writePost(context, titleController.text, contentController.text);
                          freeBoardController.fetchFreeBoardData();
                        }
                      },
                      child: Text("작성"));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
