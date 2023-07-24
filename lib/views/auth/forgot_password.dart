import 'package:flutter/material.dart';

import '../../core/init/metrics.dart';
import '../../core/init/navigate.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_theme.dart';
import '../../core/widgets/buttons/solid_button.dart';
import '../../core/widgets/inputs/solid_input.dart';
import '../base.dart';
import 'auth_header.dart';
import 'email_sent.dart';


class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Base(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthPageHeader(
              text: "FORGOT PASSWORD",
              onTap: () => popTo(context),
            ),
            horizontalpadding(
              context,
              child: Text(
                "We’ll send a password reset link to your email.",
                style: titleMedium14(context, textSecondary),
              ),
            ),
            SizedBox(height: hh(context, 60)),
            horizontalpadding(
              context,
              child: const SolidInput(
                label: "EMAIL",
                hintText: "hassan@email.com",
              ),
            ),
            SizedBox(height: hh(context, 30)),
            horizontalpadding(
              context,
              child: SolidBorderedButton(
                onTap: () => pushTo(context, EmailSent()),
                text: "SEND",
                bgColor: AppColors.primary,
                borderColor: AppColors.primary,
                textColor: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
