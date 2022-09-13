import 'package:dating_app/domain/model/message_info.dart';
import 'package:dating_app/presentation/auth/auth_view_model.dart';
import 'package:dating_app/presentation/chat/in_chat/messages/messages_event.dart';
import 'package:dating_app/presentation/chat/in_chat/messages/messages_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessagesScreen extends StatelessWidget {
  final String opponentId;

  const MessagesScreen(this.opponentId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MessagesViewModel>();

    viewModel.onEvent(MessagesEvent.getMessages(context.read<AuthViewModel>().state.user!.uid, opponentId));

    return StreamProvider<List<MessageInfo>>.value(
      value: viewModel.stream,
      initialData: const [],
      child: Consumer<List<MessageInfo>>(
        builder: (_, messageInfoList, child) => ListView.builder(
          reverse: true,
          itemCount: messageInfoList.length,
          itemBuilder: (context, index) {
            final isMe = messageInfoList[index].to != opponentId;
            return Row(
              mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: isMe ? Colors.grey[300] : Colors.blue,
                    borderRadius: BorderRadius.only(
                      topRight: const Radius.circular(12),
                      topLeft: const Radius.circular(12),
                      bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(12),
                      bottomLeft: isMe ? const Radius.circular(12) : const Radius.circular(0),
                    ),
                  ),
                  width: 145,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: messageInfoList[index].type == 'text'
                      ? Text(
                          messageInfoList[index].message,
                          style: TextStyle(color: isMe ? Colors.black : Colors.white),
                        )
                      : Image.network(messageInfoList[index].message),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
