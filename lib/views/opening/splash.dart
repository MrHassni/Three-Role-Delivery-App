import 'dart:async';

import 'package:delivery_app/core/providers/auth_providers.dart';
import 'package:delivery_app/core/shared_prefs/shared_prefs.dart';
import 'package:delivery_app/views/admin_home/admin_home.dart';
import 'package:delivery_app/views/main_page.dart';
import 'package:delivery_app/views/rider_home/rider_home.dart';
import 'package:delivery_app/views/select_role/select_role.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../core/init/metrics.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_theme.dart';
import '../../core/widgets/logo/logo.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  bool loggedIn = false;
  String? role;


  chkLogIn() async {
    await SharedPrefs.getUserLoggedInSharedPreference().then((value) async {
      if(value == null || value == false){
        return;
      }else{
        Provider.of<AuthProvider>(context, listen: false).dataFromSharedPrefs();
        role = await SharedPrefs.getUserRoleSharedPreference();
        setState(() {
          loggedIn = true;
          role = role;
        });

      }
    });
  }

  void navigationPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>  AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.light,
          ),
          child: loggedIn ?
          role == 'rider' ? const RiderHome()
              : role == 'user' ?  const MainPage() : role == 'admin' ?  const AdminHome()
              : const Scaffold(
                body: Center(
                  child: Text(
                    'No Page Available'
            ),
          ),
              ) : const SelectRoleScreen(),
        ),
      ),
    );
  }

  startTime() async {
    var duration = const Duration(milliseconds: 4000);
    return Timer(duration, navigationPage);
  }

  @override
  void initState() {
    super.initState();
    chkLogIn();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: w(context),
        height: h(context),
        color: bgPrimary(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(),
            logo(context),
            const Spacer(),
            Text(
              "by Aspire Analytica",
              style: titleMedium(context, AppColors.grey),
            ),
            SizedBox(height: hh(context, 24)),
          ],
        ),
      ),
    );
  }
}
