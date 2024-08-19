class Coin {
  final String symbol;
  final String currentPrice;
  final String priceChange;
  final String priceChangePercent;

  Coin({
    required this.symbol,
    required this.currentPrice,
    required this.priceChange,
    required this.priceChangePercent,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      symbol: json['s'],
      currentPrice: json['c'],
      priceChange: json['p'],
      priceChangePercent: json['P'],
    );
  }
}
