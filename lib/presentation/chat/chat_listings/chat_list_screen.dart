import 'package:dating_app/presentation/chat/chat_listings/client_chat_listings/client_chat_listings_screen.dart';
import 'package:flutter/material.dart';

class ChatListingsScreen extends StatefulWidget {
  const ChatListingsScreen({Key? key}) : super(key: key);

  @override
  State<ChatListingsScreen> createState() => _ChatListingsScreenState();
}

class _ChatListingsScreenState extends State<ChatListingsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Color(0xffe1f3f3),
            ),
            tabs: [
              SizedBox(
                  width: 180,
                  child: Tab(
                    text: "고객용",
                  )),
              SizedBox(
                  width: 180,
                  child: Tab(
                    text: "리스너용",
                  )),
            ],
          ),
          backgroundColor: Colors.white,
          title: const Text(
            "메세지",
            style: TextStyle(
              color: Color(0xff324755),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: TabBarView(children: [
          ClientChatListingsScreen(),
          Container(),
        ]),
      ),
    );
  }
}
