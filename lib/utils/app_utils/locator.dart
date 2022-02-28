import 'package:get_it/get_it.dart';
import 'package:symfonia_task/services/fetch_coins_services.dart';
import '../../presentation/cubits/fetch_coins_cubit.dart';
import 'connectivity_service.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator({String baseApi = ''}) async {
  //Services
  locator.registerLazySingleton<ConnectivityService>(
    () => ConnectivityServiceImpl(),
  );

  locator.registerLazySingleton<FetchCoinsService>(
    () => FetchCoinsService(baseApi),
  );
//cubits
  locator.registerSingleton<FetchCoinsCubit>(
      FetchCoinsCubit(locator.get<FetchCoinsService>()));
}
