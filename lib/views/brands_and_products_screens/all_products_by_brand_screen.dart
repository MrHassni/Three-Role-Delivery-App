import 'package:delivery_app/core/providers/brand_and_product_provider.dart';
import 'package:delivery_app/views/base.dart';
import 'package:delivery_app/views/brands_and_products_screens/add_new_products_screen.dart';
import 'package:delivery_app/views/widgets/product_grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/init/metrics.dart';
import '../../core/init/navigate.dart';
import '../../core/providers/users_provider.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_theme.dart';
import 'add_new_brand_screen.dart';

class AllProductsByBrandScreen extends StatelessWidget {
  final String brandId, brandName, brandImg;

  const AllProductsByBrandScreen(
      {Key? key,
      required this.brandId,
      required this.brandName,
      required this.brandImg})
      : super(key: key);

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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Products",
                              style: head36(context, AppColors.primary),
                            ),
                            InkWell(
                                onTap: () {
                                  pushTo(
                                      context,
                                      AddNewProductsScreen(
                                        brandId: brandId,
                                        brandName: brandName,
                                        brandImg: brandImg,
                                      ));
                                },
                                child: const Icon(
                                  Icons.mode_edit_outline_outlined,
                                  color: AppColors.primary,
                                ))
                          ],
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
                              return ProductGridWidget(product: provider.allProductsByBrand[index]);
                            }),
                      ),
                      SizedBox(height: hh(context, 40)),
                    ],
                  ),
            )));
  }
}
