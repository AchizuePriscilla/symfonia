// To parse this JSON data, do
//
//     final coinModel = coinModelFromMap(jsonString);
import 'dart:convert';

class CoinModel {
  CoinModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    required this.fullyDilutedValuation,
    required this.totalVolume,
    required this.high24H,
    required this.low24H,
    required this.priceChange24H,
    required this.priceChangePercentage24H,
    required this.marketCapChange24H,
    required this.marketCapChangePercentage24H,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.maxSupply,
    required this.ath,
    required this.athChangePercentage,
    required this.athDate,
    required this.atl,
    required this.atlChangePercentage,
    required this.atlDate,
    required this.roi,
    required this.lastUpdated,
  });

  final String? id;
  final String? symbol;
  final String? name;
  final String? image;
  final num? currentPrice;
  final num? marketCap;
  final num? marketCapRank;
  final num? fullyDilutedValuation;
  final num? totalVolume;
  final num? high24H;
  final num? low24H;
  final num? priceChange24H;
  final num? priceChangePercentage24H;
  final num? marketCapChange24H;
  final num? marketCapChangePercentage24H;
  final num? circulatingSupply;
  final num? totalSupply;
  final num? maxSupply;
  final num? ath;
  final num? athChangePercentage;
  final DateTime? athDate;
  final num? atl;
  final num? atlChangePercentage;
  final DateTime? atlDate;
  final dynamic roi;
  final DateTime? lastUpdated;

  factory CoinModel.fromJson(String str) => CoinModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CoinModel.fromMap(Map<String, dynamic> json) => CoinModel(
        id: json["id"] ?? '',
        symbol: json["symbol"] ?? '',
        name: json["name"] ?? '',
        image: json["image"] ?? '',
        currentPrice: json["current_price"] ?? 0,
        marketCap: json["market_cap"] ?? 0,
        marketCapRank: json["market_cap_rank"] ?? 0,
        fullyDilutedValuation: json["fully_diluted_valuation"] ?? 0,
        totalVolume: json["total_volume"] ?? 0,
        high24H: json["high_24h"] ?? 0,
        low24H: json["low_24h"] ?? 0,
        priceChange24H: json["price_change_24h"] ?? 0,
        priceChangePercentage24H: json["price_change_percentage_24h"] ?? 0,
        marketCapChange24H: json["market_cap_change_24h"] ?? 0,
        marketCapChangePercentage24H:
            json["market_cap_change_percentage_24h"] ?? 0,
        circulatingSupply: json["circulating_supply"] ?? 0,
        totalSupply: json["total_supply"] ?? 0,
        maxSupply: json["max_supply"] ?? 0,
        ath: json["ath"] ?? 0,
        athChangePercentage: json["ath_change_percentage"] ?? 0,
        athDate: json["ath_date"] != null
            ? DateTime.parse(json["ath_date"])
            : DateTime.now(),
        atl: json["atl"] ?? 0,
        atlChangePercentage: json["atl_change_percentage"] ?? 0,
        atlDate: json["atl_date"] != null
            ? DateTime.parse(json["atl_date"])
            : DateTime.now(),
        roi: json["roi"] ?? '',
        lastUpdated: json["last_updated"] != null
            ? DateTime.parse(json["last_updated"])
            : DateTime.now(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "symbol": symbol ?? '',
        "name": name ?? '',
        "image": image ?? '',
        "current_price": currentPrice ?? 0,
        "market_cap": marketCap ?? 0,
        "market_cap_rank": marketCapRank ?? 0,
        "fully_diluted_valuation": fullyDilutedValuation ?? 0,
        "total_volume": totalVolume ?? 0,
        "high_24h": high24H ?? 0,
        "low_24h": low24H ?? 0,
        "price_change_24h": priceChange24H ?? 0,
        "price_change_percentage_24h": priceChangePercentage24H ?? 0,
        "market_cap_change_24h": marketCapChange24H ?? '',
        "market_cap_change_percentage_24h": marketCapChangePercentage24H ?? '',
        "circulating_supply": circulatingSupply ?? '',
        "total_supply": totalSupply ?? '',
        "max_supply": maxSupply ?? '',
        "ath": ath ?? '',
        "ath_change_percentage": athChangePercentage ?? '',
        "ath_date": athDate!.toIso8601String(),
        "atl": atl ?? '',
        "atl_change_percentage": atlChangePercentage ?? '',
        "atl_date": atlDate!.toIso8601String(),
        "roi": roi ?? '',
        "last_updated": lastUpdated!.toIso8601String(),
      };
}
