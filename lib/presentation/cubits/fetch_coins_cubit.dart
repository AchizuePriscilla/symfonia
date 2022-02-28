import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:symfonia_task/models/coin_model.dart';
import 'package:symfonia_task/services/fetch_coins_services.dart';
part 'fetch_coins_state.dart';

class FetchCoinsCubit extends Cubit<FetchCoinsState> {
  final FetchCoinsService fetchServices;
  FetchCoinsCubit(this.fetchServices) : super(FetchCoinsInitial());

  Future<List<CoinModel>> fetchCoins() async {
    emit(FetchCoinsLoading());

    var res = await fetchServices.fetchCoins();
    if (res.isNotEmpty) {
      emit(FetchCoinsLoaded(res));
      FetchCoinsCubit(fetchServices).close();
      return res;
    } else {
      emit(const FetchCoinsError("Error fetching coins"));
      FetchCoinsCubit(fetchServices).close();
    }
    return [];
  }
}
