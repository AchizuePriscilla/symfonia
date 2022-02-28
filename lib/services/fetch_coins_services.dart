import 'package:symfonia_task/models/coin_model.dart';
import 'package:symfonia_task/utils/app_utils/remote_util.dart';

class FetchCoinsService extends Remote {
  FetchCoinsService(String url) : super(url);

  Future<List<CoinModel>> fetchCoins() async {
    var res = await dio.get(
        "markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false");
    return (res.data as List<dynamic>).map((e) => CoinModel.fromJson(e)).toList();
  }
}
