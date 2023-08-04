import 'package:TrippyAlpapp/core/classes/shopping/product.dart';

class ShoppingCart {
  static List<Cart> _cart = [];

  static List<Cart> returnProduct() {
    return _cart;
  }

  static void addNewProduct(ShoppingProduct shoppingProduct, int value) {
    _cart.add(Cart(shoppingProduct: shoppingProduct, orderCount: value));
  }

  static bool deleteProductonCart(ShoppingProduct shoppingProduct) {
    return true;
  }
}

class Cart {
  final ShoppingProduct shoppingProduct;
  final int orderCount;

  Cart({required this.shoppingProduct, required this.orderCount});
}
