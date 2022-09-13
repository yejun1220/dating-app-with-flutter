import 'package:dating_app/presentation/auth/auth_view_model.dart';
import 'package:dating_app/presentation/chat/in_chat/in_chat_event.dart';
import 'package:dating_app/presentation/chat/in_chat/in_chat_view_model.dart';
import 'package:dating_app/presentation/chat/in_chat/messages/messages_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InChatScreen extends StatefulWidget {
  const InChatScreen({Key? key}) : super(key: key);

  @override
  State<InChatScreen> createState() => _InChatScreenState();
}

class _InChatScreenState extends State<InChatScreen> {
  final contentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final viewModel = context.read<InChatViewModel>();
      contentController.addListener(() {
        viewModel.changedMessage(contentController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    final inChatViewModel = context.watch<InChatViewModel>();
    final state = inChatViewModel.state;

    return Scaffold(
      appBar: AppBar(
        title: Text(state.opponentName),
      ),
      body: Column(
        children: [
          Expanded(
            child: MessagesScreen(state.opponentId),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.image),
                  onPressed: () {
                    // TODO : 사진 업로드 로직 작성
                  },
                ),
                Expanded(
                  child: TextField(
                    maxLines: null,
                    controller: contentController,
                    decoration: const InputDecoration(labelText: 'Send a message...'),
                  ),
                ),
                IconButton(
                  onPressed: state.message.isEmpty
                      ? null
                      : () {
                          if (state.myRole == 1) {
                            inChatViewModel.onEvent(
                              InChatEvent.sendMessage(
                                authViewModel.state.user!.uid,
                                state.opponentId,
                                state.message,
                                'text',
                              ),
                            );
                          } else {
                            // managerSend();
                          }
                          contentController.clear();
                        },
                  icon: const Icon(Icons.send),
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
