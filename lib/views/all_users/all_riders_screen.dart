import 'dart:developer';

import 'package:delivery_app/core/providers/auth_providers.dart';
import 'package:delivery_app/core/shared_prefs/shared_prefs.dart';
import 'package:delivery_app/views/base.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';

import '../../core/init/metrics.dart';
import '../../core/models/product_model.dart';
import '../../core/providers/brand_and_product_provider.dart';
import '../../core/providers/users_provider.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_theme.dart';

class AllRidersScreen extends StatefulWidget {
  const AllRidersScreen({Key? key}) : super(key: key);

  @override
  State<AllRidersScreen> createState() => _AllRidersScreenState();
}

class _AllRidersScreenState extends State<AllRidersScreen> {
  List<BrandModel> listOfAllBrands = [];
  List selectedBrands = [];
  List<String> dDValues = [];
  dynamic _items;

  void _showMultiSelect(BuildContext context, uid) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet(
          items: _items,
          itemsTextStyle: body(context, AppColors.dark),
          initialValue: selectedBrands,
          selectedColor: AppColors.primary,
          cancelText: Text(
            'CANCEL',
            style: head18(context, AppColors.primary),
          ),
          confirmText: Text(
            'DONE',
            style: head18(context, AppColors.primary),
          ),
          onConfirm: (values) {
            List data = [];
            for (int i = 0; i < values.length; i++) {
              data.add({
                'id': values[i].id,
                'img': values[i].img,
                'name': values[i].name
              });
            }
            log(data.length.toString());
            Provider.of<AuthProvider>(context, listen: false)
                .upDateBrands(uid, data).then((_){
              Provider.of<UsersProvider>(context, listen: false).getAllUsers();
                  Navigator.pop(context);
            });
            log(values.toString());
          },
          maxChildSize: 0.8,
        );
      },
    );
  }

  @override
  void initState() {
    BrandAndProductProvider provider =
        Provider.of<BrandAndProductProvider>(context, listen: false);
    for (int i = 0; i < provider.allBrands.length; i++) {
      listOfAllBrands.add(provider.allBrands[i]);
    }
    _items = listOfAllBrands
        .map((animal) => MultiSelectItem<BrandModel>(animal, animal.name))
        .toList();

    // UsersProvider pro =
    // Provider.of<UsersProvider>(context, listen: false);
    // for (int i = 0; i < pro.ridersList.length; i++) {
    //
    //   if(pro.ridersList[i].brands != null) {
    //     for(int ii = 0; ii < pro.ridersList[i].brands!.length; ii++){
    //       selectedBrands.add(pro.ridersList[i].brands![ii]['name'],
    //      );
    //     }
    //   }
    // }


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Base(
        child: Consumer<UsersProvider>(
            builder: (context, provider, child) => Column(
                  children: [
                    SizedBox(height: hh(context, 50)),
                    Text(
                      "All Riders",
                      style: head36(context, AppColors.primary),
                    ),
                    SizedBox(height: hh(context, 20)),
                    ListView.separated(
                      itemCount: provider.ridersList.length,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: w(context),
                          child: Container(
                            margin: EdgeInsets.only(
                                left: w20(context), right: w20(context)),
                            padding: EdgeInsets.fromLTRB(
                              w20(context),
                              w20(context),
                              w20(context),
                              hh(context, 5),
                            ),
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
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: head18(context, AppColors.primary),
                                    children: [
                                      TextSpan(
                                        text:
                                            "${provider.ridersList[index].firstName} ${provider.ridersList[index].lastName}   ",
                                      ),
                                      TextSpan(
                                        text:
                                            '("${provider.ridersList[index].role}")\n',
                                        style: titleMedium14(
                                            context, AppColors.dark),
                                      ),
                                      TextSpan(
                                        text:
                                            "${provider.ridersList[index].email}\n${provider.ridersList[index].phone}\n",
                                        style: titleMedium14(
                                            context, AppColors.dark),
                                      ),
                                    ],
                                  ),
                                ),
                                provider.ridersList[index].brands != null
                                    ? SizedBox(
                                        height: 95,
                                        child: ListView.separated(
                                          itemCount: provider
                                              .ridersList[index].brands!.length,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          separatorBuilder:
                                              (BuildContext context, int ind) =>
                                                  const SizedBox(
                                            width: 10,
                                          ),
                                          itemBuilder:
                                              (BuildContext context, int ind) {
                                            return Container(
                                              decoration: const BoxDecoration(
                                                color: AppColors.primaryLight,
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  bottomLeft: Radius.circular(15),
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: const BorderRadius.only(
                                                      topRight: Radius.circular(15),
                                                    ),
                                                    child: Image.network(provider.ridersList[index]
                                                        .brands![ind]['img'],
                                                    width: 90,
                                                    height: 65,
                                                    fit: BoxFit.cover,),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(5),
                                                    child: Text(
                                                      provider.ridersList[index]
                                                          .brands![ind]['name'],
                                                      style:
                                                          label(context, AppColors.dark),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ))
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: InkWell(
                                    onTap: () {
                                      _showMultiSelect(context,
                                          provider.ridersList[index].id);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.dark,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: const EdgeInsets.all(15),
                                      child: Text(
                                        'MANAGE BRANDS',
                                        style: head18(context, AppColors.primary),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                )));
  }
}
