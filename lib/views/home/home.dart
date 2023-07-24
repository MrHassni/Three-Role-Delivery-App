import 'dart:developer';

import 'package:delivery_app/core/core_shelf.dart';
import 'package:delivery_app/core/shared_prefs/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../core/providers/auth_providers.dart';
import '../../core/providers/brand_and_product_provider.dart';
import '../widgets/brands.dart';
import 'package:delivery_app/core/models/catalog_model.dart';
import '../widgets/campaign.dart';
import '../widgets/recommended.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Consumer<BrandAndProductProvider>(
          builder: (context, provider, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: hh(context, 50)),
                  horizontalpadding(
                    context,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: bigBody(context, textPrimary(context)),
                            children: [
                              const TextSpan(
                                text: "Hello, ",
                              ),
                              TextSpan(
                                text: Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .currentUser!
                                    .firstName
                                    .toString(),
                                style: bigBody(context, AppColors.primary),
                              ),
                              const TextSpan(
                                text: "!",
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "OFFICE",
                              style: bigBody(context, AppColors.secondary),
                            ),
                            SizedBox(width: ww(context, 5)),
                            SvgPicture.asset(
                              "Location".toIcon,
                              width: ww(context, 22),
                              color: AppColors.secondary,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: hh(context, 10)),
                  const Campaign(),
                  SizedBox(height: hh(context, 20)),
                  horizontalpadding(
                    context,
                    child: Text(
                      "RECOMMENDED FOR YOU",
                      style: label(context, textPrimary(context)),
                    ),
                  ),
                  SizedBox(height: hh(context, 20)),
                  SizedBox(
                      height: hh(context, 230),
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: w20(context)),
                        itemCount: provider.allProducts.length > 7 ? 7 : provider.allProducts.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          width: 10,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return RecommendedItem(
                            img: provider.allProducts[index].imageList.first,
                            name: provider.allProducts[index].name,
                            price: provider.allProducts[index].price,
                            product: provider.allProducts[index],
                          );
                        },
                      ),
                    ),

                  SizedBox(height: hh(context, 30)),
                  horizontalpadding(
                    context,
                    child: Text(
                      "RESTAURANTS",
                      style: label(context, textPrimary(context)),
                    ),
                  ),
                  const Brands(),
                  horizontalpadding(
                    context,
                    child: Text(
                      "POPULAR IN YOUR AREA",
                      style: label(context, textPrimary(context)),
                    ),
                  ),
                  SizedBox(height: hh(context, 20)),
                  provider.allProducts.length > 14 ? SizedBox(
                      height: hh(context, 230),
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(
                          horizontal: w20(context)
                        ),
                        itemCount: 7,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          width: 10,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return RecommendedItem(
                            img: provider.allProducts[index + 7].imageList.first,
                            name: provider.allProducts[index + 7].name,
                            price: provider.allProducts[index + 7].price,
                            product: provider.allProducts[index + 7],
                          );
                        },
                      ),
                    ) : const SizedBox(),
                  SizedBox(height: hh(context, 100)),
                ],
              )),
    );
  }
}
