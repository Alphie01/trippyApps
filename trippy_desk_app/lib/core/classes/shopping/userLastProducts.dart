import 'package:trippy_desk_app/core/classes/shopping/product.dart';

class UserLastProducts {
  static List<ShoppingProduct> _listProducts = [];

  static void addNewLastSeen(ShoppingProduct shoppingProduct) {
    if (_listProducts.contains(shoppingProduct) == false) {
      _listProducts.add(shoppingProduct);
    }
  }

  static List<ShoppingProduct> returnList() {
    return _listProducts;
  }
}
