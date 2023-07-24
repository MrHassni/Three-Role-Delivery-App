import 'package:delivery_app/core/core_shelf.dart';
import 'package:delivery_app/core/models/product_model.dart';
import 'package:flutter/material.dart';

import '../home/product_detail.dart';

class ProductGridWidget extends StatefulWidget {
  final ProductModel product;
  const ProductGridWidget({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductGridWidget> createState() => _ProductGridWidgetState();
}

class _ProductGridWidgetState extends State<ProductGridWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        pushTo(context, ProductDetail(product: widget.product,));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius:
          BorderRadius.circular(ww(context, 10)),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(
                    ww(context, 10),
                  ),
                  topLeft: Radius.circular(
                    ww(context, 10),
                  ),
                ),
                child: Image.network(
                  widget.product.imageList.first,
                  fit: BoxFit.cover,
                  height: hh(context, 110),
                  width: w(context)/2,
                )),
            SizedBox(
              width: ww(context, 20),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RichText(
                maxLines: 3,
                overflow : TextOverflow.ellipsis,
                text: TextSpan(
                  style: head24(
                      context, AppColors.primary),
                  children: [
                    TextSpan(
                      text: widget.product.name,
                    ),
                    TextSpan(
                      text: '\n',
                      style: body(
                          context, AppColors.primary),
                    ),
                    TextSpan(
                      text: widget.product.description,
                      style: body(
                          context, AppColors.dark),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('\$ ${widget.product.price}',style: head18(
                    context, AppColors.primary)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
