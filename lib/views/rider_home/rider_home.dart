import 'dart:developer';

import 'package:delivery_app/core/core_shelf.dart';
import 'package:delivery_app/core/providers/auth_providers.dart';
import 'package:delivery_app/core/providers/order_provider.dart';
import 'package:delivery_app/views/my_brands_screen/my_brands_screen.dart';
import 'package:delivery_app/views/rider_orders_screens/rider_order_screen.dart';
import 'package:delivery_app/views/select_role/select_role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../core/models/user_model.dart';
import '../base.dart';

class RiderHome extends StatelessWidget {
  const RiderHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Base(
      child: Consumer<OrderProvider>(
        builder: (context, provider, child) =>
            SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: hh(context, 50)),
            horizontalpadding(
              context,
              child: RichText(
                text: TextSpan(
                  style: bigBody(context, textPrimary(context)),
                  children: [
                    const TextSpan(
                      text: "Hello, ",
                    ),
                    TextSpan(
                      text: Provider.of<AuthProvider>(context, listen: false).currentUser!.firstName.toString(),
                      style: bigBody(context, AppColors.primary),
                    ),
                    const TextSpan(
                      text: " !",
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: hh(context, 10)),
            InkWell(
              onTap: (){
                List brands = [];
                UserModel user =  Provider.of<AuthProvider>(context, listen: false).currentUser!;
                if(user.brands != null && user.brands!.isNotEmpty){
                for(int i =0; i < user.brands!.length; i++){
                  brands.add(user.brands![i]['id']);
                }
                provider.getAllOrdersForRider(brands).then((_){
                  if(provider.riderPendingOrders.isNotEmpty) {
                    pushTo(context, RiderOrdersScreen(title: 'PENDING ORDERS', list: provider.riderPendingOrders));
                  } else {
                    OverlayState overlayState = Overlay.of(context);
                    showTopSnackBar(
                      overlayState,
                      const CustomSnackBar.error(
                        message:
                        "NO PENDING ORDERS AVAILABLE",
                      ),
                    );
                  }
                });}
              },
              child: Container(
                width: w(context),
                height: hh(context, 190),
                padding: EdgeInsets.all(w20(context)),
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    w20(context),
                    w20(context),
                    w20(context),
                    hh(context, 10),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(ww(context, 10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        offset: Offset(0, hh(context, 4)),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: head36(context, AppColors.white),
                          children: [
                             const TextSpan(
                              text: "New ",
                            ),
                            TextSpan(
                              text: " Orders",
                              style: head24(context, AppColors.dark),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset(
                          'assets/images/bike.png',
                          color: Colors.white,
                          height: hh(context, 60),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: (){
    List brands = [];
    UserModel user =  Provider.of<AuthProvider>(context, listen: false).currentUser!;
    if(user.brands != null && user.brands!.isNotEmpty){
    for(int i =0; i < user.brands!.length; i++){
    brands.add(user.brands![i]['id']);
    }
                    provider.getAllOrdersForRider(brands).then((_){
                      if(provider.riderInProgressOrders.isNotEmpty) {
                        pushTo(context, RiderOrdersScreen(title: 'IN PROGRESS ORDERS', list: provider.riderInProgressOrders));
                      } else {
                        OverlayState overlayState = Overlay.of(context);
                        showTopSnackBar(
                          overlayState,
                          const CustomSnackBar.error(
                            message:
                            "NO IN PROGRESS ORDERS AVAILABLE",
                          ),
                        );
                      }
                    });}
                  },
                  child: SizedBox(
                    width: (w(context) / 2),
                    child: Container(
                      margin: EdgeInsets.only(left: w20(context), right: 10),
                      padding: EdgeInsets.fromLTRB(
                        w20(context),
                        w20(context),
                        w20(context),
                        hh(context, 10),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(ww(context, 10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            offset: Offset(0, hh(context, 4)),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: RichText(
                        text: TextSpan(
                          style: head36(context, AppColors.primary),
                          children: [
                            const TextSpan(
                              text: "Orders\n",
                            ),
                            TextSpan(
                              text: "In Progress",
                              style: head24(context, AppColors.dark),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    List brands = [];
                    UserModel user =  Provider.of<AuthProvider>(context, listen: false).currentUser!;
                    if(user.brands != null && user.brands!.isNotEmpty){
                      for(int i =0; i < user.brands!.length; i++){
                        brands.add(user.brands![i]['id']);
                      }
                    provider.getAllOrdersForRider(brands).then((_){
                      if(provider.riderCanceledOrders.isNotEmpty) {
                        pushTo(context, RiderOrdersScreen(title: 'CANCELLED ORDERS', list: provider.riderCanceledOrders));
                      } else {
                        OverlayState overlayState = Overlay.of(context);
                        showTopSnackBar(
                          overlayState,
                          const CustomSnackBar.error(
                            message:
                            "NO CANCELLED ORDERS AVAILABLE",
                          ),
                        );
                      }
                    });}
                  },
                  child: SizedBox(
                    width: (w(context) / 2),
                    child: Container(
                      margin: EdgeInsets.only(right: w20(context), left: 10),
                      padding: EdgeInsets.fromLTRB(
                        w20(context),
                        w20(context),
                        w20(context),
                        hh(context, 10),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(ww(context, 10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            offset: Offset(0, hh(context, 4)),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: RichText(
                        text: TextSpan(
                          style: head36(context, AppColors.white),
                          children: [
                            const TextSpan(
                              text: "Canceled\n",
                            ),
                            TextSpan(
                              text: "Orders",
                              style: head24(context, AppColors.dark),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: hh(context, 25)),
            Row(
              children: [
                InkWell(
                  onTap: (){
                    List brands = [];
                    UserModel user =  Provider.of<AuthProvider>(context, listen: false).currentUser!;
                    if(user.brands != null && user.brands!.isNotEmpty){
                      for(int i =0; i < user.brands!.length; i++){
                        brands.add(user.brands![i]['id']);
                      }
                    provider.getAllOrdersForRider(brands).then((_){
                      if(provider.riderDeclinedOrders.isNotEmpty) {
                        pushTo(context, RiderOrdersScreen(title: 'DECLINED ORDERS', list: provider.riderDeclinedOrders));
                      } else {
                        OverlayState overlayState = Overlay.of(context);
                        showTopSnackBar(
                          overlayState,
                          const CustomSnackBar.error(
                            message:
                            "NO DECLINED ORDERS AVAILABLE",
                          ),
                        );
                      }
                    });}
                  },
                  child: SizedBox(
                    width: (w(context) / 2),
                    child: Container(
                      margin: EdgeInsets.only(left: w20(context), right: 10),
                      padding: EdgeInsets.fromLTRB(
                        w20(context),
                        w20(context),
                        w20(context),
                        hh(context, 10),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(ww(context, 10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.15),
                            offset: Offset(0, hh(context, 4)),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: RichText(
                        text: TextSpan(
                          style: head36(context, AppColors.white),
                          children: [
                            const TextSpan(
                              text: "Declined\n",
                            ),
                            TextSpan(
                              text: "Orders",
                              style: head24(context, AppColors.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    List brands = [];
                    UserModel user =  Provider.of<AuthProvider>(context, listen: false).currentUser!;
                    if(user.brands != null && user.brands!.isNotEmpty){
                      for(int i =0; i < user.brands!.length; i++){
                        brands.add(user.brands![i]['id']);
                      }
                    provider.getAllOrdersForRider(brands).then((_){
                      if(provider.allOrders.isNotEmpty) {
                        pushTo(context, RiderOrdersScreen(title: 'ORDER HISTORY', list: provider.riderCompletedOrders));
                      } else {
                        OverlayState overlayState = Overlay.of(context);
                        showTopSnackBar(
                          overlayState,
                          const CustomSnackBar.error(
                            message:
                            "NO ORDERS HISTORY AVAILABLE",
                          ),
                        );
                      }
                    });}
                  },
                  child: SizedBox(
                    width: (w(context) / 2),
                    child: Container(
                      margin: EdgeInsets.only(right: w20(context), left: 10),
                      padding: EdgeInsets.fromLTRB(
                        w20(context),
                        w20(context),
                        w20(context),
                        hh(context, 10),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(ww(context, 10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            offset: Offset(0, hh(context, 4)),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: RichText(
                        text: TextSpan(
                          style: head36(context, AppColors.dark),
                          children: [
                            const TextSpan(
                              text: "Order\n",
                            ),
                            TextSpan(
                              text: "History",
                              style: head24(context, AppColors.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: hh(context, 25)),
            Row(
              children: [
                InkWell(
                  onTap: (){
                    OverlayState overlayState = Overlay.of(context);
                    showTopSnackBar(
                        overlayState,
                        const CustomSnackBar.info(
                        message:
                        "NO RECORD AVAILABLE YET",
                    ),);
                  },
                  child: SizedBox(
                    width: (w(context) / 2),
                    child: Container(
                      margin: EdgeInsets.only(left: w20(context), right: 10),
                      padding: EdgeInsets.fromLTRB(
                        w20(context),
                        w20(context),
                        w20(context),
                        hh(context, 10),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(ww(context, 10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            offset: Offset(0, hh(context, 4)),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: RichText(
                        text: TextSpan(
                          style: head36(context, AppColors.dark),
                          children: [
                            const TextSpan(
                              text: "Total\n",
                            ),
                            TextSpan(
                              text: "Earnings",
                              style: head24(context, AppColors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    if(Provider.of<AuthProvider>(context, listen: false).currentUser!.brands != null &&
                        Provider.of<AuthProvider>(context, listen: false).currentUser!.brands!.isNotEmpty){
                      pushTo(context, const MyBrandsScreen());
                    } else {
                      OverlayState overlayState = Overlay.of(context);
                      showTopSnackBar(
                        overlayState,
                        const CustomSnackBar.error(
                          message:
                          "NO RESTAURANTS AVAILABLE",
                        ),
                      );
                    }
                  },
                  child: SizedBox(
                    width: (w(context) / 2),
                    child: Container(
                      margin: EdgeInsets.only(right: w20(context), left: 10),
                      padding: EdgeInsets.fromLTRB(
                        w20(context),
                        w20(context),
                        w20(context),
                        hh(context, 10),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(ww(context, 10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.15),
                            offset: Offset(0, hh(context, 4)),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: RichText(
                        text: TextSpan(
                          style: head36(context, AppColors.primary),
                          children: [
                            const TextSpan(
                              text: "My\n",
                            ),
                            TextSpan(
                              text: "Restaurants",
                              style: head24(context, AppColors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: (){
                Provider.of<AuthProvider>(context, listen: false).logOut().then((_){
                  replaceTo(context, const SelectRoleScreen());
                });
              },
              child: Ink(
                width: w(context),
                padding: EdgeInsets.all(w20(context)),
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    w20(context),
                    w20(context),
                    w20(context),
                    hh(context, 10),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    borderRadius: BorderRadius.circular(ww(context, 10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        offset: Offset(0, hh(context, 4)),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: head36(context, AppColors.primary),
                          children: [
                            const TextSpan(
                              text: "Log",
                            ),

                            TextSpan(
                              text: "Out",
                              style: head36(context, AppColors.white),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        "Logout".toIcon,
                        width: ww(context, 30),
                        color: AppColors.dark
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: hh(context, 100)),
          ],
        ),
      ),),
    );
  }
}
