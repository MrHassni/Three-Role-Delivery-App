import 'package:delivery_app/core/providers/brand_and_product_provider.dart';
import 'package:delivery_app/views/base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/init/metrics.dart';
import '../../core/init/navigate.dart';
import '../../core/providers/users_provider.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_theme.dart';
import 'add_new_user_screen.dart';

class AllUserScreen extends StatefulWidget {
  const AllUserScreen({Key? key}) : super(key: key);

  @override
  State<AllUserScreen> createState() => _AllUserScreenState();
}

class _AllUserScreenState extends State<AllUserScreen> {

  @override
  Widget build(BuildContext context) {
    return Base(child:
    Consumer<UsersProvider>(
        builder: (context, provider, child) =>
    Column(

      children: [
        SizedBox(height: hh(context, 50)),
        horizontalpadding(
          context,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "All Users",
                style: head36(context, AppColors.primary),
              ),
              InkWell(
                  onTap: (){
                    pushTo(context,  const AddNewUsersScreen());
                  },
                  child: const Icon(Icons.mode_edit_outline_outlined, color: AppColors.primary,))
            ],
          ),
        ),
        SizedBox(height: hh(context, 20)),
        ListView.separated(
          itemCount: provider.allUsersList.length,
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
                        text: "${provider.allUsersList[index].firstName} ${provider.allUsersList[index].lastName}   ",
                      ),
                      TextSpan(
                        text: '("${provider.allUsersList[index].role}")\n',
                        style: titleMedium14(context, AppColors.dark),
                      ),
                      TextSpan(
                        text: "${provider.allUsersList[index].email}\n${provider.allUsersList[index].phone}",
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


