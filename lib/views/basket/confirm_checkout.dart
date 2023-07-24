import 'package:delivery_app/core/core_shelf.dart';
import 'package:delivery_app/core/providers/cart_provider.dart';
import 'package:delivery_app/core/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../base.dart';

class ConfirmCheckout extends StatelessWidget {
  final double price;
  final List<CartItem> products;
  final String name, department, designation, address, specifics, phone, note;

  const ConfirmCheckout(
      {Key? key,
      required this.price,
      required this.products,
      required this.name,
      required this.department,
      required this.designation,
      required this.address,
      required this.specifics,
      required this.phone,
      required this.note})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Base(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: hh(context, 50)),
          Padding(
            padding: EdgeInsets.only(left: ww(context, 10)),
            child: Material(
              borderRadius: BorderRadius.circular(hh(context, 50)),
              color: Colors.transparent,
              child: InkWell(
                onTap: () => popTo(context),
                borderRadius: BorderRadius.circular(hh(context, 50)),
                child: Container(
                  padding: EdgeInsets.all(ww(context, 10)),
                  child: SvgPicture.asset(
                    "Left".toIcon,
                    width: ww(context, 22),
                    color: textPrimary(context),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: hh(context, 50)),
          horizontalpadding(
            context,
            child: Text(
              "CHECKOUT",
              style: head36(context, textPrimary(context)),
            ),
          ),
          const Spacer(),
          horizontalpadding(
            context,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PRICE",
                  style: label(context, textPrimary(context)),
                ),
                Text(
                  "\$ ${price.toString()}",
                  style: head36(context, AppColors.primary),
                ),
              ],
            ),
          ),
          SizedBox(height: hh(context, 50)),
          horizontalpadding(
            context,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "DELIVER TO:",
                      style: head24(context, textPrimary(context)),
                    ),
                    Text(
                      "\n${name.toUpperCase()}\nDepartment: $department\nDesignation: $designation\nAddress: $address\nOther: $specifics\nPhone No# $phone\n\nNote: ($note)",
                      style: body(context, textPrimary(context)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: hh(context, 50)),
          horizontalpadding(
            context,
            child: SolidBorderedButton(
              onTap: () {
                Provider.of<OrderProvider>(context, listen: false).createOrder(
                    fullName: name,
                    department: department,
                    designation: designation,
                    address: address,
                    specifics: specifics,
                    phone: phone,
                    products: products,
                    note: note,
                    total: price,
                    context: context).then((_){
                      Provider.of<CartProvider>(context, listen: false).deleteAllCartProvider();
                });
              },
              text: "CONFIRM ORDER",
              bgColor: AppColors.primary,
              borderColor: AppColors.primary,
              textColor: AppColors.white,
            ),
          ),
          SizedBox(height: hh(context, 50)),
        ],
      ),
    );
  }
}
