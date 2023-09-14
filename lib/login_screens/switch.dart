import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/login_screens/login.dart';
import 'package:test_app/login_screens/main_logs.dart';

import '../home/my_home_page.dart';
import '../models/user.dart';

class Switch_Page extends StatelessWidget {
  const Switch_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<Users?>(context);
    if (userState == null) {
      return MainLogs();
    } else {
      return MyHomePage();
    }
  }
}
