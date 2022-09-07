import 'package:dating_app/data/repository/freeboard_repository_impl.dart';
import 'package:dating_app/presentation/freeboard/freeboard_info/freeboard_info_event.dart';
import 'package:dating_app/presentation/freeboard/freeboard_info/freeboard_info_view_model.dart';
import 'package:dating_app/presentation/freeboard/post_edit_freeboard/post_edit_freeboard_screen.dart';
import 'package:dating_app/presentation/freeboard/post_edit_freeboard/post_edit_freeboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FreeBoardInfoScreen extends StatefulWidget {
  const FreeBoardInfoScreen({Key? key}) : super(key: key);

  @override
  State<FreeBoardInfoScreen> createState() => _FreeBoardInfoScreenState();
}

class _FreeBoardInfoScreenState extends State<FreeBoardInfoScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final viewModel = context.read<FreeBoardInfoViewModel>();
      viewModel.eventController.listen((event) {
        event.when(deleteFreeBoard: () {
          Navigator.pop(context, true);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FreeBoardInfoViewModel>();
    final state = viewModel.state;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // 여백 화면 탭시 키보드 사라짐
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text(
            "자유게시판",
            style: TextStyle(
              color: Color(0xff324755),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            // TODO : 팝업 창으로 수정 및 삭제 Event 주입
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.black,
              ),
              onPressed: () async {
                final repository = context.read<FreeBoardRepositoryImpl>();

                bool? isSaved = await Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                      create: (_) => PostEditFreeBoardViewModel(repository, state.freeBoardInfo!),
                      child: const PostEditFreeBoardScreen(),
                    ),
                  ),
                );

                if (isSaved != null && isSaved) {
                  viewModel.onEvent(FreeBoardInfoEvent.loadFreeBoardInfo(state.freeBoardInfo!.id!));
                }
              },
            ),
          ],
          backgroundColor: const Color(0xffffffff),
          iconTheme: const IconThemeData(
            color: Color(0xff324755),
          ),
          centerTitle: true,
        ),
        body: Container(
          color: const Color(0xffececec),
          child: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Text(state.freeBoardInfo!.title),
                  ],
                ),
        ),
      ),
    );
  }
}
