import 'package:dataing_app/ui/home/widget/manager_card_widget.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../../controller/manager_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  @override
  Widget build(BuildContext context) {
    return GetX<ManagerController>(
      init: ManagerController(),
      builder: (managerController) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.end,
            ),
            leading: IconButton(
              icon: Icon(
                EvaIcons.logOut,
                color: Color(0xff525252),
                size: 20.16,
              ),
              onPressed: () {
                AuthController.instance.logout();
              },
            ),
            actions: [
              IconButton(
                icon: Icon(
                  EvaIcons.refresh,
                  color: Color(0xff525252),
                  size: 20.16,
                ),
                onPressed: () async {
                  await managerController.fetchManagerData();
                },
              ),
            ],
          ),
          body: ListView.builder(
            shrinkWrap: true,
            itemCount: managerController.managerList.length,
            itemBuilder: (BuildContext context, int index) {
              return ManagerCardWidget(manager: managerController.managerList[index]);
            },
          ),
        );
      },
    );
  }
}
