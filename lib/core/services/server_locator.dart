import 'package:summit_team/features/app/app_injection.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> setUpServerLocator() async {
  sl.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );
  await appInit(sl);
}
