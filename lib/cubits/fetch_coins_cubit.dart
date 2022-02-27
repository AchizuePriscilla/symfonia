

import 'package:bloc/bloc.dart';
import 'package:symfonia_task/presentation/views/history_view.dart';
import 'package:symfonia_task/services/fetch_coins_services.dart';
import '../models/state.dart';
part 'fetch_coins_state.dart';

class FetchCoinsCubit extends Cubit<FetchCoinsState> {
  final FetchCoinsService fetchServices;
  FetchCoinsCubit(this.fetchServices) : super(FetchCoinsInitial());

  Future fetchCoins(String email, String password) async {
    emit(FetchCoinsLoading());
    final State state = await fetchServices.fetchCoins();

    if (state is SuccessState && state.value.success == true) {
      final CoinDetails _coinDetails = state.value as CoinDetails;
     
      emit(FetchCoinsLoaded(_coinDetails));
      return;
    }
    if (state is SuccessState && state.value.success != true) {
      emit(FetchCoinsError(state.value.message));
      return;
    }
    if (state is ErrorState) {
      emit(FetchCoinsError(state.value.errorMessage.toString()));
    } else {
      emit(const FetchCoinsError("An error occured"));
    }
  }
}
