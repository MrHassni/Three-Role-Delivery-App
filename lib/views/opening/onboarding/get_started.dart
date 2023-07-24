import 'package:flutter/material.dart';

import '../../../core/init/metrics.dart';
import '../../../core/init/navigate.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_theme.dart';
import '../../../core/widgets/buttons/solid_button.dart';
import '../../../core/widgets/logo/logo.dart';
import '../../auth/login.dart';
import '../../auth/register.dart';

class GetStarted extends StatelessWidget {
  final String role;
  const GetStarted({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: w(context),
        height: h(context),
        color: bgPrimary(context),
        padding: EdgeInsets.symmetric(
          horizontal: w20(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: hh(context, 50)),
            logo(
              context,
              foodStyle: head18(context, textPrimary(context)),
              eStyle: head18(context, AppColors.primary),
            ),
            SizedBox(height: hh(context, 50)),
            RichText(
              text: TextSpan(
                style: head36(context, textPrimary(context)),
                children: [
                  const TextSpan(
                    text: "GET ",
                  ),
                  TextSpan(
                    text: "STARTED",
                    style: head36(context, AppColors.primary),
                  ),
                ],
              ),
            ),
            SizedBox(height: hh(context, 10)),
            Text(
              "The Awesome Local Food Right At Your Home.",
              style: titleMedium14(context, textPrimary(context)),
            ),
            const Spacer(),
            SolidBorderedButton(
              onTap: () => pushTo(context, Login(role: role,)),
              text: "LOGIN",
              bgColor: AppColors.primary,
              borderColor: AppColors.primary,
              textColor: AppColors.white,
            ),
            // SizedBox(height: hh(context, 30)),
            // SolidBorderedButton(
            //   onTap: () => pushTo(context, Register(isRider: isRider,)),
            //   text: "REGISTER",
            //   bgColor: bgPrimary(context),
            //   borderColor: AppColors.primary,
            //   textColor: AppColors.primary,
            // ),
            SizedBox(height: hh(context, 60)),
          ],
        ),
      ),
    );
  }
}
