import 'package:delivery_app/views/base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/init/metrics.dart';
import '../../core/providers/users_provider.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_theme.dart';

class AllOrderTakersScreen extends StatelessWidget {
  const AllOrderTakersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Base(child:
    Consumer<UsersProvider>(
        builder: (context, provider, child) =>
            Column(

              children: [
                SizedBox(height: hh(context, 50)),
                Text(
                  "All Order Takers",
                  style: head36(context, AppColors.primary),
                ),
                SizedBox(height: hh(context, 20)),
                ListView.separated(
                  itemCount: provider.usersList.length,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: w(context),
                      child: Container(
                        margin: EdgeInsets.only(left: w20(context), right: w20(context)),
                        padding: EdgeInsets.fromLTRB(
                          w20(context),
                          w20(context),
                          w20(context),
                          hh(context, 5),
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
                        child: RichText(
                          text: TextSpan(
                            style: head18(context, AppColors.primary),
                            children: [
                              TextSpan(
                                text: "${provider.usersList[index].firstName} ${provider.usersList[index].lastName}   ",
                              ),
                              TextSpan(
                                text: '("${provider.usersList[index].role}")\n',
                                style: titleMedium14(context, AppColors.dark),
                              ),
                              TextSpan(
                                text: "${provider.usersList[index].email}\n${provider.usersList[index].phone}\n",
                                style: titleMedium14(context, AppColors.dark),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            )));
  }
}


