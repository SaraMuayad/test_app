import 'package:test_app/Utils/key.dart';
import 'package:test_app/models/currencies.dart';
import 'package:test_app/models/rates.dart';
import 'package:http/http.dart' as http;

Future<RatesModel> fetchRates() async {
  var response = await http.get(Uri.parse(
      'https://openexchangerates.org/api/latest.json?base=USD&app_id=$apiCurrenyKey'));
  final ratesModel = ratesModelFromJson(response.body);
  return ratesModel;
}

Future<Map> fetchCurrencies() async {
  var response = await http.get(Uri.parse(
      'https://openexchangerates.org/api/currencies.json?app_id=$apiCurrenyKey'));
  final allCurrencies = allCurrenciesFromJson(response.body);
  return allCurrencies;
}
