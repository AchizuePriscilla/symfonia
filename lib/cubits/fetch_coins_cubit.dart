import 'package:bloc/bloc.dart';
import 'package:symfonia_task/models/coin_model.dart';
import 'package:symfonia_task/services/fetch_coins_services.dart';
import '../models/state.dart';
part 'fetch_coins_state.dart';

class FetchCoinsCubit extends Cubit<FetchCoinsState> {
  final FetchCoinsService fetchServices;
  FetchCoinsCubit(this.fetchServices) : super(FetchCoinsInitial());

  Future fetchCoins() async {
    emit(FetchCoinsLoading());
    final State state = await fetchServices.fetchCoins();

    if (state is SuccessState) {
      final CoinModel _coinModel = state.value as CoinModel;
      emit(FetchCoinsLoaded(_coinModel));
      return;
    }
    if (state is ErrorState) {
      emit(const FetchCoinsError("Error Fetching coins"));
    } else {
      emit(const FetchCoinsError("An error occured"));
    }
  }
}
