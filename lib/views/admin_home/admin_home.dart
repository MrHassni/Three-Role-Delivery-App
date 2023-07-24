import 'package:delivery_app/core/core_shelf.dart';
import 'package:delivery_app/core/providers/auth_providers.dart';
import 'package:delivery_app/core/providers/brand_and_product_provider.dart';
import 'package:delivery_app/core/providers/order_provider.dart';
import 'package:delivery_app/core/providers/users_provider.dart';
import 'package:delivery_app/views/all_orders_history_screens/all_orders_history_screen.dart';
import 'package:delivery_app/views/all_users/all_order_takers_screen.dart';
import 'package:delivery_app/views/all_users/all_riders_screen.dart';
import 'package:delivery_app/views/all_users/all_users_screen.dart';
import 'package:delivery_app/views/brands_and_products_screens/all_products_screen.dart';
import 'package:delivery_app/views/select_role/select_role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../all_users/test.dart';
import '../base.dart';
import '../brands_and_products_screens/all_brands_screen.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  void initState() {
    Provider.of<UsersProvider>(context, listen: false).getAllUsers();
    Provider.of<OrderProvider>(context, listen: false).getAllOrders();
    Provider.of<BrandAndProductProvider>(context, listen: false)
        .getAllBrands(context: context);
    Provider.of<BrandAndProductProvider>(context, listen: false)
        .getAllProducts(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Base(
      child: SingleChildScrollView(
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
                      text: Provider.of<AuthProvider>(context, listen: false)
                          .currentUser!
                          .firstName
                          .toString(),
                      style: bigBody(context, AppColors.primary),
                    ),
                    const TextSpan(
                      text: "!",
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: hh(context, 10)),
            InkWell(
              onTap: () {
                pushTo(context, const AllUserScreen());
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
                              text: "Manage ",
                            ),
                            TextSpan(
                              text: " All Users",
                              style: head24(context, AppColors.dark),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset(
                          'assets/images/admin.png',
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
                  onTap: () {
                    pushTo(context, const AllRidersScreen());
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
                              text: "Manage\n",
                            ),
                            TextSpan(
                              text: "Riders",
                              style: head24(context, AppColors.dark),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    pushTo(context, const AllOrderTakersScreen());
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
                              text: "Manage\n",
                            ),
                            TextSpan(
                              text: "Order Takers",
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
                  onTap: () {
                    pushTo(context, const AllBrandsScreen());
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
                              text: "Brand\n",
                            ),
                            TextSpan(
                              text: "Management",
                              style: head24(context, AppColors.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    pushTo(context, const AllProductsScreen());
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
                              text: "Product\n",
                            ),
                            TextSpan(
                              text: "Management",
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
                    pushTo(context, const AllOrdersHistoryScreen());
                  },
                  child: SizedBox(
                    width: (w(context) ),
                    child: Container(
                      margin: EdgeInsets.only(left: w20(context), right: w20(context)),
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
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            style: head36(context, AppColors.dark),
                            children: [
                              const TextSpan(
                                text: "Order ",
                              ),
                              TextSpan(
                                text: " Insight",
                                style: head24(context, AppColors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   width: (w(context) / 2),
                //   child: Container(
                //     margin: EdgeInsets.only(right: w20(context), left: 10),
                //     padding: EdgeInsets.fromLTRB(
                //       w20(context),
                //       w20(context),
                //       w20(context),
                //       hh(context, 10),
                //     ),
                //     decoration: BoxDecoration(
                //       color: Colors.black,
                //       borderRadius: BorderRadius.circular(ww(context, 10)),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.white.withOpacity(0.15),
                //           offset: Offset(0, hh(context, 4)),
                //           blurRadius: 20,
                //         ),
                //       ],
                //     ),
                //     child: RichText(
                //       text: TextSpan(
                //         style: head36(context, AppColors.primary),
                //         children: [
                //           const TextSpan(
                //             text: "My\n",
                //           ),
                //           TextSpan(
                //             text: "Restaurants",
                //             style: head24(context, AppColors.white),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            InkWell(
              onTap: () {
                Provider.of<AuthProvider>(context, listen: false)
                    .logOut()
                    .then((_) {
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
                      SvgPicture.asset("Logout".toIcon,
                          width: ww(context, 30), color: AppColors.dark)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: hh(context, 100)),
          ],
        ),
      ),
    );
  }
}
