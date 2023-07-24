import 'package:delivery_app/core/core_shelf.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/onboard_providers.dart';
import 'get_started.dart';

class OnBoarding extends StatelessWidget {
  final String role;
  const OnBoarding({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, OnboardProvider state, Widget? child) {
        var item = role  == 'rider' ? riderPages(context)[state.page] : onboardPages(context)[state.page] ;

        return Container(
          width: w(context),
          height: h(context),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(item.imgPath.toImgPng), fit: BoxFit.cover),
          ),
          child: Stack(
            children: [
              Container(
                width: w(context),
                height: h(context),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.7),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              horizontalpadding(
                context,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: hh(context, 50)),
                    logo(
                      context,
                      foodStyle: head18(context, AppColors.white),
                      eStyle: head18(context, AppColors.primary),
                    ),
                    const Spacer(),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 1240),
                      child: item.title,
                    ),
                    Text(
                      item.message,
                      style: body(context, AppColors.white),
                    ),
                    SizedBox(height: hh(context, 50)),
                    SolidBorderedButton(
                      onTap: () {
                        if (state.page < 2) {
                          state.changePage(state.page + 1);
                        } else {
                          replaceTo(context,  GetStarted(role: role,));
                        }
                      },
                      text: state.page == 2 ? "GET STARTED" : "NEXT",
                      bgColor: AppColors.primary,
                      borderColor: AppColors.primary,
                      textColor: AppColors.white,
                    ),
                    SizedBox(height: hh(context, 50)),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class OnboardingModel {
  final int id;
  final String imgPath;
  final Widget title;
  final String message;

  OnboardingModel(this.id, this.imgPath, this.title, this.message);
}

List<OnboardingModel> onboardPages(BuildContext context) => [
      OnboardingModel(
        0,
        "ob0",
        SizedBox(
          width: ww(context, 129),
          child: RichText(
            text: TextSpan(
              style: head36(context, AppColors.white),
              children: [
                const TextSpan(
                  text: "AWESOME ",
                ),
                TextSpan(
                  text: "LOCAL ",
                  style: head36(context, AppColors.primary),
                ),
                const TextSpan(
                  text: "FOOD",
                ),
              ],
            ),
          ),
        ),
        "Discover delicious food from the amazing restaurants near you",
      ),
      OnboardingModel(
        1,
        "ob2",
        SizedBox(
          width: ww(context, 175),
          child: RichText(
            text: TextSpan(
              style: head36(context, AppColors.white),
              children: [
                const TextSpan(
                  text: "DELIVERED AT ",
                ),
                const TextSpan(
                  text: "YOUR ",
                ),
                TextSpan(
                  text: "DOORSTEP",
                  style: head36(context, AppColors.primary),
                ),
              ],
            ),
          ),
        ),
        "Fresh and delicious local food delivered from the restaurants to your doorstep",
      ),
      OnboardingModel(
        2,
        "ob1",
        SizedBox(
          width: ww(context, 222),
          child: RichText(
            text: TextSpan(
              style: head36(context, AppColors.white),
              children: [
                const TextSpan(
                  text: "GRAB THE BEST ",
                ),
                TextSpan(
                  text: "DEALS ",
                  style: head36(context, AppColors.primary),
                ),
                const TextSpan(
                  text: "AROUND",
                ),
              ],
            ),
          ),
        ),
        "Grab the best deals and discounts around and save on your every order",
      ),
    ];

List<OnboardingModel> riderPages(BuildContext context) => [
  OnboardingModel(
    0,
    "ob0",
    SizedBox(
      width: ww(context, 129),
      child: RichText(
        text: TextSpan(
          style: head36(context, AppColors.white),
          children: [
            const TextSpan(
              text: "EASY ",
            ),
            TextSpan(
              text: "LOCAL ",
              style: head36(context, AppColors.primary),
            ),
            const TextSpan(
              text: "RESTAURANTS",
            ),
          ],
        ),
      ),
    ),
    "Visit already discover restaurants near you",
  ),
  OnboardingModel(
    1,
    "ob1",
    SizedBox(
      width: ww(context, 175),
      child: RichText(
        text: TextSpan(
          style: head36(context, AppColors.white),
          children: [
            const TextSpan(
              text: "PICK UP ",
            ),
            const TextSpan(
              text: "ORDERS ",
            ),
            TextSpan(
              text: "SIMPLY",
              style: head36(context, AppColors.primary),
            ),
          ],
        ),
      ),
    ),
    "Get the order as your own from the restaurant",
  ),
  OnboardingModel(
    2,
    "ob2",
    SizedBox(
      width: ww(context, 222),
      child: RichText(
        text: TextSpan(
          style: head36(context, AppColors.white),
          children: [
            const TextSpan(
              text: "DELIVER ",
            ),
            TextSpan(
              text: "THE ",
              style: head36(context, AppColors.primary),
            ),
            const TextSpan(
              text: "ORDER",
            ),
          ],
        ),
      ),
    ),
    "Grab the order and deliver it to the same place",
  ),
];

