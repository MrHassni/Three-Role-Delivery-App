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

class AllProductsScreen extends StatelessWidget {

  const AllProductsScreen(
      {Key? key,})
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
                    child: Center(
                      child: Text(
                        "All Products",
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
                        itemCount: provider.allProducts.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return ProductGridWidget(product: provider.allProducts[index]);
                        }),
                  ),
                  SizedBox(height: hh(context, 40)),
                ],
              ),
            )));
  }
}
