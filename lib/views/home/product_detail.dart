import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:delivery_app/core/core_shelf.dart';
import 'package:delivery_app/core/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../core/providers/cart_provider.dart';
import '../base.dart';


class ProductDetail extends StatefulWidget {
  final ProductModel product;
  const ProductDetail({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  late CartProvider _cartProvider;
  late CartItem? _cartItem;
  late int _isInCart;
  int quantity = 1;

  @override
  void initState() {
    _cartProvider = Provider.of<CartProvider>(context, listen: false);
    super.initState();
  }

  int _checkItemisInCart() {
    _cartItem = _cartProvider.getSpecificItemFromCartProvider(widget.product.id);
    return _cartItem?.quantity ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    _isInCart = _checkItemisInCart();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Base(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  height: 250.0,
                  viewportFraction: 1,
                  aspectRatio: 1,
                  autoPlay: true,

              ),
              items: widget.product.imageList.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.network(
                      i,
                      fit: BoxFit.cover,
                      width: w(context),
                    );
                  },
                );
              }).toList(),
            ),
             // Jumbotron(product: widget.product,),
            SizedBox(height: hh(context, 20)),
             ProductHeader(product: widget.product,),
            SizedBox(height: hh(context, 30)),
             ProductDescription(product: widget.product,),
            SizedBox(height: hh(context, 40)),
            horizontalpadding(
              context,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      horizontalpadding(
                        context,
                        child: Text(
                          "QUANTITY",
                          style: label(context, AppColors.primary),
                        ),
                      ),
                      SizedBox(height: hh(context, 5)),
                      Container(
                        width: ww(context, 140),
                        height: hh(context, 40),
                        decoration: BoxDecoration(
                          color: bgSecondary(context),
                          borderRadius: BorderRadius.circular(hh(context, 40)),
                        ),
                        child: horizontalpadding(
                          context,
                          child: Row(
                            children: [
                              Text(
                                quantity.toString(),
                                style: head18(context, textPrimary(context)),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      if(quantity != 1) {
                                        setState(() {
                                          quantity = quantity - 1;
                                        });
                                      }
                                    },
                                    child: SvgPicture.asset(
                                      "Subtract".toIcon,
                                      width: ww(context, 22),
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  SizedBox(width: w20(context)),
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        quantity = quantity + 1;
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      "Add".toIcon,
                                      width: ww(context, 22),
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "SUB TOTAL",
                        style: label(context, textPrimary(context)),
                      ),
                      SizedBox(height: hh(context, 10)),
                      Text(
                        (widget.product.price * quantity).toString(),
                        style: head24(context, AppColors.primary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            horizontalpadding(
              context,
              child: Material(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(hh(context, 40)),
                child: InkWell(
                  onTap: _isInCart != 0
                      ? (){}
                      :() {
                    _cartProvider.addToCart(widget.product, funcQuantity: quantity);
                    setState(() {});
                  },
                  borderRadius: BorderRadius.circular(hh(context, 40)),
                  child: Container(
                    width:double.infinity,
                    height: hh(context, 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(hh(context, 40)),
                      border: Border.all(
                        width: hh(context, 2),
                        color: AppColors.primary,
                      ),
                    ),
                    child: _isInCart != 0
                        ? Center(
                          child: Text(
                      "✓ ADDED TO BASKET",
                      style: head18(context, AppColors.white),
                    ),
                        )
                        : Center(
                          child: Text(
                      "ADD TO BASKET",
                      style: head18(context, AppColors.white),
                    ),
                        ),
                  ),
                ),
              ),
            ),
            SizedBox(height: hh(context, 40)),
          ],
        ),
      ),
    );
  }
}

class ProductDescription extends StatelessWidget {
  final ProductModel product;
  const ProductDescription({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return horizontalpadding(
      context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "DESCRIPTION",
            style: head18(context, textPrimary(context)),
          ),
          SizedBox(height: hh(context, 10)),
          Text(
            product.description,
            style: body(context, textSecondary),
          ),
        ],
      ),
    );
  }
}

class ProductHeader extends StatelessWidget {
  final ProductModel product;
  const ProductHeader({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return horizontalpadding(
      context,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: w(context)/ 1.5,
                child: Text(
                  product.name,
                  maxLines: 2,
                  style: head36(context, textPrimary(context)),
                ),
              ),
              Text(
                product.brandName,
                style: body(context, AppColors.secondary),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: hh(context, 5)),
              CircleAvatar(
                backgroundImage: NetworkImage(product.brandImg),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Jumbotron extends StatefulWidget {
  const Jumbotron({
    Key? key, required this.product,
  }) : super(key: key);
  final ProductModel product;
  @override
  State<Jumbotron> createState() => _JumbotronState();
}

class _JumbotronState extends State<Jumbotron> {
  PageController controller = PageController();
  int p = 0;
  List<Widget> imgs = [];

  @override
  void initState() {
    for(int i = 0; i < widget.product.imageList.length; i++){
      imgs.add(
        Image.network(
          '${widget.product.imageList[i]}',
          fit: BoxFit.cover,
        ),);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hh(context, 300),
      child: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (val) {
              setState(() {
                p = val;
              });
            },
            children: imgs,
            // [
            //   SizedBox(
            //     width: w(context),
            //     height: hh(context, 300),
            //     child: Image.asset(
            //       "im2".toImgPng,
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            //   SizedBox(
            //     width: w(context),
            //     height: hh(context, 300),
            //     child: Image.asset(
            //       "im2".toImgPng,
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            //   SizedBox(
            //     width: w(context),
            //     height: hh(context, 300),
            //     child: Image.asset(
            //       "im2".toImgPng,
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ],
          ),
          Positioned(
            top: hh(context, 50),
            left: w20(context),
            right: w20(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(hh(context, 5)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: GestureDetector(
                      onTap: () => popTo(context),
                      child: Container(
                        width: ww(context, 32),
                        height: ww(context, 32),
                        padding: EdgeInsets.all(hh(context, 2)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(hh(context, 5)),
                          color: Colors.white.withOpacity(0.2),
                        ),
                        child: SvgPicture.asset(
                          "Left".toIcon,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(hh(context, 5)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: ww(context, 32),
                      height: ww(context, 32),
                      padding: EdgeInsets.all(hh(context, 2)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(hh(context, 5)),
                        color: Colors.white.withOpacity(0.2),
                      ),
                      child: SvgPicture.asset(
                        "Options".toIcon,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          // Positioned(
          //   bottom: hh(context, 10),
          //   left: 0,
          //   right: 0,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       AnimatedContainer(
          //         duration: const Duration(milliseconds: 240),
          //         width: p == 0 ? ww(context, 20) : ww(context, 10),
          //         height: hh(context, 2),
          //         decoration: BoxDecoration(
          //           color: p == 0 ? AppColors.primary : Colors.white,
          //           borderRadius: BorderRadius.circular(hh(context, 2)),
          //         ),
          //       ),
          //       SizedBox(width: ww(context, 5)),
          //       AnimatedContainer(
          //         duration: const Duration(milliseconds: 240),
          //         width: p == 1 ? ww(context, 20) : ww(context, 10),
          //         height: hh(context, 2),
          //         decoration: BoxDecoration(
          //           color: p == 1 ? AppColors.primary : Colors.white,
          //           borderRadius: BorderRadius.circular(hh(context, 2)),
          //         ),
          //       ),
          //       SizedBox(width: ww(context, 5)),
          //       AnimatedContainer(
          //         duration: const Duration(milliseconds: 240),
          //         width: p == 2 ? ww(context, 20) : ww(context, 10),
          //         height: hh(context, 2),
          //         decoration: BoxDecoration(
          //           color: p == 2 ? AppColors.primary : Colors.white,
          //           borderRadius: BorderRadius.circular(hh(context, 2)),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
