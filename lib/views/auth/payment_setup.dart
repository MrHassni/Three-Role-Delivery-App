import 'package:flutter/material.dart';

import '../../core/init/metrics.dart';
import '../../core/init/navigate.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_theme.dart';
import '../../core/widgets/buttons/solid_button.dart';
import '../../core/widgets/inputs/solid_input.dart';
import '../base.dart';
import '../main_page.dart';
import 'auth_header.dart';


class PaymentSetup extends StatelessWidget {
  const PaymentSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return Base(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthPageHeader(
              text: "PAYMENT SETUP",
              onTap: () => popTo(context),
            ),
            SizedBox(height: hh(context, 50)),
            horizontalpadding(
              context,
              child: const SolidInput(
                label: "CARD NUMBER",
                hintText: "XXXX-XXXX-XXXX-XXXX",
              ),
            ),
            SizedBox(height: hh(context, 30)),
            horizontalpadding(
              context,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SolidInput(
                    label: "EXPIRY DATE",
                    hintText: "MM/YY",
                    width: (w(context) - ww(context, 60)) / 2,
                  ),
                  SolidInput(
                    label: "CVV",
                    hintText: "XXX",
                    width: (w(context) - ww(context, 60)) / 2,
                  ),
                ],
              ),
            ),
            SizedBox(height: hh(context, 50)),
            horizontalpadding(
              context,
              child: const SolidBorderedButton(
                // onTap: () => pushTo(context, Login()),
                text: "ADD CARD",
                bgColor: AppColors.primary,
                borderColor: AppColors.primary,
                textColor: AppColors.white,
              ),
            ),
            SizedBox(height: hh(context, 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => pushTo(context, const MainPage()),
                  child: Text(
                    "Skip for now",
                    style: body(context, textSecondary),
                  ),
                ),
              ],
            ),
            SizedBox(height: hh(context, 50)),
          ],
        ),
      ),
    );
  }
}
