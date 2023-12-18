import 'package:cryptobaz/data/models/crypto.dart';
import 'package:cryptobaz/screens/coinlist-page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var response = await Dio().get("https://api.coincap.io/v2/assets");

    List<Crypto> cryptoList = response.data["data"]
        .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
        .toList();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CoinListScreen(
                  cryptoList: cryptoList,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: []),
      body: SafeArea(
        child: Text("Ami"),
      ),
    );
  }
}
