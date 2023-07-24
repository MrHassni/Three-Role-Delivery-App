import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../core/init/enums.dart';
import '../../core/init/metrics.dart';
import '../../core/init/navigate.dart';
import '../../core/models/product_model.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_theme.dart';
import '../../core/widgets/buttons/solid_button.dart';
import '../../core/widgets/inputs/solid_input.dart';
import '../base.dart';
import 'confirm_checkout.dart';

class AdditionalInfo extends StatefulWidget {
  final List<CartItem> products;
  final double price;
  const AdditionalInfo({super.key, required this.products, required this.price});

  @override
  State<AdditionalInfo> createState() => _AdditionalInfoState();
}

class _AdditionalInfoState extends State<AdditionalInfo> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController departmentNameController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController specificsController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    InputState inputState = InputState.Default;
    return Base(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: hh(context, 60.33)),
            horizontalpadding(
              context,
              child: Text(
                "BASKET",
                style: head36(context, textPrimary(context)),
              ),
            ),
            SizedBox(height: hh(context, 40)),
            horizontalpadding(
              context,
              child: SolidInput(
                controller: fullNameController,
                label: "FULL NAME",
                hintText: "Muhammad Hassan Arshad",
              ),
            ),
            SizedBox(height: hh(context, 30)),
            horizontalpadding(
              context,
              child: SolidInput(
                controller: departmentNameController,
                label: "DEPARTMENT",
                hintText: "Development eg.",
              ),
            ),
            SizedBox(height: hh(context, 30)),
            horizontalpadding(
              context,
              child: SolidInput(
                controller: designationController,
                label: "DESIGNATION",
                hintText: "Mobile App Developer eg.",
              ),
            ),
            SizedBox(height: hh(context, 30)),
            horizontalpadding(
              context,
              child: SolidInput(
                controller: floorController,
                label: "FLOOR",
                hintText: "Ground floor eg.",
              ),
            ),
            SizedBox(height: hh(context, 30)),
            horizontalpadding(
              context,
              child: SolidInput(
                controller: specificsController,
                label: "OTHER SPECIFICS",
                hintText: "Table No# 35 eg.",
              ),
            ),
            SizedBox(height: hh(context, 30)),
            horizontalpadding(
              context,
              child: SolidInput(
                controller: phoneController,
                label: "PHONE",
                hintText: "+90433434342",
              ),
            ),
            SizedBox(height: hh(context, 30)),
            horizontalpadding(
              context,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: w20(context)),
                            child: Text(
                              'NOTE',
                              style: label(context, AppColors.primary),
                            ),
                          ),
                          SizedBox(height: hh(context, 5)),
                        ],
                      ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                        left: w20(context),
                        right: ww(context, 10),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(hh(context, 40)),
                        color: bgSecondary(context),
                        border: Border.all(

                          color: inputState == InputState.Default
                              ? bgSecondary(context)
                              : inputState == InputState.Focus
                              ? AppColors.primary
                              : inputState == InputState.Error
                              ? AppColors.error
                              : AppColors.success,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Focus(
                              onFocusChange: (val) {
                                setState(() {
                                  inputState = val
                                      ? InputState.Focus
                                      : InputState.Default;
                                });
                              },
                              child: TextField(
                                  maxLines: 3,
                                  controller: noteController,
                                  cursorColor: AppColors.primary,
                                  style: input(context, textPrimary(context)),
                                  decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(bottom: 7,top: 7),
                                  hintText: 'Extra catchup\'s',
                                  hintStyle: input(context, textSecondary),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: hh(context, 50)),
            horizontalpadding(
              context,
              child: SolidBorderedButton(
                onTap: () {
                  if(
                  fullNameController.text.isNotEmpty &&
                  departmentNameController.text.isNotEmpty &&
                  designationController.text.isNotEmpty &&
                  floorController.text.isNotEmpty &&
                  specificsController.text.isNotEmpty &&
                  phoneController.text.isNotEmpty &&
                  noteController.text.isNotEmpty) {
                    pushTo(
                    context,
                    ConfirmCheckout(
                      price: widget.price,
                      products: widget.products,
                      name: fullNameController.text,
                      department: departmentNameController.text,
                      designation: designationController.text,
                      address: floorController.text,
                      specifics: specificsController.text,
                      phone: phoneController.text,
                      note: noteController.text,
                    ));
                  }else{
                    OverlayState overlayState = Overlay.of(context);
                    showTopSnackBar(
                      overlayState,
                      const CustomSnackBar.error(
                        message:
                        "Please fill all the information.",
                      ),
                    );
                  }},
                text: "CHECKOUT",
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
