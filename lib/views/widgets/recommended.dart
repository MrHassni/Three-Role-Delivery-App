import 'dart:ui';

import 'package:delivery_app/core/core_shelf.dart';
import 'package:delivery_app/core/models/product_model.dart';
import 'package:delivery_app/core/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../core/providers/cart_provider.dart';
import '../home/product_detail.dart';

class RecommendedItem extends StatefulWidget {
  const RecommendedItem({
    Key? key,
    required this.img,
    required this.name,
    required this.price,
    required this.product,
  }) : super(key: key);
  final String img;
  final String name;
  final double price;
  final ProductModel product;

  @override
  State<RecommendedItem> createState() => _RecommendedItemState();
}

class _RecommendedItemState extends State<RecommendedItem> {
  late CartProvider _cartProvider;
  late CartItem? _cartItem;
  int? _isInCart;
  int quantity = 1;

  @override
  void initState() {
    _cartProvider = Provider.of<CartProvider>(context, listen: false);
    super.initState();
  }

  int _checkItemisInCart() {
    _cartItem =
        _cartProvider.getSpecificItemFromCartProvider(widget.product.id);
    return _cartItem?.quantity ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    _isInCart = _checkItemisInCart();
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => pushTo(
          context,
          ProductDetail(
            product: widget.product,
          )),
      child: Stack(
        children: [
          Container(
            width: ww(context, 155),
            height: hh(context, 230),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.white.withOpacity(0.15),
              //     offset: const Offset(0, 0),
              //     blurRadius: 3,
              //   ),
              // ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: ww(context, 155),
                  height: ww(context, 135),
                  padding: EdgeInsets.only(
                      bottom: hh(context, 10), right: hh(context, 10)),
                  alignment: Alignment.bottomRight,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                    ),
                    image: DecorationImage(
                        image: NetworkImage(widget.img),
                        fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(hh(context, 10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.name,
                        style: body(context, textPrimary(context)),
                      ),
                      Text(
                        "\$ ${widget.price}",
                        style: head18(context, AppColors.primary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: hh(context, 230),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: (){
                    Provider.of<AuthProvider>(context, listen: false).fav(fav: widget.product);
                    setState(() {});
                  },
                  child: Ink(
                    padding: EdgeInsets.symmetric(
                        horizontal: hh(context, 10), vertical: hh(context, 5)),
                    width: ww(context, 157),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(hh(context, 5)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            width: ww(context, 25),
                            height: ww(context, 25),
                            padding: EdgeInsets.all(hh(context, 2)),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(hh(context, 5)),
                              color: Colors.white.withOpacity(0.2),
                            ),
                            child: Provider.of<AuthProvider>(context, listen: false).favProducts.contains(widget.product)
                                ? const Icon(Icons.favorite,color: AppColors.primary,)
                                : SvgPicture.asset(
                              "Heart".toIcon,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _isInCart != 0
                      ? () {}
                      : () {
                          _cartProvider.addToCart(widget.product,
                              funcQuantity: quantity);
                          setState(() {});
                        },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: hh(context, 10), vertical: hh(context, 5)),
                    child: Container(
                        width: ww(context, 25),
                        height: ww(context, 25),
                        padding: EdgeInsets.all(hh(context, 2)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(hh(context, 5)),
                          color: AppColors.primary,
                        ),
                        child: _isInCart != 0
                            ? const Center(
                                child: Icon(
                                Icons.done,
                                color: AppColors.white,
                                size: 20,
                              ))
                            : SvgPicture.asset(
                                "Basket".toIcon,
                                color: Colors.white,
                              )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
