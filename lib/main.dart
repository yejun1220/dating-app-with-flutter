import 'package:dataing_app/controller/auth_controller.dart';
import 'package:dataing_app/ui/freeboard/freeboard_screen.dart';
import 'package:dataing_app/ui/home/home_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((_) => Get.put(AuthController()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: ScreenUtilInit(
        designSize: Size(392.7, 781.1),
        minTextAdapt: true,
        builder: (context, child) => DefaultHome(),
      ),
    );
  }
}

class DefaultHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: Color(0xff93e3e6),
        inactiveColor: Color(0xff909090),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "홈"),
          BottomNavigationBarItem(icon: Icon(EvaIcons.clipboardOutline), label: "게시판"),
          BottomNavigationBarItem(icon: Icon(EvaIcons.messageSquareOutline), label: "메세지"),
          BottomNavigationBarItem(icon: Icon(EvaIcons.clockOutline), label: "나의예약"),
          BottomNavigationBarItem(icon: Icon(EvaIcons.personOutline), label: "내프로필"),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(child: HomeScreen());
              },
            );
          case 1:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(child: FreeBoardScreen());
              },
            );

          default:
            return const CupertinoTabView();
        }
      },
    );
  }
}
