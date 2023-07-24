import 'package:delivery_app/core/core_shelf.dart';
import 'package:delivery_app/views/brands_and_products_screens/all_products_by_brand_screen.dart';
import 'package:delivery_app/views/home/brand_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/brand_and_product_provider.dart';

class Brands extends StatelessWidget {
  const Brands({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BrandAndProductProvider>(
        builder: (context, provider, child) => SizedBox(
              width: w(context),
              height: hh(context, 120),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: w20(context),
                vertical: hh(context, 20)),
                itemCount: provider.allBrands.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      provider.getAllProductsByBrand(context: context, brandId: provider.allBrands[index].id);
                      pushTo(
                          context,
                          BrandProductsScreen(
                              brand: provider.allBrands[index].name,
                              ));
                    },
                    child: Container(
                      width: ww(context, 60),
                      height: ww(context, 80),
                      margin: EdgeInsets.only(right: ww(context, 15)),
                      decoration: BoxDecoration(
                        color: bgPrimary(context),
                        borderRadius: BorderRadius.circular(ww(context, 20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, hh(context, 2)),
                            blurRadius: 30,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(provider.allBrands[index].img,),
                            backgroundColor: AppColors.white,
                            radius: hh(context, 30),
                          ),
                          Text(
                            provider.allBrands[index].name,
                            style: label(context, AppColors.primaryLight),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ));
  }
}
