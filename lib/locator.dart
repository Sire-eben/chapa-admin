import 'package:get_it/get_it.dart';
import 'package:nb_utils/nb_utils.dart';

import 'handlers/base_change_notifier.dart';
import 'modules/authentication/services/auth_service.dart';
import 'modules/categories/service/category_service.dart';
import 'modules/printing_qualities/service/print_service.dart';
import 'modules/utilities/service/utils_service.dart';
import 'navigation_service.dart';

// final chapaNavigatorKey = GlobalKey<NavigatorState>();

final locator = GetIt.instance;
Future<void> setupLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton(sharedPreferences);
  locator.registerLazySingleton(() => NavigationService());

  // //Local storage
  // locator.registerLazySingleton<SecureStorage>(() => SecureStorageImpl());

  // locator.registerLazySingleton<LocalCache>(
  //   () => LocalCacheImpl(sharedPreferences: locator(), storage: locator()),
  // );

  // // ///Register repositories and services
  // locator.registerLazySingleton<AuthService>(() => AuthServiceImpl());

  ///register providers
  locator.registerLazySingleton<BaseChangeNotifier>(() => BaseChangeNotifier());
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<CategoryService>(() => CategoryService());
  locator.registerLazySingleton<UtilitiesService>(() => UtilitiesService());
  locator.registerLazySingleton<PrintingService>(() => PrintingService());
}
