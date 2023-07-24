import 'dart:io';

import 'package:delivery_app/core/providers/brand_and_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../core/init/metrics.dart';
import '../../core/init/navigate.dart';

import '../../core/theme/colors.dart';
import '../../core/theme/text_theme.dart';
import '../../core/widgets/buttons/solid_button.dart';
import '../../core/widgets/inputs/solid_input.dart';
import '../auth/auth_header.dart';
import '../base.dart';

class AddNewBrandsScreen extends StatefulWidget {
  const AddNewBrandsScreen({super.key});

  @override
  State<AddNewBrandsScreen> createState() => _AddNewBrandsScreenState();
}

class _AddNewBrandsScreenState extends State<AddNewBrandsScreen> {
  final TextEditingController brandNameController = TextEditingController();
  File? pickedImage;

  Future<File?> pickImage() async {
    final picker = ImagePicker();
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      pickedImage = File(image!.path); // won't have any error now
    });

    if (pickedImage != null) {
      return File(image!.path);
    }

    return null;
  }

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
                'ADD NEW BRANDS',
                style: head36(context, textPrimary(context)),
              ),
            ),
            SizedBox(height: hh(context, 60.33)),
            InkWell(
              onTap: () async {
                File? pickedImage = await pickImage();
                if (pickedImage != null) {}
              },
              child: Center(
                child: SizedBox(
                  width: (w(context) / 2),
                  child: Container(
                    margin: EdgeInsets.only(left: w20(context), right: 10),
                    padding: pickedImage != null
                        ? EdgeInsets.zero
                        : EdgeInsets.all(
                            w20(context),
                          ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(ww(context, 10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.15),
                          offset: Offset(0, hh(context, 4)),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: Center(
                      child: pickedImage != null
                          ? ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(ww(context, 10)),
                              child: Image.file(File(pickedImage!.path)))
                          : RichText(
                              text: TextSpan(
                                style: head24(context, AppColors.white),
                                children: const [
                                  TextSpan(
                                    text: "Pick Image",
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: hh(context, 30)),
            horizontalpadding(
              context,
              child: SolidInput(
                controller: brandNameController,
                label: "Brand NAME",
                hintText: "Pizza Hut",
              ),
            ),
            SizedBox(height: hh(context, 50)),
            horizontalpadding(
              context,
              child: SolidBorderedButton(
                onTap: () {
                  Provider.of<BrandAndProductProvider>(context, listen: false)
                      .createBrand(
                          brandName: brandNameController.text,
                          imageFile: pickedImage!,
                          context: context);
                },
                text: "SAVE Brand",
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
