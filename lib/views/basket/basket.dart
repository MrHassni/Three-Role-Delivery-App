import 'package:delivery_app/core/core_shelf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../core/providers/cart_provider.dart';
import 'additional_info.dart';

class Basket extends StatefulWidget {
  const Basket({Key? key}) : super(key: key);

  @override
  State<Basket> createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  @override
  Widget build(BuildContext context) {
    var cartProvider = context.watch<CartProvider>();
    return horizontalpadding(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: hh(context, 50)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "BASKET",
                style: head36(context, textPrimary(context)),
              ),
              InkWell(
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      backgroundColor: AppColors.dark,
                      title: Text(
                        'EMPTY BASKET',
                        style: head36(context, textPrimary(context)),
                      ),
                      content: Text('Are sure you want to empty the cart?',
                          style: head18(context, textPrimary(context))),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: Text('Cancel',
                              style: head24(context, AppColors.primary)),
                        ),
                        TextButton(
                          onPressed: () {
                            Provider.of<CartProvider>(context, listen: false)
                                .deleteAllCartProvider();
                            Navigator.pop(context);
                            setState(() {});
                          },
                          child: Text('OK',
                              style: head24(
                                context,
                                AppColors.error,
                              )),
                        ),
                      ],
                    ),
                  );
                },
                child: Ink(
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    borderRadius: BorderRadius.circular(ww(context, 5)),
                  ),
                  child: Container(
                    width: ww(context, 25),
                    height: ww(context, 25),
                    padding: EdgeInsets.all(ww(context, 2)),
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.circular(ww(context, 5)),
                    ),
                    child: SvgPicture.asset(
                      "Trash".toIcon,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: hh(context, 30)),
          ListView.separated(
            itemCount: cartProvider.flutterCart.cartItem.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: hh(context, 47)),
            itemBuilder: (BuildContext context, int index) {
              return BasketItem(
                img: cartProvider
                    .flutterCart.cartItem[index].productDetails.imageList.first
                    .toString(),
                name: cartProvider.flutterCart.cartItem[index].productName
                    .toString(),
                price: cartProvider.flutterCart.cartItem[index].unitPrice
                    .toString(),
                piece: cartProvider.flutterCart.cartItem[index].quantity
                    .toString(),
                index: index,
              );
            },
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "TOTAL",
                style: head18(context, textPrimary(context)),
              ),
              Text(
                "\$ ${cartProvider.getTotalAmount()}",
                style: head36(context, AppColors.secondary),
              ),
            ],
          ),
          SizedBox(height: hh(context, 30)),
          SolidBorderedButton(
            onTap: () {
              if(cartProvider.getTotalAmount() <= 0) {
              }else{
                pushTo(context,  AdditionalInfo(products: cartProvider.flutterCart.cartItem, price: cartProvider.getTotalAmount(),));
              }},
            text: "PROCEED TO CHECKOUT",
            bgColor: AppColors.primary,
            borderColor: AppColors.primary,
            textColor: AppColors.white,
          ),
          SizedBox(height: hh(context, 100)),
        ],
      ),
    );
  }
}

class BasketItem extends StatefulWidget {
  final String img;
  final String name;
  final String price;
  final String piece;
  final int index;

  const BasketItem(
      {Key? key,
      required this.img,
      required this.name,
      required this.price,
      required this.piece,
      required this.index})
      : super(key: key);

  @override
  State<BasketItem> createState() => _BasketItemState();
}

class _BasketItemState extends State<BasketItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: ww(context, 80),
              height: ww(context, 80),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ww(context, 10)),
                image: DecorationImage(
                  image: NetworkImage(widget.img),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: w20(context)),
            SizedBox(
              height: hh(context, 80),
              width: ww(context, 230),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.name,
                        style: body(context, textPrimary(context)),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              backgroundColor: AppColors.dark,
                              title: Text(
                                'REMOVE "${widget.name.toUpperCase()}"',
                                style: head36(context, textPrimary(context)),
                              ),
                              content: Text(
                                  'Are sure you want to drop "${widget.name}"?',
                                  style: head18(context, textPrimary(context))),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: Text('Cancel',
                                      style:
                                          head24(context, AppColors.primary)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Provider.of<CartProvider>(context,
                                            listen: false)
                                        .deleteItemFromCart(widget.index);
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  child: Text('OK',
                                      style: head24(
                                        context,
                                        AppColors.error,
                                      )),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            color: AppColors.error,
                            borderRadius: BorderRadius.circular(ww(context, 5)),
                          ),
                          child: Container(
                            width: ww(context, 22),
                            height: ww(context, 22),
                            padding: EdgeInsets.all(ww(context, 2)),
                            decoration: BoxDecoration(
                              color: AppColors.error,
                              borderRadius:
                                  BorderRadius.circular(ww(context, 5)),
                            ),
                            child: SvgPicture.asset(
                              "Trash".toIcon,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$ ${double.parse(widget.price) * int.parse(widget.piece)}",
                        style: head24(context, AppColors.primary),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: ww(context, 120),
                        height: hh(context, 35),
                        decoration: BoxDecoration(
                          color: bgSecondary(context),
                          borderRadius: BorderRadius.circular(hh(context, 40)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .decrementItemFromCartProvider(
                                        widget.index);
                              },
                              child: SvgPicture.asset(
                                "Subtract".toIcon,
                                width: ww(context, 22),
                                color: AppColors.primary,
                              ),
                            ),
                            Text(
                              widget.piece.toString(),
                              style: head18(context, textPrimary(context)),
                            ),
                            InkWell(
                              onTap: () {
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .incrementItemToCartProvider(widget.index);
                              },
                              child: SvgPicture.asset(
                                "Add".toIcon,
                                width: ww(context, 22),
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
