import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConvertCurrencyApi {
  final Uri currenci_url = Uri.https(
      "api.freecurrencyapi.com",
      "/v1/currencies",
      {"apikey": "fca_live_ozHIwdGaxzZIzWJY0oEP1VxkGeAQh7CHvMBj5bnI"});

  Future<List<String>> getCurrencies() async {
    Response res = await get(currenci_url);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var list = body["results"];
      List<String> currencies = (list.keys).toList();
      return currencies;
    } else {
      throw Exception("Failed to Connect API");
    }
  }
}
