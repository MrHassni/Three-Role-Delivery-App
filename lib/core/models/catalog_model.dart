import 'package:delivery_app/core/models/product_model.dart';

class CatalogModel {
  static List<ProductModel> products = [
    ProductModel(
        id: 1,
        brandId: '1',
        name: "Egg Salad",
        brandName: "Mcdonald's",
        imageList: ["im2", 'im2', 'im2'],
        price: 5.00,
        brandImg: '',
        description: "Egg Salad Description"),
    ProductModel(
        id: 3,
        name: "Fried Egg Salmon",
        imageList: ["ob0", "ob0", "ob0"],
        price: 10.00,
        description: "Fried Egg Salmon Description",
      brandId: '1',
      brandImg: '',
      brandName: "Mcdonald's",
    ),
    ProductModel(
        id: 2,
        name: "Grilled Salmon",
        imageList: ["im1", "im1", "im1"],
        price: 15.00,
        description: "Grilled Salmon Description",
      brandId: '2',
      brandImg: '',
      brandName: "KFC",),

  ];


  ProductModel getById(int id) {
    return products.singleWhere((element) => element.id == id);
  }

  /// Get item by its position in the catalog.
  ProductModel getByPosition(int position) {
    return products.elementAt(position);
  }
}