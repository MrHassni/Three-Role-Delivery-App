import 'package:delivery_app/core/providers/auth_providers.dart';
import 'package:delivery_app/views/rider_home/rider_home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../core/init/metrics.dart';
import '../../core/init/navigate.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_theme.dart';
import '../../core/widgets/buttons/solid_button.dart';
import '../../core/widgets/inputs/solid_input.dart';
import '../base.dart';
import '../main_page.dart';
import '../opening/onboarding/get_started.dart';
import 'address_setup.dart';
import 'auth_header.dart';
import 'login.dart';


class Register extends StatelessWidget {
  final String role;
   Register({super.key, required this.role});

   TextEditingController firstNameController = TextEditingController();
   TextEditingController lastNameController = TextEditingController();
   TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Base(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthPageHeader(
              text: "INFO",
              onTap: () => replaceTo(context,  GetStarted(role: role,)),
            ),
            SizedBox(height: hh(context, 60.33)),
            horizontalpadding(
              context,
              child: SolidInput(
                controller: firstNameController,
                label: "FIRST NAME",
                hintText: "Muhammad",
              ),
            ),
            SizedBox(height: hh(context, 30)),
            horizontalpadding(
              context,
              child: SolidInput(
                controller: lastNameController,
                label: "LAST NAME",
                hintText: "Hassan",
              ),
            ),
            SizedBox(height: hh(context, 30)),
            horizontalpadding(
              context,
              child: SolidInput(
                controller: phoneController,
                label: "PHONE",
                hintText: "+90 555 123 4567",
              ),
            ),
            // SizedBox(height: hh(context, 30)),
            // horizontalpadding(
            //   context,
            //   child: const SolidInput(
            //     label: "PASSWORD",
            //     hintText: "Password",
            //     iconName: "Eye Open",
            //   ),
            // ),
            // Container(
            //   alignment: Alignment.centerRight,
            //   padding: EdgeInsets.only(right: w20(context)),
            //   child: TextButton(
            //     onPressed: () {},
            //     child: Text(
            //       "Forgot Password?",
            //       style: body(context, textSecondary),
            //     ),
            //   ),
            // ),
            SizedBox(height: hh(context, 50)),
            horizontalpadding(
              context,
              child: SolidBorderedButton(
                onTap: () {
                  if(
                  firstNameController.text.isNotEmpty &&
                  lastNameController.text.isNotEmpty &&
                  phoneController.text.isNotEmpty) {
                    Provider.of<AuthProvider>(context, listen: false).createRecord(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        phone: phoneController.text,
                        context: context,
                        role: role);
                  }else{
                    OverlayState overlayState = Overlay.of(context);
                    showTopSnackBar(
                      overlayState,
                      const CustomSnackBar.error(
                        message:
                        "Please fill all the information.",
                      ),
                    );
                  }
                  },
                text: "SAVE INFO",
                bgColor: AppColors.primary,
                borderColor: AppColors.primary,
                textColor: AppColors.white,
              ),
            ),
            // SizedBox(height: hh(context, 20)),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       "Already have an account?",
            //       style: body(context, textSecondary),
            //     ),
            //     TextButton(
            //       onPressed: () => pushTo(context,  Login(isRider: isRider,)),
            //       child: Text(
            //         "Login",
            //         style: body(context, AppColors.secondary),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: hh(context, 50)),
          ],
        ),
      ),
    );
  }
}
