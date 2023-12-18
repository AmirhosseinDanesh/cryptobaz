import 'package:cryptobaz/data/models/crypto.dart';
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
      appBar: AppBar(actions: []),
      body: SafeArea(
        child: ListView.builder(
          itemCount: cryptoList!.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(cryptoList![index].name),
                subtitle: Text(cryptoList![index].symbol),
                leading: SizedBox(
                  width: 30.0,
                  child: Center(
                    child: Text(cryptoList![index].rank.toString()),
                  ),
                ),
                trailing: SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            cryptoList![index].priceUsd.toStringAsFixed(2),
                          ),
                          Text(cryptoList![index]
                              .changePercent24Hr
                              .toStringAsFixed(2)),
                        ],
                      ),
                      SizedBox(
                        width: 30.0,
                        child: Center(
                            child: _getIconForChangePercent(
                                cryptoList![index].changePercent24Hr)),
                      )
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }

  Widget _getIconForChangePercent(double changePercent) {
    return changePercent <= 0
        ? Icon(
            Icons.trending_down,
            size: 24,
            color: Colors.red,
          )
        : Icon(
            Icons.trending_up,
            size: 24,
            color: Colors.green,
          );
  }
}
