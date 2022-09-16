import 'package:dating_app/data/data_source/firebase_api.dart';
import 'package:dating_app/data/repository/auth_repository_impl.dart';
import 'package:dating_app/data/repository/freeboard_repository_impl.dart';
import 'package:dating_app/data/repository/in_chat_repository_impl.dart';
import 'package:dating_app/data/repository/manager_repository_impl.dart';
import 'package:dating_app/presentation/auth/auth_screen.dart';
import 'package:dating_app/presentation/auth/auth_view_model.dart';
import 'package:dating_app/presentation/chat/chat_listings/client_chat_listings/client_chat_listings_view_model.dart';
import 'package:dating_app/presentation/chat/in_chat/messages/messages_view_model.dart';
import 'package:dating_app/presentation/freeboard/freeboard_listings/freeboard_listings_view_model.dart';
import 'package:dating_app/presentation/homepage/homepage_screen.dart';
import 'package:dating_app/presentation/homepage/homepage_view_model.dart';
import 'package:dating_app/presentation/manager/manager_listings/manager_listings_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (_) => FreeBoardRepositoryImpl(FirebaseApi()),
        ),
        Provider(
          create: (_) => ChatRepositoryImpl(FirebaseApi()),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(AuthRepositoryImpl(FirebaseApi())),
        ),
        ChangeNotifierProvider(
          create: (_) => HomePageViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ManagerListingsViewModel(ManagerRepositoryImpl(FirebaseApi())),
        ),
        ChangeNotifierProvider(
          create: (_) => FreeBoardListingsViewModel(FreeBoardRepositoryImpl(FirebaseApi())),
        ),
        ChangeNotifierProvider(
          create: (_) => MessagesViewModel(ChatRepositoryImpl(FirebaseApi())),
        ),
        StreamProvider<User?>(
          create: (_) => AuthViewModel(AuthRepositoryImpl(FirebaseApi())).state.authStateChanges,
          initialData: AuthViewModel(AuthRepositoryImpl(FirebaseApi())).state.user,
        ),
        ChangeNotifierProvider(
          create: (_) => ClientChatListingsViewModel(ChatRepositoryImpl(FirebaseApi()), AuthViewModel(AuthRepositoryImpl(FirebaseApi())).state.user?.uid),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Consumer(
        builder: (_, User? user, child) {
          if (user == null) return const AuthScreen();
          return const HomePage();
        },
      ),
    );
  }
}
