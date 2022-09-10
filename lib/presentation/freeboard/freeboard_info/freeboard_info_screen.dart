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

    void _handleFABPressed() {
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return SizedBox(
            height: 270,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(8.0),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Article menu'),
                      ),
                      const Divider(),
                      ListTile(
                        title: const Text('Edit'),
                          onTap: () async {
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
                      const Divider(),
                      const ListTile(
                        title: Text('Remove'),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  child: ListTile(
                    title: Text('CANCEL'),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          );
        },
      );
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
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
            IconButton(onPressed: _handleFABPressed, icon: const Icon(Icons.menu)),
            // TODO : 팝업 창으로 수정 및 삭제 Event 주입
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
