import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/providers/cart_provider.dart';
import 'package:riverpod_tutorial/providers/product_provider.dart';
import 'package:riverpod_tutorial/shared/cart_icon.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allProducts = ref.watch(productsProvider);
    final cartProducts = ref.watch(cartNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade100,
        title: const Text('Garage Sale Products'),
        actions: const [CartIcon()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: allProducts.length,
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            bool isInCart =
                false; // You can determine this based on your cart state
            isInCart = cartProducts.any(
              (product) => product.id == allProducts[index].id,
            );
            return Container(
              padding: const EdgeInsets.all(20),
              color: Colors.blueGrey.withValues(alpha: 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(allProducts[index].image, height: 60),
                  const SizedBox(height: 5),
                  Text(
                    allProducts[index].title,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    '\$${allProducts[index].price}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      if (isInCart) {
                        ref
                            .read(cartNotifierProvider.notifier)
                            .removeFromCart(allProducts[index]);
                      } else {
                        ref
                            .read(cartNotifierProvider.notifier)
                            .addToCart(allProducts[index]);
                      }
                    },
                    child: Container(
                      width: 100,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isInCart ? Colors.red : Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isInCart ? 'Remove' : 'Add to Cart',
                        style: TextStyle(
                          color: isInCart ? Colors.red : Colors.blue,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
