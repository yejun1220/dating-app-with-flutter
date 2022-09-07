import 'package:dating_app/data/repository/freeboard_repository_impl.dart';
import 'package:dating_app/presentation/auth/auth_event.dart';
import 'package:dating_app/presentation/auth/auth_view_model.dart';
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
    final freeBoardListingsViewModel = context.watch<FreeBoardListingsViewModel>();
    final authViewModel = context.watch<AuthViewModel>();
    final state = freeBoardListingsViewModel.state;

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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {
              authViewModel.onEvent(const AuthEvent.signOut());
            },
          ),
        ],
        centerTitle: true,
        backgroundColor: const Color(0xffffffff),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          freeBoardListingsViewModel.onEvent(const FreeBoardListingsEvent.refreshFreeBoardListings());
        },
        child: state.isLoading
            ? const Center(child: CircularProgressIndicator())
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
            freeBoardListingsViewModel.onEvent(const FreeBoardListingsEvent.loadFreeBoardListings());
          }
        },
      ),
    );
  }
}
