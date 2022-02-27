
part of 'fetch_coins_cubit.dart';
abstract class FetchCoinsState {
  const FetchCoinsState();

}

class FetchCoinsInitial extends FetchCoinsState {}

class FetchCoinsLoading extends FetchCoinsState {}

class FetchCoinsError extends FetchCoinsState {
  final String message;

  const FetchCoinsError(this.message);
}

class FetchCoinsLoaded extends FetchCoinsState {
  final CoinModel coinModel;

  const FetchCoinsLoaded(this.coinModel);
}
