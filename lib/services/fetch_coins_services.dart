import 'package:symfonia_task/models/coin_model.dart';
import 'package:symfonia_task/utils/app_utils/remote_util.dart';

import '../models/state.dart';

class FetchCoinsService extends Remote {
  FetchCoinsService(String url) : super(url);
  
  Future<State> fetchCoins() async{
    return Remote.makeRequest(
       get("markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false"),  successResponse: (data) {
      return SuccessState(CoinModel.fromMap(data));
    }, errorResponse: (response) {
      return ErrorState<String>(response.data ?? 'An error occurred');
    }, dioErrorResponse: (response) {
      return ErrorState(response?.data ?? 'An error occurred');
    });
  }
}