import 'package:dating_app/data/data_source/firebase_api.dart';
import 'package:dating_app/data/repository/freeboard_repository_impl.dart';
import 'package:dating_app/data/repository/manager_repository_impl.dart';
import 'package:dating_app/presentation/freeboard/freeboard_listings/freeboard_listings_screen.dart';
import 'package:dating_app/presentation/freeboard/freeboard_listings/freeboard_listings_view_model.dart';
import 'package:dating_app/presentation/manager/manager_listings/manager_listings_screen.dart';
import 'package:dating_app/presentation/manager/manager_listings/manager_listings_view_model.dart';
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
        ChangeNotifierProvider(
          create: (_) => ManagerListingsViewModel(ManagerRepositoryImpl(FirebaseApi())),
        ),
        ChangeNotifierProvider(
          create: (_) => FreeBoardListingsViewModel(FreeBoardRepositoryImpl(FirebaseApi())),
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
    return const MaterialApp(
      home: FreeBoardListingsScreen(),
      // home: ManagerListingsScreen(),
    );
  }
}
