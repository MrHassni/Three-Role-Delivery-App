import 'package:delivery_app/core/providers/auth_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/init/metrics.dart';
import '../../core/init/navigate.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_theme.dart';
import '../../core/widgets/buttons/solid_button.dart';
import '../../core/widgets/inputs/solid_input.dart';
import '../base.dart';
import '../opening/onboarding/get_started.dart';
import 'auth_header.dart';
import 'forgot_password.dart';
import 'register.dart';

class Login extends StatefulWidget {
  final String role;

  const Login({super.key, required this.role});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Base(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthPageHeader(
              text: "LOGIN",
              onTap: () => replaceTo(
                  context,
                  GetStarted(
                    role: widget.role,
                  )),
            ),
            SizedBox(height: hh(context, 238.3)),
            horizontalpadding(
              context,
              child: SolidInput(
                label: "EMAIL",
                controller: emailController,
                hintText: "hassan@email.com",
              ),
            ),
            SizedBox(height: hh(context, 30)),
            horizontalpadding(
              context,
              child: SolidInput(
                controller: passwordController,
                label: "PASSWORD",
                hintText: "Password",
                iconName: "Eye Open",
              ),
            ),
            // Container(
            //   alignment: Alignment.centerRight,
            //   padding: EdgeInsets.only(right: w20(context)),
            //   child: TextButton(
            //     onPressed: () => pushTo(context, const ForgotPassword()),
            //     child: Text(
            //       "Forgot Password?",
            //       style: body(context, textSecondary),
            //     ),
            //   ),
            // ),
            SizedBox(height: hh(context, 50)),
            horizontalpadding(
              context,
              child: loading
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ))
                  : SolidBorderedButton(
                      onTap: () {
                        setState(() {
                          loading = true;
                        });
                        Provider.of<AuthProvider>(context, listen: false)
                            .loginUser(
                                email: emailController.text,
                                password: passwordController.text,
                                context: context,
                                role: widget.role)
                            .then((_) {
                          setState(() {
                            loading = false;
                          });
                        });
                      },
                      text: "LOGIN",
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
            //       "Don't have an account?",
            //       style: body(context, textSecondary),
            //     ),
            //     TextButton(
            //       onPressed: () => pushTo(context,  Register(isRider: isRider,)),
            //       child: Text(
            //         "Register",
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
