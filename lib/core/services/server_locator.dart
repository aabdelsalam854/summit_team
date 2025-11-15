import 'package:summit_team/core/services/database_services.dart';
import 'package:summit_team/core/services/firestore_services.dart';
import 'package:summit_team/features/app/app_injection.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> setUpServerLocator() async {
  sl.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  // Register core services
  sl.registerLazySingleton<DatabaseServices>(() => FirestoreServices());

  await appInit(sl);
}
