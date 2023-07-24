import 'package:delivery_app/core/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/init/metrics.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_theme.dart';
import '../../core/widgets/buttons/solid_button.dart';
import '../../core/widgets/inputs/solid_input.dart';
import '../base.dart';

class AddNewUsersScreen extends StatefulWidget {
  const AddNewUsersScreen({super.key});

  @override
  State<AddNewUsersScreen> createState() => _AddNewUsersScreenState();
}

class _AddNewUsersScreenState extends State<AddNewUsersScreen> {
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Base(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: hh(context, 50)),
            horizontalpadding(
              context,
              child: Text(
                'ADD NEW USERS',
                style: head36(context, textPrimary(context)),
              ),
            ),
            SizedBox(height: hh(context, 60.33)),
            horizontalpadding(
              context,
              child: SolidInput(
                controller: userEmailController,
                label: "EMAIL",
                hintText: "example@gmail.com",
              ),
            ),
            SizedBox(height: hh(context, 30)),
            horizontalpadding(
              context,
              child: SolidInput(
                controller: userPasswordController,
                label: "Password",
                hintText: "Password",
              ),
            ),
            SizedBox(height: hh(context, 50)),
            horizontalpadding(
              context,
              child: SolidBorderedButton(
                onTap: () {
                  Provider.of<AuthProvider>(context, listen: false).createUserWithEmailAndPassword(userEmailController.text, userPasswordController.text, context);
                },
                text: "SAVE User",
                bgColor: AppColors.primary,
                borderColor: AppColors.primary,
                textColor: AppColors.white,
              ),
            ),
            SizedBox(height: hh(context, 50)),
          ],
        ),
      ),
    );
  }
}
