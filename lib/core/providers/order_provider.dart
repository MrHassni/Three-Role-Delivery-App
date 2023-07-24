import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/core/models/order_model.dart';
import 'package:delivery_app/core/shared_prefs/shared_prefs.dart';
import 'package:delivery_app/views/basket/order_confirmed.dart';
import 'package:delivery_app/views/basket/order_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/model/cart_model.dart';

import '../init/navigate.dart';
import '../models/product_model.dart';

class OrderProvider with ChangeNotifier {

  //status = 0 => Pending
  //status = 1 => InProgress
  //status = 2 => Completed
  //status = 3 => Canceled
  //status = 4 => Declined

  List<OrderModel> allOrders = [];
  List<OrderModel> riderPendingOrders = [];
  List<OrderModel> riderInProgressOrders = [];
  List<OrderModel> riderCompletedOrders = [];
  List<OrderModel> riderCanceledOrders = [];
  List<OrderModel> riderDeclinedOrders = [];
  List<OrderModel> userAllOrders = [];

  createOrder({required String fullName,
    required String department,
    required String designation,
    required String address,
    required String specifics,
    required String phone,
    required String note,
    required double total,
    required List<CartItem> products,
    required BuildContext context}) async {
    try {
      int uploadTimestamp = DateTime
          .now()
          .millisecondsSinceEpoch;
      String id = uploadTimestamp.toString();

      String? byName = await SharedPrefs.getUserNameSharedPreference();
      String? uid = await SharedPrefs.getUserIDSharedPreference();
      String? byPhone = await SharedPrefs.getUserPhoneSharedPreference();
      String? byEmail = await SharedPrefs.getUserEmailSharedPreference();

      //status = 0 => Pending
      //status = 1 => InProgress
      //status = 2 => Completed
      //status = 3 => Canceled
      //status = 4 => Declined

      await FirebaseFirestore.instance.collection('Orders').doc(id).set({
        'id': id,
        'addedByName': byName,
        'addedByUId': uid,
        'addedByPhone': byPhone,
        'addedByEmail': byEmail,
        'fullName': fullName,
        'department': department,
        'designation': designation,
        'address': address,
        'specific': specifics,
        'phone': phone,
        'status': 0,
        'note': note,
        'total': total
      }).then((value) {
        for (var model in products) {
          ProductModel details = model.productDetails;
          FirebaseFirestore.instance
              .collection('Orders')
              .doc(id)
              .collection('OrderDetails')
              .add({
            'id': id,
            'time': uploadTimestamp,
            'productId': model.productId,
            'productName': model.productName,
            'url': details.imageList.first,
            'unitPrice': model.unitPrice,
            'quantity': model.quantity,
            'subtotal': model.subTotal,
            'brandId': details.brandId,
            'brandName': details.brandName,
            'brandImg': details.brandImg,
          }).whenComplete(() {
            pushTo(context, const OrderConfirmed());
          });
        }
      });
    } catch (e) {
      pushTo(context, const OrderError());
      log(e.toString());
    }
    notifyListeners();
  }

  getAllOrders() async {
    try {
      await FirebaseFirestore.instance
          .collection('Orders')
          .get()
          .then((value) async {
        allOrders.clear();
        List<OrderModel> aOrders = [];
        List<OrderDetailsModel> aDOrder = [];
        for (int i = 0; i < value.docs.length; i++) {
          await FirebaseFirestore.instance
              .collection('Orders')
              .doc(value.docs[i].data()['id'])
              .collection('OrderDetails')
              .get()
              .then((val) {
            for (int ii = 0; ii < val.docs.length; ii++) {
              OrderDetailsModel detailsModel = OrderDetailsModel(
                  quantity: val.docs[ii].data()['quantity'],
                  brandId: val.docs[ii].data()['brandId'],
                  id: val.docs[ii].data()['id'],
                  productId: val.docs[ii].data()['productId'],
                  productName: val.docs[ii].data()['productName'],
                  subtotal: val.docs[ii].data()['subtotal'],
                  brandImg: val.docs[ii].data()['brandImg'],
                  time: val.docs[ii].data()['time'],
                  brandName: val.docs[ii].data()['brandName'],
                  unitPrice: val.docs[ii].data()['unitPrice'],
                  url: val.docs[ii].data()['url']);
              aDOrder.add(detailsModel);
            }
            OrderModel model = OrderModel(
                id: value.docs[i].data()['id'],
                addedByPhone: value.docs[i].data()['addedByPhone'],
                phone: value.docs[i].data()['phone'],
                note: value.docs[i].data()['note'],
                addedByName: value.docs[i].data()['addedByName'],
                total: value.docs[i].data()['total'].toDouble(),
                addedByEmail: value.docs[i].data()['addedByEmail'],
                address: value.docs[i].data()['address'],
                fullName: value.docs[i].data()['fullName'],
                specific: value.docs[i].data()['specific'],
                department: value.docs[i].data()['department'],
                designation: value.docs[i].data()['designation'],
                status: value.docs[i].data()['status'],
                addedByUId: value.docs[i].data()['addedByUId'],
                orderDetails: aDOrder);
            aOrders.add(model);
          });
        }
        allOrders = aOrders;
      });
    }catch(e){
      log(e.toString());
    }
    notifyListeners();
  }

  getAllOrdersOfUser() async {
    try {


      String id = (await SharedPrefs.getUserIDSharedPreference())!;

      await FirebaseFirestore.instance
          .collection('Orders')
          .get()
          .then((value) async {
        userAllOrders.clear();
        List<OrderModel> aOrders = [];
        List<OrderDetailsModel> aDOrder = [];
        for (int i = 0; i < value.docs.length; i++) {
          await FirebaseFirestore.instance
              .collection('Orders')
              .doc(value.docs[i].data()['id'])
              .collection('OrderDetails')
              .get()
              .then((val) {
            for (int ii = 0; ii < val.docs.length; ii++) {
              OrderDetailsModel detailsModel = OrderDetailsModel(
                  quantity: val.docs[ii].data()['quantity'],
                  brandId: val.docs[ii].data()['brandId'],
                  id: val.docs[ii].data()['id'],
                  productId: val.docs[ii].data()['productId'],
                  productName: val.docs[ii].data()['productName'],
                  subtotal: val.docs[ii].data()['subtotal'],
                  brandImg: val.docs[ii].data()['brandImg'],
                  time: val.docs[ii].data()['time'],
                  brandName: val.docs[ii].data()['brandName'],
                  unitPrice: val.docs[ii].data()['unitPrice'],
                  url: val.docs[ii].data()['url']);
              aDOrder.add(detailsModel);
            }
            OrderModel model = OrderModel(
                id: value.docs[i].data()['id'],
                addedByPhone: value.docs[i].data()['addedByPhone'],
                phone: value.docs[i].data()['phone'],
                note: value.docs[i].data()['note'],
                addedByName: value.docs[i].data()['addedByName'],
                total: value.docs[i].data()['total'].toDouble(),
                addedByEmail: value.docs[i].data()['addedByEmail'],
                address: value.docs[i].data()['address'],
                fullName: value.docs[i].data()['fullName'],
                specific: value.docs[i].data()['specific'],
                department: value.docs[i].data()['department'],
                designation: value.docs[i].data()['designation'],
                status: value.docs[i].data()['status'],
                addedByUId: value.docs[i].data()['addedByUId'],
                orderDetails: aDOrder);
            if(id == value.docs[i].data()['addedByUId']) {
              aOrders.add(model);
            }
          });
        }
        userAllOrders = aOrders;
      });
    }catch(e){
      log(e.toString());
    }
    notifyListeners();
  }

  getAllOrdersForRider(List list) async {
         log(list.toString());
      getAllOrders();
      await FirebaseFirestore.instance
          .collection('Orders')
          .get()
          .then((value) async {
        riderPendingOrders.clear();
        riderInProgressOrders.clear();
        riderCompletedOrders.clear();
        riderCanceledOrders.clear();
        riderDeclinedOrders.clear();
        List<OrderModel> rPendingOrders = [];
        List<OrderModel> rInProgressOrders = [];
        List<OrderModel> rCompleteOrders = [];
        List<OrderModel> rCanceledOrders = [];
        List<OrderModel> rDeclinedOrders = [];
        List<OrderDetailsModel> aDOrder = [];
        for (int i = 0; i < value.docs.length; i++) {
          await FirebaseFirestore.instance
              .collection('Orders')
              .doc(value.docs[i].data()['id'])
              .collection('OrderDetails')
              .get()
              .then((val) {
            for (int ii = 0; ii < val.docs.length; ii++) {
              OrderDetailsModel detailsModel = OrderDetailsModel(
                  quantity: val.docs[ii].data()['quantity'],
                  brandId: val.docs[ii].data()['brandId'],
                  id: val.docs[ii].data()['id'],
                  productId: val.docs[ii].data()['productId'],
                  productName: val.docs[ii].data()['productName'],
                  subtotal: val.docs[ii].data()['subtotal'],
                  brandImg: val.docs[ii].data()['brandImg'],
                  time: val.docs[ii].data()['time'],
                  brandName: val.docs[ii].data()['brandName'],
                  unitPrice: val.docs[ii].data()['unitPrice'],
                  url: val.docs[ii].data()['url']);
              log(list.contains(val.docs[ii].data()['brandId']).toString());
              if(list.contains(val.docs[ii].data()['brandId'])) {
                aDOrder.add(detailsModel);
              }
            }

            OrderModel model = OrderModel(
                id: value.docs[i].data()['id'],
                addedByPhone: value.docs[i].data()['addedByPhone'],
                phone: value.docs[i].data()['phone'],
                note: value.docs[i].data()['note'],
                addedByName: value.docs[i].data()['addedByName'],
                total: value.docs[i].data()['total'].toDouble(),
                addedByEmail: value.docs[i].data()['addedByEmail'],
                address: value.docs[i].data()['address'],
                fullName: value.docs[i].data()['fullName'],
                specific: value.docs[i].data()['specific'],
                department: value.docs[i].data()['department'],
                designation: value.docs[i].data()['designation'],
                status: value.docs[i].data()['status'],
                addedByUId: value.docs[i].data()['addedByUId'],
                orderDetails: aDOrder);
            if(value.docs[i].data()['status'] == 0){
              rPendingOrders.add(model);
            } else if(value.docs[i].data()['status'] == 1){
              rInProgressOrders.add(model);
            }else if(value.docs[i].data()['status'] == 2){
              rCompleteOrders.add(model);
            }else if(value.docs[i].data()['status'] == 3){
              rCanceledOrders.add(model);
            }else if(value.docs[i].data()['status'] == 4){
              rDeclinedOrders.add(model);
            }
          });
        }
        riderPendingOrders = rPendingOrders;
        riderInProgressOrders = rInProgressOrders;
        riderCompletedOrders = rCompleteOrders;
        riderCanceledOrders = rCanceledOrders;
        riderDeclinedOrders = rDeclinedOrders;
      });

    notifyListeners();
  }

  upDateOrderStatus(uid, status, list) async {
    await FirebaseFirestore.instance
        .collection('Orders').doc(uid).update({
      'status': status
    }).then((value) {
      getAllOrdersForRider(list);
    });
    notifyListeners();
  }

}
