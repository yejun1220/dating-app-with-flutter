import 'package:dating_app/presentation/manager/manager_info/manager_info_screen.dart';
import 'package:dating_app/presentation/manager/manager_listings/components/manager_listings_card.dart';
import 'package:dating_app/presentation/manager/manager_listings/manager_listings_event.dart';
import 'package:dating_app/presentation/manager/manager_listings/manager_listings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManagerListingsScreen extends StatelessWidget {
  const ManagerListingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ManagerListingsViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                viewModel.onEvent(const ManagerListingsEvent.refreshManagerListings());
              },
              child: state.managers.isEmpty
                  ? const Text("No Manager")
                  : ListView.builder(
                      itemCount: state.managers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ManagerInfoScreen()),
                            );
                          },
                          child: ManagerListingsCard(manager: state.managers[index]),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}