import 'dart:ui';

import 'package:delivery_app/core/core_shelf.dart';
import 'package:delivery_app/core/providers/brand_and_product_provider.dart';
import 'package:delivery_app/views/base.dart';
import 'package:delivery_app/views/home/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../core/providers/auth_providers.dart';
import '../../core/providers/cart_provider.dart';


class BrandProductsScreen extends StatefulWidget {
  final String brand;

  const BrandProductsScreen(
      {Key? key,required this.brand})
      : super(key: key);

  @override
  State<BrandProductsScreen> createState() => _BrandProductsScreenState();
}

class _BrandProductsScreenState extends State<BrandProductsScreen> {

  late CartProvider _cartProvider;
  late CartItem? _cartItem;
  int? _isInCart;
  int quantity = 1;

  @override
  void initState() {
    _cartProvider = Provider.of<CartProvider>(context, listen: false);
    super.initState();
  }

  int _checkItemisInCart(id) {
    _cartItem =
        _cartProvider.getSpecificItemFromCartProvider(id);
    return _cartItem?.quantity ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Base(
        child: Consumer<BrandAndProductProvider>(
            builder: (context, provider, child) => SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: hh(context, 50)),
                  horizontalpadding(
                    context,
                    child: Center(
                      child: Text(
                        widget.brand,
                        style: head36(context, AppColors.primary),
                      ),
                    ),
                  ),
                  SizedBox(height: hh(context, 20)),
                  horizontalpadding(
                    context,
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1/1.35),
                        shrinkWrap: true,
                        itemCount: provider.allProductsByBrand.length,
                        itemBuilder: (BuildContext ctx, index) {
                          _isInCart = _checkItemisInCart(provider.allProductsByBrand[index].id);
                          return InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () => pushTo(
                                context,
                                ProductDetail(
                                  product: provider.allProductsByBrand[index],
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
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                          ),
                                          image: DecorationImage(
                                              image: NetworkImage(provider.allProductsByBrand[index].imageList.first),
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
                                              provider.allProductsByBrand[index].name,
                                              style: body(context, textPrimary(context)),
                                            ),
                                            Text(
                                              "\$ ${provider.allProductsByBrand[index].price}",
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
                                          Provider.of<AuthProvider>(context, listen: false).fav(fav: provider.allProductsByBrand[index]);
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
                                                  child: Provider.of<AuthProvider>(context, listen: false).favProducts.contains(provider.allProductsByBrand[index])
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
                                          _cartProvider.addToCart(provider.allProductsByBrand[index],
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
                        }),
                  ),
                  SizedBox(height: hh(context, 40)),
                ],
              ),
            )));
  }
}
