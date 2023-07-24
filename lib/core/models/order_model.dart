class OrderModel {
  String id;
  String addedByPhone;
  String phone;
  String note;
  String addedByName;
  double total;
  String addedByEmail;
  String address;
  String fullName;
  String specific;
  String department;
  String designation;
  int status;
  String addedByUId;
  List<OrderDetailsModel> orderDetails;

  OrderModel({
    required this.id,
    required this.addedByPhone,
    required this.phone,
    required this.note,
    required this.addedByName,
    required this.total,
    required this.addedByEmail,
    required this.address,
    required this.fullName,
    required this.specific,
    required this.department,
    required this.designation,
    required this.status,
    required this.addedByUId,
    required this.orderDetails,
  });
}

class OrderDetailsModel {
  int quantity;
  String brandId;
  String id;
  int productId;
  String productName;
  double subtotal;
  String brandImg;
  int time;
  String brandName;
  double unitPrice;
  String url;

  OrderDetailsModel({
    required this.quantity,
    required this.brandId,
    required this.id,
    required this.productId,
    required this.productName,
    required this.subtotal,
    required this.brandImg,
    required this.time,
    required this.brandName,
    required this.unitPrice,
    required this.url,
  });
}
