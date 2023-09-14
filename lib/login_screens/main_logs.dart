import 'package:flutter/material.dart';
import 'package:test_app/Utils/colors.dart';
import 'package:test_app/login_screens/login.dart';
import 'package:test_app/login_screens/signup.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test_app/services/authentication.dart';

import '../Utils/shape_indator_tab.dart';
import '../home/my_home_page.dart';

class MainLogs extends StatefulWidget {
  const MainLogs({Key? key}) : super(key: key);

  @override
  State<MainLogs> createState() => _MainLogsState();
}

class _MainLogsState extends State<MainLogs> with TickerProviderStateMixin {
  Authentication auth = Authentication();

  List screens = [const LoginScreen(), const SignUpscreen()];
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    setState(() {
      _tabController;
    });
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Container(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 400,
                    height: 400,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      colors: [ColorResources.purple4D5, ColorResources.redD90],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    )),
                    child: Padding(
                        padding: const EdgeInsets.only(
                            top: 100, left: 10, right: 10),
                        child: Column(
                          children: const [
                            Text(
                              "Welcome",
                              style: TextStyle(
                                  letterSpacing: 35,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontFamily: 'RobotoRegular'),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "To",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                  color: Colors.white,
                                  fontFamily: 'RobotoRegular'),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "World Of Testing",
                              style: TextStyle(
                                  letterSpacing: 7,
                                  wordSpacing: 5,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontFamily: 'RobotoRegular'),
                            ),
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 230),
                    child: Center(
                      child: Container(
                          width: 330,
                          height: 450,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: TabBar(
                                    controller: _tabController,
                                    indicatorSize: TabBarIndicatorSize.label,
                                    indicatorColor: ColorResources.purple4D5,
                                    labelColor: Colors.black,
                                    labelStyle: const TextStyle(fontSize: 14.0),
                                    unselectedLabelColor: const Color.fromARGB(
                                        255, 176, 175, 175),
                                    indicator: CircleTabIndicator(
                                        color: ColorResources.black0F1,
                                        radius: 4),
                                    tabs: const [
                                      Tab(
                                        text: 'Login',
                                      ),
                                      Tab(
                                        text: "SignUp",
                                      ),
                                    ]),
                              ),
                              Expanded(
                                child: TabBarView(
                                  controller: _tabController,
                                  children: const [
                                    LoginScreen(),
                                    SignUpscreen()
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
              const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text("Or SignUp with")),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: 300,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          auth.SinginWithGoogle();
                        },
                        child: Container(
                            width: 100,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                FaIcon(
                                  FontAwesomeIcons.google,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "google",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            )),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                            width: 100,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                FaIcon(
                                  FontAwesomeIcons.github,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Github",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: InkWell(
                      onTap: () {
                        auth.SignInAnony();
                      },
                      child: const Text("Anonymous")))
            ],
          ),
        ));
  }
}
