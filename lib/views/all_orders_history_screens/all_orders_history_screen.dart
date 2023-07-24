import 'package:delivery_app/core/core_shelf.dart';
import 'package:delivery_app/core/providers/order_provider.dart';
import 'package:delivery_app/views/all_orders_history_screens/order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../base.dart';

class AllOrdersHistoryScreen extends StatelessWidget {
  const AllOrdersHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Base(
      child: Consumer<OrderProvider>(
        builder: (context, provider, child) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: hh(context, 50)),
              horizontalpadding(
                context,
                child: Center(
                  child: Text(
                    "ALL ORDER HISTORY",
                    style: head36(context, AppColors.primary),
                  ),
                ),
              ),
              SizedBox(height: hh(context, 50)),
              ListView.separated(
                itemCount: provider.allOrders.length,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) =>
                     SizedBox(height: hh(context, 15),),
                itemBuilder: (BuildContext context, int index) {
                  return horizontalpadding(
                    context,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (){
                              final DateTime date1 = DateTime.fromMicrosecondsSinceEpoch(provider.allOrders[index].orderDetails.first.time * 1000);
                             var t = DateFormat.yMMMMd('en_US');
                              return Text(
                                 t.format(date1).toString(),
                                style: label(context, AppColors.secondary),
                              );
                            }(),
                            Text(
                              '\$ ${provider.allOrders[index].total}',
                              style: label(context, AppColors.secondary),
                            ),
                          ],
                        ),
                        SizedBox(height: w20(context)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              provider.allOrders[index].fullName,
                              style: body(context, AppColors.white),
                            ),
                            Text(
                              "${provider.allOrders[index].orderDetails.length} items",
                              style: body(context, textSecondary),
                            ),
                          ],
                        ),
                        SizedBox(height: w20(context)),
                        SolidBorderedButton(
                          text: "VIEW DETAILS",
                          bgColor: bgPrimary(context),
                          borderColor: AppColors.primary,
                          textColor: AppColors.primary,
                          onTap: (){
                            pushTo(context,  OrderDetailsScreen(order: provider.allOrders[index],));
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: hh(context, 50)),
            ],
          ),
        ),
      ),
    );
  }
}
