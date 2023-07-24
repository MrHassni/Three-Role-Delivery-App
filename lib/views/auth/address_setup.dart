import 'package:delivery_app/views/auth/payment_setup.dart';
import 'package:flutter/material.dart';

import '../../core/init/metrics.dart';
import '../../core/init/navigate.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_theme.dart';
import '../../core/widgets/buttons/solid_button.dart';
import '../../core/widgets/inputs/solid_input.dart';
import '../base.dart';
import 'auth_header.dart';


class AddressSetup extends StatelessWidget {
  const AddressSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return Base(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthPageHeader(
              text: "ADDRESS SETUP",
              onTap: () => popTo(context),
            ),
            SizedBox(height: hh(context, 50)),
            horizontalpadding(
              context,
              child: const SolidInput(
                label: "ADDRESS LINE 1",
                hintText: "Address",
              ),
            ),
            SizedBox(height: hh(context, 30)),
            horizontalpadding(
              context,
              child: const SolidInput(
                label: "ADDRESS LINE 2",
                hintText: "Address",
              ),
            ),
            SizedBox(height: hh(context, 30)),
            horizontalpadding(
              context,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SolidInput(
                    label: "ZIP CODE",
                    hintText: "000-000",
                    width: (w(context) - ww(context, 60)) / 2,
                  ),
                  SolidInput(
                    label: "CITY",
                    hintText: "City",
                    width: (w(context) - ww(context, 60)) / 2,
                  ),
                ],
              ),
            ),
            SizedBox(height: hh(context, 30)),
            horizontalpadding(
              context,
              child: const SolidInput(
                label: "COUNTRY",
                hintText: "Country",
              ),
            ),
            SizedBox(height: hh(context, 50)),
            horizontalpadding(
              context,
              child: const SolidBorderedButton(
                // onTap: () => pushTo(context, Login()),
                text: "ADD ADDRESS",
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
                  onPressed: () => pushTo(context,  const PaymentSetup()),
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
