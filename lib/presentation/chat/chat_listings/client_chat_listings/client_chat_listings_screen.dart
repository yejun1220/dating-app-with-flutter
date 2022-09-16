import 'package:dating_app/data/repository/in_chat_repository_impl.dart';
import 'package:dating_app/domain/model/chat_room_listing.dart';
import 'package:dating_app/presentation/chat/chat_listings/client_chat_listings/client_chat_listings_view_model.dart';
import 'package:dating_app/presentation/chat/in_chat/in_chat_screen.dart';
import 'package:dating_app/presentation/chat/in_chat/in_chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClientChatListingsScreen extends StatelessWidget {
  const ClientChatListingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ClientChatListingsViewModel>();

    return StreamProvider<List<ChatRoomListing>>.value(
      value: viewModel.stream,
      initialData: const [],
      child: Consumer<List<ChatRoomListing>>(builder: (_, chatRooms, __) {
        return ListView.builder(
          itemCount: chatRooms.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          chatRooms[index].imageUrl),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    chatRooms[index].title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff222b31)),
                  ),
                  Text(
                    chatRooms[index].area,
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xff8fa2ae)),
                  ),
                  const Spacer(),
                  Text(DateTime.fromMillisecondsSinceEpoch(chatRooms[index].timestamp).toString()),
                ],
              ),
              subtitle: Text(
                chatRooms[index].content,
                style: const TextStyle(color: Color(0xffa090c4), fontSize: 14),
              ),
              onTap: () {
                final repository = context.read<ChatRepositoryImpl>();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                      create: (_) => InChatViewModel(
                        repository,
                        chatRooms[index].opponentId,
                        chatRooms[index].title,
                        chatRooms[index].imageUrl,
                        chatRooms[index].area,
                      ),
                      child: const InChatScreen(),
                    ),
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}
