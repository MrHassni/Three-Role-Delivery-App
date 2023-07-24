import 'package:delivery_app/core/providers/auth_providers.dart';
import 'package:delivery_app/core/providers/brand_and_product_provider.dart';
import 'package:delivery_app/views/base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/init/metrics.dart';
import '../../core/init/navigate.dart';
import '../../core/providers/users_provider.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_theme.dart';


class MyBrandsScreen extends StatefulWidget {
  const MyBrandsScreen({Key? key}) : super(key: key);

  @override
  State<MyBrandsScreen> createState() => _MyBrandsScreenState();
}

class _MyBrandsScreenState extends State<MyBrandsScreen> {

  @override
  Widget build(BuildContext context) {
    return Base(child:
    Consumer<AuthProvider>(
        builder: (context, provider, child) =>
            Column(

              children: [
                SizedBox(height: hh(context, 50)),
                horizontalpadding(
                  context,
                  child: Center(
                    child: Text(
                      "My Restaurants",
                      style: head36(context, AppColors.primary),
                    ),
                  ),
                ),
                SizedBox(height: hh(context, 20)),
                ListView.separated(
                  itemCount: provider.currentUser!.brands!.length,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: w(context),
                      child: Container(
                        margin: EdgeInsets.only(left: w20(context), right: w20(context)),
                        padding: const EdgeInsets.all(10),

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
                        child:
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(provider.currentUser!.brands![index]['img'],
                                    height: 60,
                                      width: 75,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: ww(context, 10),),
                                  Text(
                                     "${provider.currentUser!.brands![index]['name']}",
                                    style: head24(context, AppColors.primary),
                                  ),
                                ],
                              ),

                      ),
                    );
                  },
                ),
              ],
            )));
  }
}


