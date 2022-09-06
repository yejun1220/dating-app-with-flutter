import 'package:dating_app/data/repository/freeboard_repository_impl.dart';
import 'package:dating_app/presentation/freeboard/freeboard_listings/components/freeboard_listings_card.dart';
import 'package:dating_app/presentation/freeboard/freeboard_listings/freeboard_listings_event.dart';
import 'package:dating_app/presentation/freeboard/freeboard_listings/freeboard_listings_view_model.dart';
import 'package:dating_app/presentation/freeboard/post_edit_freeboard/post_edit_freeboard_screen.dart';
import 'package:dating_app/presentation/freeboard/post_edit_freeboard/post_edit_freeboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FreeBoardListingsScreen extends StatelessWidget {
  const FreeBoardListingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FreeBoardListingsViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "자유게시판",
          style: TextStyle(
            color: Color(0xff324755),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffffffff),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          viewModel.onEvent(const FreeBoardListingsEvent.refreshFreeBoardListings());
        },
        child: state.freeBoards.isEmpty
            ? const Text("첫글을 작성해 보세요!")
            : ListView.builder(
                shrinkWrap: true,
                itemCount: state.freeBoards.length,
                itemBuilder: (context, index) {
                  final freeBoard = state.freeBoards[index];
                  return FreeBoardListingsCard(freeBoard: freeBoard);
                },
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.post_add),
        onPressed: () async {
          final repository = context.read<FreeBoardRepositoryImpl>();

          bool? isSaved = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (_) => PostEditFreeBoardViewModel(repository, null),
                child: const PostEditFreeBoardScreen(),
              ),
            ),
          );

          if (isSaved != null && isSaved) {
            viewModel.onEvent(const FreeBoardListingsEvent.loadFreeBoardListings());
          }

        },
      ),
    );
  }
}
