import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:test_app/Utils/colors.dart';
import 'package:test_app/weather_screen/weather.dart';

import '../currency_screen/convert_currency.dart';
import '../profile/profile_account.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _index = 0;
  double gap = 10;

  List screen = [
    const Weather(),
    const ConvertCurrency(),
    const Profile(),
  ];
  List<Color> colors = [
    const Color(0xff212121),
    const Color(0xff6E6E6E),
    const Color(0xff525252),
    const Color(0xff333333),
  ];
  List<Text> texts = [
    const Text(
      "Home",
      style: TextStyle(fontSize: 30.0, color: Colors.white),
    ),
    const Text("Likes", style: TextStyle(fontSize: 30.0, color: Colors.white)),
    const Text("Sreach", style: TextStyle(fontSize: 30.0, color: Colors.white)),
    const Text("Settings",
        style: TextStyle(fontSize: 30.0, color: Colors.white))
  ];

  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
            itemCount: 4,
            controller: _pageController,
            onPageChanged: (value) {
              _index = value;
              setState(() {});
            },
            itemBuilder: (context, index) {
              return Container(
                color: colors[index],
                // child: Center(child: texts[index]),
                child: screen[index],
              );
            }),
        bottomNavigationBar: Container(
          color: const Color(0xffffffff),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: GNav(
              backgroundColor: const Color(0xffffffff),
              color: Colors.purple.withOpacity(0.1),
              activeColor: const Color(0xfffffffff),
              duration: const Duration(milliseconds: 500),
              tabBackgroundColor: const Color(0xffffffff),
              gap: 10,
              padding: const EdgeInsets.all(15),
              tabs: [
                GButton(
                  gap: gap,
                  backgroundGradient: const LinearGradient(
                    colors: [ColorResources.purple4D5, ColorResources.redD90],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  iconColor: Colors.purple,
                  icon: Icons.cloud,
                  text: 'Weather',
                ),
                GButton(
                  gap: gap,
                  backgroundGradient: const LinearGradient(
                    colors: [ColorResources.purple4D5, ColorResources.redD90],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  iconColor: Colors.purple,
                  icon: Icons.currency_exchange,
                  text: 'Convert',
                ),
                GButton(
                  gap: gap,
                  backgroundGradient: const LinearGradient(
                    colors: [ColorResources.purple4D5, ColorResources.redD90],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  iconColor: Colors.purple,
                  icon: Icons.person,
                  text: 'Account',
                ),
              ],
              selectedIndex: _index,
              onTabChange: (value) {
                setState(() {
                  _index = value;
                });
                _pageController.jumpToPage(value);
              },
            ),
          ),
        ));
  }
}
