import 'package:dating_app/data/data_source/firebase_api.dart';
import 'package:dating_app/data/repository/freeboard_repository_impl.dart';
import 'package:dating_app/domain/repository/freeboard_repository.dart';
import 'package:dating_app/domain/repository/manager_repository.dart';
import 'package:dating_app/presentation/freeboard/freeboard_listings/freeboard_listings_view_model.dart';
import 'package:dating_app/presentation/manager/manager_listings/manager_listings_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> globalProviders = [...independentModels, ...dependentModels, ...viewModels];

// 2. 독립적인 객체
List<SingleChildWidget> independentModels = [
  Provider(
    create: (context) => FirebaseApi(),
  )
];

// 3. 2번에 의존성 있는 객체
List<SingleChildWidget> dependentModels = [
  ProxyProvider<FirebaseApi, FreeBoardRepository>(
    update: (context, firebaseApi, _) => FreeBoardRepositoryImpl(firebaseApi),
  ),
];

// 4. ViewModels
List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<FreeBoardListingsViewModel>(
    create: (context) => FreeBoardListingsViewModel(
      context.read<FreeBoardRepository>(),
    ),
  ),

  ChangeNotifierProvider<ManagerListingsViewModel>(
    create: (context) => ManagerListingsViewModel(
      context.read<ManagerRepository>(),
    ),
  ),
];
