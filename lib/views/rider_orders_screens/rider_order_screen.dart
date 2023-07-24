import 'package:delivery_app/core/core_shelf.dart';
import 'package:delivery_app/core/models/order_model.dart';
import 'package:delivery_app/core/providers/order_provider.dart';
import 'package:delivery_app/views/all_orders_history_screens/order_details_screen.dart';
import 'package:delivery_app/views/rider_orders_screens/rider_order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/models/user_model.dart';
import '../../core/providers/auth_providers.dart';
import '../base.dart';

class RiderOrdersScreen extends StatefulWidget {
  final String title;
  final List<OrderModel> list;

  const RiderOrdersScreen({Key? key, required this.title, required this.list})
      : super(key: key);

  @override
  State<RiderOrdersScreen> createState() => _RiderOrdersScreenState();
}

class _RiderOrdersScreenState extends State<RiderOrdersScreen> {
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
                    widget.title,
                    style: head36(context, AppColors.primary),
                  ),
                ),
              ),
              SizedBox(height: hh(context, 50)),
              ListView.separated(
                itemCount: widget.list.length,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: hh(context, 15),
                ),
                itemBuilder: (BuildContext context, int index) {
                  return horizontalpadding(
                    context,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.15),
                            offset: Offset(0, hh(context, 4)),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  () {
                                    final DateTime date1 =
                                        DateTime.fromMicrosecondsSinceEpoch(
                                            widget.list[index].orderDetails
                                                    .first.time *
                                                1000);
                                    var d = DateFormat.yMMMMd('en_US');
                                    var t = DateFormat.Hm('en_US');
                                    return Text(
                                      '${t.format(date1)}\n${d.format(date1)}',
                                      style:
                                          label(context, AppColors.secondary),
                                    );
                                  }(),
                                  Text(
                                    '\$ ${widget.list[index].total}',
                                    style: head18(context, AppColors.secondary),
                                  ),
                                ],
                              ),
                              SizedBox(height: w20(context)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.list[index].fullName,
                                    style: body(context, AppColors.white),
                                  ),
                                  Text(
                                    "${widget.list[index].orderDetails.length} items",
                                    style: body(context, textSecondary),
                                  ),
                                ],
                              ),
                              SizedBox(height: w20(context)),
                              SizedBox(
                                height: 95,
                                child: ListView.separated(
                                  itemCount:
                                      widget.list[index].orderDetails.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder:
                                      (BuildContext context, int ind) =>
                                          const SizedBox(
                                    width: 10,
                                  ),
                                  itemBuilder: (BuildContext context, int ind) {
                                    return Container(
                                      decoration: const BoxDecoration(
                                        color: AppColors.primaryLight,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topRight: Radius.circular(15),
                                            ),
                                            child: Image.network(
                                              widget.list[index]
                                                  .orderDetails[ind].brandImg,
                                              width: 90,
                                              height: 65,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              widget.list[index]
                                                  .orderDetails[ind].brandName,
                                              style: label(
                                                  context, AppColors.dark),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: w20(context)),
                              widget.list[index].status != 0
                                  ? SolidBorderedButton(
                                      text: "VIEW DETAILS",
                                      bgColor: bgPrimary(context),
                                      borderColor: AppColors.primary,
                                      textColor: AppColors.primary,
                                      onTap: () {
                                        pushTo(
                                            context,
                                            RiderOrderDetailsScreen(
                                              order: widget.list[index],
                                            ));
                                      },
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SolidBorderedButton(
                                            text: "CANCEL",
                                            width: w(context) / 2.5,
                                            bgColor: bgPrimary(context),
                                            borderColor: AppColors.error,
                                            textColor: AppColors.error,
                                            onTap: () {
                                              List brands = [];
                                              UserModel user =
                                                  Provider.of<AuthProvider>(
                                                          context,
                                                          listen: false)
                                                      .currentUser!;
                                              if (user.brands != null &&
                                                  user.brands!.isNotEmpty) {
                                                for (int i = 0;
                                                    i < user.brands!.length;
                                                    i++) {
                                                  brands.add(
                                                      user.brands![i]['id']);
                                                }
                                                provider.upDateOrderStatus(
                                                    widget.list[index].id,
                                                    3,
                                                    brands);
                                              }
                                            }),
                                        SolidBorderedButton(
                                            text: "ACCEPT",
                                            width: w(context) / 2.5,
                                            bgColor: AppColors.primary,
                                            borderColor: AppColors.primary,
                                            textColor: AppColors.dark,
                                            onTap: () {
                                              List brands = [];
                                              UserModel user =
                                                  Provider.of<AuthProvider>(
                                                          context,
                                                          listen: false)
                                                      .currentUser!;
                                              if (user.brands != null &&
                                                  user.brands!.isNotEmpty) {
                                                for (int i = 0;
                                                    i < user.brands!.length;
                                                    i++) {
                                                  brands.add(
                                                      user.brands![i]['id']);
                                                }
                                                provider.upDateOrderStatus(
                                                    widget.list[index].id,
                                                    1,
                                                    brands);
                                              }
                                            }),
                                      ],
                                    ),
                            ],
                          ),
                          widget.list[index].status == 3 ||
                                  widget.list[index].status == 4
                              ? Container(
                                  margin: EdgeInsets.only(top: hh(context, 70)),
                                  child: RotationTransition(
                                    turns:
                                        const AlwaysStoppedAnimation(330 / 360),
                                    child: Container(
                                      width: w(context),
                                      height: hh(context, 90),
                                      decoration: BoxDecoration(
                                          color:
                                              AppColors.light.withOpacity(0.3)),
                                      child: Center(
                                          child: Text(
                                        widget.list[index].status == 3
                                            ? 'CANCELLED'
                                            : 'DECLINED',
                                        style: head36(context, AppColors.error),
                                      )),
                                    ),
                                  ),
                                )
                              : const SizedBox()
                        ],
                      ),
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
