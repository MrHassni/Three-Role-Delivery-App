import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/core/models/product_model.dart';
import 'package:delivery_app/core/models/user_model.dart';
import 'package:delivery_app/core/shared_prefs/shared_prefs.dart';
import 'package:delivery_app/views/admin_home/admin_home.dart';
import 'package:delivery_app/views/auth/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../init/navigate.dart';
import '../../views/main_page.dart';
import '../../views/rider_home/rider_home.dart';

class AuthProvider with ChangeNotifier {

  UserModel? currentUser;

  dynamic uId;
  String? theEmail;
  List<ProductModel> favProducts = [];

  loginUser(
      {required String email,
      required String password,
      required BuildContext context,
      required String role}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
            uId = value.user!.uid;
            theEmail = value.user!.email.toString();
        await FirebaseFirestore.instance
            .collection('Users').doc(value.user!.uid).get().then((val) {
              if(val.data() == null){
                pushTo(context, Register(role: role));
              }else{
                currentUser = UserModel(
                    firstName: val['firstName'],
                    id: val['uid'],
                    lastName: val['lastName'],
                    phone: val['phone'],
                    role: val['role'],
                    email: val['email'],
                    brands: val['brands']);
                SharedPrefs.saveUserLoggedInSharedPreference(true);
                SharedPrefs.saveUserRoleSharedPreference(val['role']);
                SharedPrefs.saveUserEmailSharedPreference(val['email']);
                SharedPrefs.saveUserIDSharedPreference(val['uid']);
                SharedPrefs.saveUserPhoneSharedPreference(val['phone']);
                SharedPrefs.saveUserNameSharedPreference(val['firstName'] + ' ' + val['lastName']);

                if(val['role'] == 'rider'){
                  replaceTo(context, const RiderHome());
                }else if(val['role'] == 'user'){
                  replaceTo(context, const MainPage());
                }else if(val['role'] == 'admin'){
                  replaceTo(context, const AdminHome());
                }
              }
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        OverlayState overlayState = Overlay.of(context);
        showTopSnackBar(
          overlayState,
          const CustomSnackBar.error(
            message:
            "Wrong credentials provided for that user.",
          ),
        );
      } else if (e.code == 'wrong-password') {
        OverlayState overlayState = Overlay.of(context);
        showTopSnackBar(
          overlayState,
          const CustomSnackBar.error(
            message:
            "Wrong password provided for that user.",
          ),
        );
      }
    }
    notifyListeners();
  }

  createRecord(
      {required String firstName,
        required String lastName,
        required String phone,
        required BuildContext context,
        required String role}) async {
    try {
      if(uId != null) {
        await FirebaseFirestore.instance
            .collection('Users').doc(uId).set(
            {
              'firstName': firstName,
              'lastName': lastName,
              'phone': phone,
              'uid': uId,
              'email': theEmail,
              'role': role,
              'brands': null
            }).then((value) {
          currentUser = UserModel(
              firstName: firstName,
              id: uId,
              lastName: lastName,
              phone: phone,
              role: role,
              email: theEmail!,
              brands: null);
          SharedPrefs.saveUserLoggedInSharedPreference(true);
          SharedPrefs.saveUserRoleSharedPreference(role);
          SharedPrefs.saveUserEmailSharedPreference(theEmail!);
          SharedPrefs.saveUserIDSharedPreference(uId);
          SharedPrefs.saveUserNameSharedPreference('$firstName $lastName');
          SharedPrefs.saveUserPhoneSharedPreference(phone);


              if(role == 'user'){
                replaceTo(context, const MainPage());
              }else if(role == 'rider'){
                replaceTo(context, const RiderHome());
              }else if(role == 'admin'){
                replaceTo(context, const AdminHome());
              }
        });
      }
    }  catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }


  upDateBrands(uid ,brands) async {
    try {
      var a = await FirebaseFirestore.instance
          .collection("Users")
          .doc(uid)
          .get();
      log(uid.toString());
      log(a.exists.toString());
      if (a.exists) {
        final DocumentReference documentReference = FirebaseFirestore.instance
            .collection("Users")
            .doc(uid);
        return await documentReference.update({
          'brands': brands
        });
      }
        await FirebaseFirestore.instance
            .collection('Users').doc(uid).update(
            {'brands': brands});
    }  catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }

  logOut() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    preferences.setBool('first_time', false);
  }

  Future<UserCredential> createUserWithEmailAndPassword(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      log(userCredential.toString());
      Navigator.pop(context);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Handle any errors that occurred during user creation
      if (kDebugMode) {
        print('Error creating user: ${e.message}');
      }
      rethrow;
    }
  }


  fav({required ProductModel fav}){
    favProducts.add(fav);
    notifyListeners();
  }

  removeFav({required ProductModel removeFav}){
    favProducts.remove(removeFav);
    notifyListeners();
  }

  dataFromSharedPrefs() async {

    await FirebaseFirestore.instance
        .collection('Users').doc((await SharedPrefs.getUserIDSharedPreference()).toString()).get().then((val) {
      currentUser = UserModel(
          firstName: val['firstName'],
          id: val['uid'],
          lastName: val['lastName'],
          phone: val['phone'],
          role: val['role'],
          email: val['email'],
          brands: val['brands']);
    });
  // currentUser = UserModel(
  //     firstName: (await SharedPrefs.getUserNameSharedPreference()).toString(),
  //     id: (await SharedPrefs.getUserIDSharedPreference()).toString(),
  //     lastName: (await SharedPrefs.getUserNameSharedPreference()).toString(),
  //     phone: (await SharedPrefs.getUserPhoneSharedPreference()).toString(),
  //     role: (await SharedPrefs.getUserRoleSharedPreference()).toString(),
  //     email: (await SharedPrefs.getUserEmailSharedPreference()).toString(),);
  }


}
