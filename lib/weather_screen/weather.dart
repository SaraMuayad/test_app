import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:test_app/Utils/weather_icons.dart';
import 'package:test_app/models/forcast_result.dart';
import 'package:test_app/models/open_weather_mapclient.dart';
import 'package:test_app/models/weather_result.dart';
import 'package:test_app/state/state.dart';
import '../Utils/colors.dart';

class Weather extends StatefulWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  final controller = Get.put(StateController());
  var location = Location();
  late StreamSubscription listener;
  late PermissionStatus permissionStatus;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) async {
      await enableLocationListener();
    });
    super.initState();
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: Center(
          child: Obx(
        () => Container(
            height: size.height,
            width: size.height,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: controller.locationData.value.latitude != null
                ? FutureBuilder(
                    future: OpenWeatherMapClient()
                        .getWeather(controller.locationData.value),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (!snapshot.hasData) {
                        return const Text("No data have");
                      } else {
                        var data = snapshot.data as WeatherResult;

                        double? currTemp =
                            data.main!.temp; // current temperature
                        double? maxTemp =
                            data.main!.tempMax; // today max temperature
                        double? minTemp =
                            data.main!.tempMin; // today min temperature
                        return SafeArea(
                          child: Stack(
                            children: [
                              SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: size.height * 0.01,
                                        horizontal: size.width * 0.05,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            child: Text(
                                              'Weather',
                                              style: TextStyle(
                                                color: const Color(0xff1D1617),
                                                fontSize: size.height * 0.02,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              controller.locationData.value =
                                                  await location.getLocation();
                                            },
                                            icon: const FaIcon(
                                              FontAwesomeIcons.refresh,
                                              color: Colors.black,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: size.height * 0.03,
                                      ),
                                      child: Align(
                                        child: Text(
                                          data.name.toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: size.height * 0.003,
                                      ),
                                      child: Align(
                                        child: Text(
                                          '${data.main!.temp.toString()}°', //curent temperature
                                          style: TextStyle(
                                            color: currTemp! <= 0.0
                                                ? Colors.blue
                                                : currTemp > 0.0 &&
                                                        currTemp <= 15.0
                                                    ? Colors.indigo
                                                    : currTemp > 15.0 &&
                                                            currTemp < 30.0
                                                        ? Colors.deepPurple
                                                        : Colors.pink,
                                            fontSize: size.height * 0.1,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: size.height * 0.003,
                                        // bottom: size.height * 0.01,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '$minTemp˚', // min temperature
                                            style: TextStyle(
                                              color: minTemp! <= 0
                                                  ? Colors.blue
                                                  : minTemp > 0 && minTemp <= 15
                                                      ? Colors.indigo
                                                      : minTemp > 15 &&
                                                              minTemp < 30
                                                          ? Colors.deepPurple
                                                          : Colors.pink,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const Text(
                                            '/',
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            '$maxTemp˚', //max temperature
                                            style: TextStyle(
                                              color: maxTemp! <= 0
                                                  ? Colors.blue
                                                  : maxTemp > 0 && maxTemp <= 15
                                                      ? Colors.indigo
                                                      : maxTemp > 15 &&
                                                              maxTemp < 30
                                                          ? Colors.deepPurple
                                                          : Colors.pink,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: size.height * 0.005,
                                      ),
                                      child: Align(
                                          child: Text(
                                              style:
                                                  const TextStyle(fontSize: 15),
                                              data.weather![0].description ??
                                                  '')),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.05,
                                      ),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              ColorResources.purple4D5,
                                              ColorResources.redD90
                                            ],
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          // color: isDarkMode
                                          //     ? Colors.white.withOpacity(0.05)
                                          //     : Colors.black.withOpacity(0.05),
                                        ),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  top: size.height * 0.01,
                                                  left: size.width * 0.03,
                                                ),
                                                child: Text(
                                                  'Forecast for today',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        size.height * 0.025,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Divider(color: Colors.white),
                                            Padding(
                                                padding: EdgeInsets.all(
                                                    size.width * 0.005),
                                                child: FutureBuilder(
                                                  future: OpenWeatherMapClient()
                                                      .getForcast(controller
                                                          .locationData.value),
                                                  builder: (context,
                                                      AsyncSnapshot snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Colors.black,
                                                        ),
                                                      );
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return Center(
                                                        child: Text(snapshot
                                                            .error
                                                            .toString()),
                                                      );
                                                    } else if (!snapshot
                                                        .hasData) {
                                                      return const Text(
                                                          "No data have");
                                                    } else {
                                                      var dataforcast =
                                                          snapshot.data
                                                              as ForcastResult;

                                                      return SizedBox(
                                                        width: 320,
                                                        height: 150,
                                                        child: ListView.builder(
                                                          itemCount: dataforcast
                                                              .list!.length,
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemBuilder:
                                                              ((context,
                                                                  index) {
                                                            var item =
                                                                dataforcast
                                                                        .list![
                                                                    index];
                                                            return buildForecastToday(
                                                              DateFormat(
                                                                      'HH:mm')
                                                                  .format(DateTime.fromMillisecondsSinceEpoch(
                                                                      (item.dt ??
                                                                              0) *
                                                                          1000))
                                                                  .toString(), //hour

                                                              item.main!.temp!
                                                                  .toDouble(), //temperature

                                                              buildWeatherIcon(item
                                                                      .weather![
                                                                          0]
                                                                      .icon ??
                                                                  ''),

                                                              //weather icon
                                                              size,
                                                              isDarkMode,
                                                            );
                                                          }),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.05,
                                        vertical: size.height * 0.02,
                                      ),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              ColorResources.purple4D5,
                                              ColorResources.redD90
                                            ],
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  top: size.height * 0.02,
                                                  left: size.width * 0.03,
                                                ),
                                                child: Text(
                                                  '7-day forecast',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        size.height * 0.025,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              color: isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(
                                                  size.width * 0.005),
                                              child: Column(
                                                children: [
                                                  buildSevenDayForecast(
                                                    "Today", //day
                                                    minTemp, //min temperature
                                                    maxTemp, //max temperature

                                                    size,
                                                    isDarkMode,
                                                  ),
                                                  buildSevenDayForecast(
                                                    "Wed",
                                                    -5,
                                                    5,
                                                    size,
                                                    isDarkMode,
                                                  ),
                                                  buildSevenDayForecast(
                                                    "Thu",
                                                    -2,
                                                    7,
                                                    size,
                                                    isDarkMode,
                                                  ),
                                                  buildSevenDayForecast(
                                                    "Fri",
                                                    3,
                                                    10,
                                                    size,
                                                    isDarkMode,
                                                  ),
                                                  buildSevenDayForecast(
                                                    "San",
                                                    5,
                                                    12,
                                                    size,
                                                    isDarkMode,
                                                  ),
                                                  buildSevenDayForecast(
                                                    "Sun",
                                                    4,
                                                    7,
                                                    size,
                                                    isDarkMode,
                                                  ),
                                                  buildSevenDayForecast(
                                                    "Mon",
                                                    -2,
                                                    1,
                                                    size,
                                                    isDarkMode,
                                                  ),
                                                  buildSevenDayForecast(
                                                    "Tues",
                                                    0,
                                                    3,
                                                    size,
                                                    isDarkMode,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                        ;
                      }
                    })
                : const Text("Wating...")),
      )),
    );
  }

  Future<void> enableLocationListener() async {
    controller.enableLocation.value = await location.serviceEnabled();
    if (!controller.enableLocation.value) {
      controller.enableLocation.value = await location.requestService();
      if (!controller.enableLocation.value) {
        return;
      }
    }
    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return;
      }
    }
    controller.locationData.value = await location.getLocation();
    listener = location.onLocationChanged.listen((event) {});
  }
}

// weights
Widget buildForecastToday(
    String time, double temp, String weatherIcon, size, bool isDarkMode) {
  return Padding(
    padding: EdgeInsets.all(size.width * 0.025),
    child: Column(
      children: [
        Text(
          time,
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: size.height * 0.02,
          ),
        ),
        Row(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.005,
                ),
                child: CachedNetworkImage(
                  imageUrl: weatherIcon,
                  height: 50,
                  width: 50,
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )),
          ],
        ),
        Text(
          '$temp˚',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: size.height * 0.025,
          ),
        ),
      ],
    ),
  );
}
// End of Weight

// weight
Widget buildSevenDayForecast(
    String time, double minTemp, double maxTemp, size, bool isDarkMode) {
  return Padding(
    padding: EdgeInsets.all(
      size.height * 0.005,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.02,
              ),
              child: Text(
                time,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: size.height * 0.025,
                ),
              ),
            ),
            Align(
              child: Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.15,
                ),
                child: Text(
                  '$minTemp˚C',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white38 : Colors.black38,
                    fontSize: size.height * 0.025,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                ),
                child: Text(
                  '$maxTemp˚C',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: size.height * 0.025,
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ],
    ),
  );
}
