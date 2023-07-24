import 'package:delivery_app/core/core_shelf.dart';
import 'package:delivery_app/core/models/product_model.dart';
import 'package:delivery_app/core/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../home/product_detail.dart';

class Liked extends StatelessWidget {
  const Liked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) =>
          SingleChildScrollView(
      child: horizontalpadding(
        context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: hh(context, 50)),
            Text(
              "LIKED",
              style: head36(context, textPrimary(context)),
            ),
            ListView.separated(
              itemCount: provider.favProducts.length,
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) => SizedBox(height: hh(context, 30)),
              itemBuilder: (BuildContext context, int index) {
                return LikedItem(
                  img: provider.favProducts[index].imageList.first,
                  name: provider.favProducts[index].name,
                  price: provider.favProducts[index].price.toString(),
                  product: provider.favProducts[index],
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}

class LikedItem extends StatefulWidget {
  final String img;
  final String name;
  final String price;
  final ProductModel product;
  const LikedItem({
    Key? key,
    required this.img,
    required this.name,
    required this.price, required this.product,
  }) : super(key: key);

  @override
  State<LikedItem> createState() => _LikedItemState();
}

class _LikedItemState extends State<LikedItem> {
  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: (){
            pushTo(
                context,
                ProductDetail(
                  product: widget.product,
                ));
          },
          child: Row(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.name,
                      style: head18(context, textPrimary(context)),
                    ),
                    SizedBox(
                      width: ww(context, 160),
                      child: Text(
                        widget.product.description,
                        maxLines: 2,
                        style: body(context, textPrimary(context)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: (){
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    backgroundColor: AppColors.dark,
                    title: Text(
                      'UNLIKE "${widget.name}"',
                      style: head36(context, textPrimary(context)),
                    ),
                    content: Text('Are sure you want to remove "${widget.name}" from your liked list?',
                        style: head18(context, textPrimary(context))),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: Text('Cancel',
                            style: head24(context, AppColors.primary)),
                      ),
                      TextButton(
                        onPressed: () {
                          Provider.of<AuthProvider>(context, listen: false).removeFav(removeFav: widget.product);
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
            SizedBox(height: hh(context, 30)),
            Text(
              "\$ ${widget.price}",
              style: head24(context, AppColors.primary),
            ),
          ],
        ),
      ],
    );
  }
}
