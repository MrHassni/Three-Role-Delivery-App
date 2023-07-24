import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';


class UsersProvider with ChangeNotifier {

  List<UserModel> ridersList = [];
  List<UserModel> usersList = [];
  List<UserModel> allUsersList = [];


  getAllUsers() async {
    try {
      await FirebaseFirestore.instance.collection('Users').get().then((value) {
        ridersList.clear();
        usersList.clear();
        List<UserModel> rList = [];
        List<UserModel> uList = [];
        List<UserModel> auList = [];
        for (int i = 0; i < value.docs.length; i++) {
          UserModel model = UserModel(
              firstName: value.docs[i].data()['firstName'],
              id: value.docs[i].data()['uid'],
              lastName: value.docs[i].data()['lastName'],
              phone: value.docs[i].data()['phone'],
              role: value.docs[i].data()['role'],
              brands: value.docs[i].data()['brands'],
              email: value.docs[i].data()['email']);
          auList.add(model);
          if(value.docs[i]['role'] == 'rider'){
            rList.add(model);
          }else if(value.docs[i]['role'] == 'user'){
            uList.add(model);
          }
        }
        ridersList = rList;
        usersList = uList;
        allUsersList = auList;
        log(auList.length.toString());
      });
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }


}
