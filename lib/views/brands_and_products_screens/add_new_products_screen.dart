import 'dart:io';

import 'package:delivery_app/core/providers/brand_and_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../core/init/metrics.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_theme.dart';
import '../../core/widgets/buttons/solid_button.dart';
import '../../core/widgets/inputs/solid_input.dart';
import '../base.dart';

class AddNewProductsScreen extends StatefulWidget {
  final String brandId, brandName, brandImg;
  const AddNewProductsScreen({super.key, required this.brandId, required this.brandName, required this.brandImg});

  @override
  State<AddNewProductsScreen> createState() => _AddNewProductsScreenState();
}

class _AddNewProductsScreenState extends State<AddNewProductsScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productDescriptionController = TextEditingController();
  final TextEditingController productsPriceController = TextEditingController();
  bool loading = false;
  List<File>? _selectedImages;


  Future<void> _pickImages() async {
    List<XFile>? pickedImages = await ImagePicker().pickMultiImage(
      imageQuality: 80,
      maxWidth: 800,
      maxHeight: 800,
    );

    if (pickedImages != null) {
      List<File> images = pickedImages.map((XFile image) => File(image.path)).toList();

      setState(() {
        _selectedImages = images;
      });
    }
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
                'ADD NEW PRODUCTS',
                style: head36(context, textPrimary(context)),
              ),
            ),
            SizedBox(height: hh(context, 60.33)),
        _selectedImages != null
            ? InkWell(
          onTap: _pickImages,
          child: Center(
            child: SizedBox(
              width: w(context),
              child: Center(
                child: SizedBox(
                  height: 150,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: _selectedImages!.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.file(_selectedImages![index],width: (w(context) /2), height: 150,fit: BoxFit.cover,));
                    },
                  ),
                )
              ),
            ),
          ),
        )
            : InkWell(
              onTap: _pickImages,
              child: Center(
                child: SizedBox(
                  width: (w(context) / 2),
                  child: Container(
                    margin: EdgeInsets.only(left: w20(context), right: 10),
                    padding: EdgeInsets.all(
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
                      child:RichText(
                        text: TextSpan(
                          style: head24(context, AppColors.white),
                          children: const [
                            TextSpan(
                              text: "Pick Images",
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
                controller: productNameController,
                label: "PRODUCT NAME",
                hintText: "Product Name",
              ),
            ),
            SizedBox(height: hh(context, 30)),
            horizontalpadding(
              context,
              child: SolidInput(
                controller: productDescriptionController,
                label: "PRODUCT DESCRIPTION",
                hintText: "Product Description",
              ),
            ),
            SizedBox(height: hh(context, 30)),
            horizontalpadding(
              context,
              child: SolidInput(
                controller: productsPriceController,
                textInputType: TextInputType.number,
                label: "PRODUCT PRICE",
                hintText: "Product Price",
              ),
            ),
            SizedBox(height: hh(context, 50)),
            horizontalpadding(
              context,
              child: loading ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              ) : SolidBorderedButton(
                onTap: () {
                  if(productNameController.text.isNotEmpty &&
                     productDescriptionController.text.isNotEmpty &&
                     productsPriceController.text.isNotEmpty &&
                      _selectedImages != null ) {
                    setState(() {
                      loading = true;
                    });
                    Provider.of<BrandAndProductProvider>(context, listen: false).uploadProducts(
                      name: productNameController.text,
                      description: productDescriptionController.text,
                      images: _selectedImages!,
                      price: productsPriceController.text,
                      brandName: widget.brandName,
                      brandId: widget.brandId,
                      brandImg: widget.brandImg, context: context).then((_){
                      setState(() {
                        loading = false;
                      });
                    });
                  }
                },
                text: "SAVE PRODUCT",
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
