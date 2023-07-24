import 'package:delivery_app/core/providers/brand_and_product_provider.dart';
import 'package:delivery_app/views/base.dart';
import 'package:delivery_app/views/brands_and_products_screens/all_products_by_brand_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/init/metrics.dart';
import '../../core/init/navigate.dart';
import '../../core/providers/users_provider.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_theme.dart';
import 'add_new_brand_screen.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Base(child:
    Consumer<BrandAndProductProvider>(
        builder: (context, provider, child) =>
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: hh(context, 50)),
                  horizontalpadding(
                    context,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "All Brands",
                          style: head36(context, AppColors.primary),
                        ),
                        InkWell(
                            onTap: (){
                              pushTo(context,  const AddNewBrandsScreen());
                            },
                            child: const Icon(Icons.mode_edit_outline_outlined, color: AppColors.primary,))
                      ],
                    ),
                  ),
                  SizedBox(height: hh(context, 20)),
                  ListView.separated(
                    itemCount: provider.allBrands.length,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: (){
                          provider.getAllProductsByBrand(context: context, brandId: provider.allBrands[index].id);
                          pushTo(context,
                              AllProductsByBrandScreen(brandId: provider.allBrands[index].id,
                          brandName: provider.allBrands[index].name,
                          brandImg: provider.allBrands[index].img,));
                        },
                        child: SizedBox(
                          width: w(context),
                          child: Container(
                            margin: EdgeInsets.only(left: w20(context), right: w20(context)),
                            padding: const EdgeInsets.all(
                              10,

                            ),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(ww(context, 10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  offset: Offset(0, hh(context, 4)),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(provider.allBrands[index].img,height: hh(context, 75),width:  hh(context, 90),fit: BoxFit.cover,)),
                                SizedBox(
                                  width: ww(context, 20),
                                ),
                                Text(
                                  provider.allBrands[index].name,
                                  style: head36(context, AppColors.primary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: hh(context, 40)),
                ],
              ),
            )));
  }
}


