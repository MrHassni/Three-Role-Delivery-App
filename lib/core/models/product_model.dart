class ProductModel {
  final int id;
  final String brandId;
  final String brandName;
  final String brandImg;
  final String name;
  final List imageList;
  final double price;
  final String description;

  ProductModel({
    required  this.brandId,
    required  this.brandName,
    required this.id,
    required this.name,
    required this.imageList,
    required this.price,
    required this.description,
    required this.brandImg,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      imageList: json['images'],
      price: json['price'],
      description: json['description'],
      brandId: json['brandId'],
      brandName: json['brandName'],
      brandImg: json['brandImg'],
    );
  }
}

class BrandModel {
  final String id;
  final String name;
  final String img;

  BrandModel({
    required this.id,
    required this.name,
    required this.img,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'],
      name: json['name'],
      img: json['img'],
    );
  }
}

