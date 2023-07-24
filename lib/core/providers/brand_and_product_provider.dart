import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/core/shared_prefs/shared_prefs.dart';
import 'package:delivery_app/views/basket/order_confirmed.dart';
import 'package:delivery_app/views/basket/order_error.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'dart:io';
import '../init/navigate.dart';
import '../models/product_model.dart';


class BrandAndProductProvider with ChangeNotifier {

  List<BrandModel> allBrands = [];
  List<BrandModel> myBrands = [];
  List<ProductModel> allProductsByBrand = [];
  List<ProductModel> allProducts = [];

  createBrand({required String brandName,
    required File imageFile,
    required BuildContext context}) async {
    try {
      String imageUrl = await uploadImageToFirebaseStorage(imageFile);
      int uploadTimestamp = DateTime
          .now()
          .millisecondsSinceEpoch;
      String id = uploadTimestamp.toString();

      CollectionReference brandsCollection = FirebaseFirestore.instance
          .collection('Brands');
      await brandsCollection.doc(id).set({
        'name': brandName,
        'id': id,
        'img': imageUrl,
      }).whenComplete(() {
        getAllBrands(context: context);
        Navigator.pop(context);});
    } catch (e) {
      pushTo(context, const OrderError());
      log(e.toString());
    }
    notifyListeners();
  }


  uploadProducts({
    required String name,
    required String description,
    required List<File> images,
    required String price,
    required String brandName,
    required String brandId,
    required String brandImg,
    required BuildContext context,
  }) async {
    try{
      List<String> photoUrls = [];
      int uploadTimestamp = DateTime
          .now()
          .millisecondsSinceEpoch;
      String id = uploadTimestamp.toString();
      // Upload photos to Firebase Storage
      for (int i = 0; i < images.length; i++) {
        File photo = images[i];
        String fileName =
            '${DateTime.now().millisecondsSinceEpoch}_${photo.path.split('/').last}';

        Reference storageRef =
            FirebaseStorage.instance.ref().child('photos/$fileName');
        UploadTask uploadTask = storageRef.putFile(photo);

        TaskSnapshot snapshot = await uploadTask;
        if (snapshot.state == TaskState.success) {
          // Retrieve the download URL of the uploaded photo
          String downloadUrl = await snapshot.ref.getDownloadURL();
          photoUrls.add(downloadUrl);
        } else {
          log('Photo $i upload failed.');
        }
      }

      // Add product data to Firestore
      await FirebaseFirestore.instance
          .collection('Brands')
          .doc(brandId)
          .collection('Products')
          .doc(id)
          .set({
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'images': photoUrls,
        'brandName': brandName,
        'brandId': brandId,
        'brandImg': brandImg,
      }).then((value) {
        getAllProductsByBrand(context: context, brandId: brandId);
        Navigator.pop(context);
      });

      log('Product added successfully.');
    } catch (e){
      pushTo(context, const OrderError());
      log(e.toString());
    }
    notifyListeners();
  }

  getAllBrands({required BuildContext context}) async {
    try {
      await FirebaseFirestore.instance
          .collection('Brands').get().then((value) {
            allBrands.clear();
            List<BrandModel> aBrands = [];
        for (int i = 0; i < value.docs.length; i++) {
          BrandModel model = BrandModel(id: value.docs[i].data()['id'],
              name: value.docs[i].data()['name'],
              img: value.docs[i].data()['img']);
          aBrands.add(model);
        }
        allBrands = aBrands;
      });
    } catch (e) {
      pushTo(context, const OrderError());
      log(e.toString());
    }
    notifyListeners();
  }

  getAllProductsByBrand({required BuildContext context, required String brandId}) async {
    try {
      await FirebaseFirestore.instance
          .collection('Brands').doc(brandId).collection('Products').get().then((value) {
        allProductsByBrand.clear();
        List<ProductModel> aProducts = [];
        for (int i = 0; i < value.docs.length; i++) {
          ProductModel model = ProductModel(
              id: int.parse(value.docs[i].data()['id']),
              name: value.docs[i].data()['name'],
              imageList: value.docs[i].data()['images'],
              brandId: value.docs[i].data()['brandId'],
              brandName: value.docs[i].data()['brandName'],
              price: double.parse(value.docs[i].data()['price']),
              description: value.docs[i].data()['description'],
              brandImg: value.docs[i].data()['brandImg'],
          );
          aProducts.add(model);
        }
        allProductsByBrand = aProducts;
      });
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }

  getAllProducts({required BuildContext context}) async {
    try {
      await FirebaseFirestore.instance
          .collection('Brands').get().then((val) async {
        allProducts.clear();
        List<ProductModel> aProducts = [];
      for(int index =0; index < val.docs.length; index++){
        await FirebaseFirestore.instance
            .collection('Brands').doc(val.docs[index].data()['id']).collection('Products').get().then((value) {
          for (int i = 0; i < value.docs.length; i++) {
            ProductModel model = ProductModel(
              id: int.parse(value.docs[i].data()['id']),
              name: value.docs[i].data()['name'],
              imageList: value.docs[i].data()['images'],
              brandId: value.docs[i].data()['brandId'],
              brandName: value.docs[i].data()['brandName'],
              price: double.parse(value.docs[i].data()['price']),
              description: value.docs[i].data()['description'],
              brandImg: value.docs[i].data()['brandImg'],
            );
            aProducts.add(model);
          }
          allProducts = aProducts;
        });
      }
      });
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }


  Future<String> uploadImageToFirebaseStorage(File imageFile) async {
    String fileName = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    Reference storageReference = FirebaseStorage.instance.ref().child(
        'images/$fileName');
    UploadTask uploadTask = storageReference.putFile(imageFile);
    TaskSnapshot storageSnapshot = await uploadTask.whenComplete(() {});
    String imageUrl = await storageSnapshot.ref.getDownloadURL();

    return imageUrl;
  }


}
