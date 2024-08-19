import 'package:crypto_app/models/coin_data.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class Coins extends StatefulWidget {
  const Coins({super.key});

  @override
  State<Coins> createState() => _CoinsState();
}

class _CoinsState extends State<Coins> {
  final WebSocketChannel channel = WebSocketChannel.connect(
    Uri.parse('ws://prereg.ex.api.ampiy.com/prices'),
  );

  List<Coin> coins = [];
  List<Coin> filteredCoins = []; // List to store filtered coins
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Subscribe to the WebSocket channel
    channel.sink.add(json.encode({
      "method": "SUBSCRIBE",
      "params": ["all@ticker"],
      "cid": 1,
    }));

    // Listen for incoming messages
    channel.stream.listen((data) {
      final decodedData = json.decode(data);
      final List<Coin> newCoins = (decodedData['data'] as List)
          .map((coinData) => Coin.fromJson(coinData))
          .toList();

      setState(() {
        coins = newCoins;
        filteredCoins = newCoins; // Initialize filteredCoins with all coins
      });
    });
  }

  void filterCoins(String query) {
    final filtered = coins.where((coin) {
      final coinSymbol = coin.symbol.toLowerCase();
      final input = query.toLowerCase();

      return coinSymbol.contains(input);
    }).toList();

    setState(() {
      filteredCoins = filtered;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: filterCoins, // Call filterCoins when input changes
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredCoins.length,
            itemBuilder: (context, index) {
              final coin = filteredCoins[index];

              return Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.monetization_on),
                    title: Text(
                      coin.symbol.substring(0, coin.symbol.length - 3),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(coin.symbol),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '(${coin.priceChangePercent})',
                          style: TextStyle(
                            color: double.parse(coin.priceChange) >= 0
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        Text('LTP: ${coin.currentPrice}'),
                      ],
                    ),
                  ),
                  const Divider(), // This adds the divider between ListTiles
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
