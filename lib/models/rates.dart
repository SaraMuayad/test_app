import 'dart:convert';

RatesModel ratesModelFromJson(String str) =>
    RatesModel.fromJson(json.decode(str));

String ratesModelToJson(RatesModel data) => json.encode(data.toJson());

class RatesModel {
  String disclaimer;
  String license;
  int? timestamp;
  String base;
  Map<String, double> rates;

  RatesModel({
    required this.disclaimer,
    required this.license,
    required this.timestamp,
    required this.base,
    required this.rates,
  });

  factory RatesModel.fromJson(Map<String, dynamic> json) => RatesModel(
      disclaimer: json["disclaimer"].toString(),
      license: json["license"].toString(),
      timestamp: json["timestamp"],
      base: json["base"].toString(),
      rates: Map.from(json["rates"])
          .map((k, v) => MapEntry<String, double>(k, v.toDouble())));
// json['rates'] != null
//             ? Map.from(json["rates"])
//                 .map((k, v) => MapEntry<String, double>(k, v.toDouble()))
//             : {"Ubs": 90.0},

//  Map.from(json["rates"]).map((k, v) => MapEntry<String, double>(k, v.toDouble()))
  Map<String, dynamic> toJson() => {
        "disclaimer": disclaimer,
        "license": license,
        "timestamp": timestamp,
        "base": base,
        "rates": Map.from(rates).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
