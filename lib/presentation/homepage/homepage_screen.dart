import 'package:dating_app/presentation/homepage/homepage_event.dart';
import 'package:dating_app/presentation/homepage/homepage_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomePageViewModel>();
    final state = viewModel.state;

    return Scaffold(
      body: state.pageOptions[state.index],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "FreeBoard"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
        ],

        currentIndex: state.index,
        selectedItemColor: Colors.blue,

        onTap: (index) {
          viewModel.onEvent(HomePageEvent.selectCurrentPage(index));
        },
      ),
    );
  }
}