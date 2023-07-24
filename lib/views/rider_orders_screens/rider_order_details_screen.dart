import 'package:delivery_app/core/core_shelf.dart';
import 'package:delivery_app/core/models/order_model.dart';
import 'package:delivery_app/views/base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/user_model.dart';
import '../../core/providers/auth_providers.dart';
import '../../core/providers/order_provider.dart';

class RiderOrderDetailsScreen extends StatefulWidget {
  final OrderModel order;

  const RiderOrderDetailsScreen({Key? key, required this.order})
      : super(key: key);

  @override
  State<RiderOrderDetailsScreen> createState() =>
      _RiderOrderDetailsScreenState();
}

class _RiderOrderDetailsScreenState extends State<RiderOrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Base(
        child: horizontalpadding(
      context,
      child: Consumer<OrderProvider>(
        builder: (context, provider, child) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: hh(context, 50),
              ),
              horizontalpadding(
                context,
                child: Center(
                  child: Text(
                    "ORDER DETAILS",
                    style: head36(context, AppColors.primary),
                  ),
                ),
              ),
              SizedBox(
                height: hh(context, 30),
              ),
              ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.order.orderDetails.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: w(context),
                    child: Container(
                      padding: EdgeInsets.all(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  widget.order.orderDetails[index].url,
                                  height: 60,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: ww(context, 15),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: head18(context, AppColors.primary),
                                  children: [
                                    TextSpan(
                                      text:
                                          "${widget.order.orderDetails[index].productName}   ",
                                    ),
                                    TextSpan(
                                      text:
                                          '(${widget.order.orderDetails[index].quantity})\n',
                                      style: titleMedium14(
                                          context, AppColors.dark),
                                    ),
                                    TextSpan(
                                      text:
                                          "\$ ${widget.order.orderDetails[index].subtotal}\n",
                                      style: titleMedium14(
                                          context, AppColors.dark),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: ww(context, 15),
                              ),
                            ],
                          ),
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                widget.order.orderDetails[index].brandImg),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: hh(context, 30),
              ),
              Text(
                "DELIVERED TO:",
                style: head24(context, textPrimary(context)),
              ),
              Text(
                "\n${widget.order.fullName.toUpperCase()}\nDepartment: ${widget.order.department}\nDesignation: ${widget.order.designation}\nAddress: ${widget.order.address}\nOther: ${widget.order.specific}\nPhone No# ${widget.order.phone}\n\nNote: (${widget.order.note})",
                style: body(context, textPrimary(context)),
              ),
              Text(
                "\nTOTAL AMOUNT:  \$ ${widget.order.total}",
                style: head24(context, AppColors.primary),
              ),
              SizedBox(
                height: hh(context, 30),
              ),
              widget.order.status == 1
                  ? SolidBorderedButton(
                      text: "MARK AS DELIVERED",
                      bgColor: bgPrimary(context),
                      borderColor: AppColors.primary,
                      textColor: AppColors.primary,
                      onTap: () {
                        List brands = [];
                        UserModel user =
                            Provider.of<AuthProvider>(context, listen: false)
                                .currentUser!;
                        if (user.brands != null && user.brands!.isNotEmpty) {
                          for (int i = 0; i < user.brands!.length; i++) {
                            brands.add(user.brands![i]['id']);
                          }
                          provider.upDateOrderStatus(
                              widget.order.id, 2, brands);
                          Navigator.pop(context);
                        }
                      })
                  : const SizedBox()
            ],
          ),
        ),
      ),
    ));
  }
}
