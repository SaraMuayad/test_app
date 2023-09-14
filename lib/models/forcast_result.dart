import 'package:test_app/models/weather_result.dart';

class ForcastResult {
  List<ListResult>? list;

  ForcastResult({this.list});

  ForcastResult.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <ListResult>[];
      json['list'].forEach((v) {
        list!.add(ListResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};

    if (list != null) {
      data['list'] = list!.map((e) => e.toJson()).toList();
    }

    return data;
  }
}

class ListResult {
  int? dt;
  Main? main;
  List<Weather>? weather;

  ListResult({this.dt, this.main, this.weather});

  ListResult.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    main = json['main'] != null ? Main.fromJson(json['main']) : null;
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};

    if (main != null) {
      data['main'] = main!.toJson();
    }
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
