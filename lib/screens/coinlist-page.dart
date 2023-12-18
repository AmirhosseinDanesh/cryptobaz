import 'package:cryptobaz/data/constants/constants.dart';
import 'package:cryptobaz/data/models/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CoinListScreen extends StatefulWidget {
  CoinListScreen({super.key, this.cryptoList});
  List<Crypto>? cryptoList;
  @override
  State<CoinListScreen> createState() => _CoinListScreenState();
}

class _CoinListScreenState extends State<CoinListScreen> {
  List<Crypto>? cryptoList;
  @override
  void initState() {
    super.initState();
    cryptoList = widget.cryptoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        title: Text(
          "کریپتو باز",
          style: TextStyle(fontFamily: "morabaee"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: blackColor,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: greenColor,
          color: blackColor,
          onRefresh: () async {
            List<Crypto> freshData = await _getData();
            setState(() {
              cryptoList = freshData;
            });
          },
          child: ListView.builder(
            itemCount: cryptoList!.length,
            itemBuilder: (context, index) {
              return _getListTileItem(cryptoList![index]);
            },
          ),
        ),
      ),
    );
  }

  Widget _getListTileItem(Crypto crypto) {
    return ListTile(
      title: Text(
        crypto.name,
        style: TextStyle(color: greenColor),
      ),
      subtitle: Text(
        crypto.symbol,
        style: TextStyle(color: greyColor),
      ),
      leading: SizedBox(
        width: 30.0,
        child: Center(
          child: Text(
            crypto.rank.toString(),
            style: TextStyle(color: greyColor),
          ),
        ),
      ),
      trailing: SizedBox(
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  crypto.priceUsd.toStringAsFixed(2),
                  style: TextStyle(color: greyColor, fontSize: 17),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  crypto.changePercent24Hr.toStringAsFixed(2),
                  style: TextStyle(
                      color:
                          _getColorForChangePercent(crypto.changePercent24Hr)),
                ),
              ],
            ),
            SizedBox(
              width: 30.0,
              child: Center(
                  child: _getIconForChangePercent(crypto.changePercent24Hr)),
            )
          ],
        ),
      ),
    );
  }

  Widget _getIconForChangePercent(double changePercent) {
    return changePercent <= 0
        ? Icon(
            Icons.trending_down,
            size: 24,
            color: redColor,
          )
        : Icon(
            Icons.trending_up,
            size: 24,
            color: greenColor,
          );
  }

  Color _getColorForChangePercent(double changePercent) {
    return changePercent <= 0 ? redColor : greenColor;
  }

  Future<List<Crypto>> _getData() async {
    var response = await Dio().get("https://api.coincap.io/v2/assets");

    List<Crypto> cryptoList = response.data["data"]
        .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
        .toList();

    return cryptoList;
  }
}
