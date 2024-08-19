import 'package:crypto_app/constants/routes.dart';
import 'package:crypto_app/views/Home_view.dart';
import 'package:crypto_app/views/coins_view.dart';
import 'package:crypto_app/views/profile_view.dart';
import 'package:crypto_app/views/wallet_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        homeRoute: (context) => const Home(),
        coinRoute: (context) => const Coins(),
        walletRoute: (context) => const Wallet(),
        profileRoute: (context) => const Profile(),
      },
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  List screens = const [
    Home(),
    Coins(),
    Wallet(),
    Profile(),
  ];

  List screenName = const [
    'Home',
    'Coins',
    'Wallet',
    'Profile',
  ];
  static const primaryColor = Color(0xFFc1d3fe);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(screenName[currentIndex]),
        centerTitle: false,
        backgroundColor: primaryColor,
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.toll),
            label: 'Coins',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
