import 'package:dating_app/presentation/auth/auth_view_model.dart';
import 'package:dating_app/presentation/freeboard/post_edit_freeboard/post_edit_freeboard_event.dart';
import 'package:dating_app/presentation/freeboard/post_edit_freeboard/post_edit_freeboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostEditFreeBoardScreen extends StatefulWidget {
  const PostEditFreeBoardScreen({Key? key}) : super(key: key);

  @override
  State<PostEditFreeBoardScreen> createState() => _PostEditFreeBoardScreenState();
}

class _PostEditFreeBoardScreenState extends State<PostEditFreeBoardScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();


  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final viewModel = context.read<PostEditFreeBoardViewModel>();
      final state = viewModel.state;

      if (state.freeBoardInfo?.id != null) {
        _titleController.text = state.freeBoardInfo!.title;
        _contentController.text = state.freeBoardInfo!.content;
      }

      viewModel.eventController.listen((event) {
        event.when(
          saveFreeBoard: () {
            Navigator.pop(context, true);
          },
          showSnackBar: (String message) {
            final snackBar = SnackBar(content: Text(message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        );
      });
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PostEditFreeBoardViewModel>();
    final state = viewModel.state;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Write post",
            style: TextStyle(
              color: Color(0xff324755),
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Color(0xff324755),
          ),
        ),
        body: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(hintText: '제목을 입력하세요', border: InputBorder.none),
            ),
            const Divider(
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(hintText: "내용을 입력하세요", border: InputBorder.none),
            ),
            TextButton(
              onPressed: () async {
                viewModel.onEvent(
                  PostEditFreeBoardEvent.saveFreeBoard(
                    (state.freeBoardInfo == null ? null : state.freeBoardInfo!.id),
                    _titleController.text,
                    _contentController.text,
                    context.read<AuthViewModel>().state.user!.displayName!,
                  ),
                );
              },
              child: const Text("작성"),
            ),
          ],
        ),
      ),
    );
  }
}
