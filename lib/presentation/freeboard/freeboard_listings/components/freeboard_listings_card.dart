import 'package:dating_app/data/repository/freeboard_repository_impl.dart';
import 'package:dating_app/domain/model/freeboard_info.dart';
import 'package:dating_app/presentation/freeboard/freeboard_info/freeboard_info_screen.dart';
import 'package:dating_app/presentation/freeboard/freeboard_info/freeboard_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FreeBoardListingsCard extends StatelessWidget {
  final FreeBoardInfo freeBoard;

  const FreeBoardListingsCard({Key? key, required this.freeBoard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(3, 3, 3, 5),
      child: InkWell(
        onTap: () {
          final repository = context.read<FreeBoardRepositoryImpl>();

          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
            return ChangeNotifierProvider(create: (_) => FreeBoardInfoViewModel(repository, freeBoard.id!),
            child: const FreeBoardInfoScreen());
          }));
        },
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                freeBoard.title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                freeBoard.content,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        freeBoard.userName,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.monitor_heart_outlined,
                        color: Colors.redAccent,
                      ),
                      Text(
                        "${freeBoard.isPressedList.length}",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.redAccent,
                        ),
                      ),
                      const Icon(
                        Icons.message_outlined,
                        color: Colors.blue,
                      ),
                      Text(
                        "${freeBoard.comments}",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
