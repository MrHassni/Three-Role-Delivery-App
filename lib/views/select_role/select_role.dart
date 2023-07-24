import 'dart:developer';
import 'package:delivery_app/core/core_shelf.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../opening/onboarding/get_started.dart';
import '../opening/onboarding/onboarding.dart';

class SelectRoleScreen extends StatefulWidget {
  const SelectRoleScreen({Key? key}) : super(key: key);

  @override
  State<SelectRoleScreen> createState() => _SelectRoleScreenState();
}

class _SelectRoleScreenState extends State<SelectRoleScreen> {


  startTime(r) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool('first_time');


    if (firstTime != null && !firstTime) {
      return  navigationPageHome(r);
    } else {
      prefs.setBool('first_time', false);
      return navigationPageWel(r);
    }
  }

  void navigationPageHome(r) {
    Navigator.push (
        context, MaterialPageRoute(builder: (context) => GetStarted(role: r)));
  }

  void navigationPageWel(r) {
    if(r != 'admin') {
      Navigator.push(
        context, MaterialPageRoute(builder: (context) =>  OnBoarding(role: r,)));
    }else
      {
        Navigator.push (
            context, MaterialPageRoute(builder: (context) => GetStarted(role: r)));
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height ,
        padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 50),
        color: bgPrimary(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            logo(context),
            const Spacer(),
            InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                startTime('user');
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) =>  const OnBoarding(isRider: false,)));
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/food.png',
                      height: hh(context, 80),
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                     Text(
                      'Order Now\nThe Best Deals',
                      textAlign: TextAlign.center,
                      style: head24(context, textPrimary(context)),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                startTime('rider');
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const OnBoarding(isRider: true,)));
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/bike.png',
                      height: hh(context, 80),
                      color: AppColors.primary,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                     Text(
                      'Pick Up\nThe Orders Now',
                      textAlign: TextAlign.center,
                      style: head24(context, AppColors.primary),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                startTime('admin');
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.black, borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/admin.png',
                      height: hh(context, 80),
                      color: AppColors.primary,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Manage Users,\nProducts & Orders',
                      textAlign: TextAlign.center,
                      style: head24(context, AppColors.primary),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
