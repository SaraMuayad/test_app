import 'package:flutter/material.dart';

import 'package:test_app/component/currency_to_currency.dart';
import 'package:test_app/models/rates.dart';
import 'package:test_app/services/currencies_co.dart';

class ConvertCurrency extends StatefulWidget {
  const ConvertCurrency({Key? key}) : super(key: key);

  @override
  State<ConvertCurrency> createState() => _ConvertCurrencyState();
}

class _ConvertCurrencyState extends State<ConvertCurrency> {
  late Future<RatesModel> ratesModel;
  late Future<Map> currenciesModel;
  TextEditingController amountController = TextEditingController();

  String dropdownValue1 = 'AUD';
  String dropdownValue2 = 'AUD';
  String resultconvert = "Converted Currency";

  @override
  void initState() {
    super.initState();
    setState(() {
      ratesModel = fetchRates();
      currenciesModel = fetchCurrencies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF6F6F6),
        body: Center(
          child: Container(
            width: 450,
            height: 750,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(32.0)),
            child: FutureBuilder<RatesModel>(
                future: ratesModel,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return FutureBuilder<Map>(
                        future: currenciesModel,
                        builder: (context, index) {
                          if (index.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (index.hasError) {
                            return Center(child: Text('Error: ${index.error}'));
                          } else {
                            return CurrencyToCurrency(
                              currencies: index.data!,
                              rates: snapshot.data!.rates,
                            );
                          }
                        });
                  }
                }),
          ),
        ));
  }
}
