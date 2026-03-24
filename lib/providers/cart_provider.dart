import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/models/product.dart';

class CartNotifier extends Notifier<Set<Product>> {
  @override
  Set<Product> build() {
    return {
      Product(
        id: '4',
        title: 'Red backpack',
        price: 14,
        image: "assets/products/backpack.png",
      ),
    };
  }

  void addToCart(Product product) {
    if (!state.contains(product)) {
      state = {...state, product};
    }
  }

  void removeFromCart(Product product) {
    if (state.contains(product)) {
      state = state.where((p) => p.id != product.id).toSet();
    }
  }
}

final cartNotifierProvider = NotifierProvider<CartNotifier, Set<Product>>(() {
  return CartNotifier();
});
