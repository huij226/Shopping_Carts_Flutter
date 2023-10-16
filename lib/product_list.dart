import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carts/cart_model.dart';
import 'package:carts/cart_provider.dart';
import 'package:carts/db_helper.dart';
import 'package:carts/cart_screen.dart';
import 'package:logger/logger.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    super.initState();
    context.read<CartProvider>().getData();
  }

  DBHelper dbHelper = DBHelper();
  var logger = Logger();

  List<Cart> products = [
    Cart(
      id: 1,
      productId: '1001',
      productName: 'USB-C (2m) - 200W',
      productPrice: 99,
      quantity: ValueNotifier(1),
      image: 'assets/images/USB-C (2m).png',
    ),
    Cart(
      id: 2,
      productId: '1002',
      productName: 'USB (1m) - 150W',
      productPrice: 50,
      quantity: ValueNotifier(1),
      image: 'assets/images/USB (1m) - 150W.png',
    ),
    Cart(
      id: 3,
      productId: '1003',
      productName: 'Type C 50W Adapter',
      productPrice: 99,
      quantity: ValueNotifier(1),
      image: 'assets/images/Type C 50W Adapter.png',
    ),
    Cart(
      id: 4,
      productId: '1004',
      productName: 'Wallet with MagSafe',
      productPrice: 279,
      quantity: ValueNotifier(1),
      image: 'assets/images/Wallet with MagSafe.png',
    ),
    Cart(
      id: 5,
      productId: '1005',
      productName: 'MagSafe Charger',
      productPrice: 219,
      quantity: ValueNotifier(1),
      image: 'assets/images/MagSafe Charger.png',
    ),
    Cart(
      id: 6,
      productId: '1006',
      productName: 'USB-C Adapter',
      productPrice: 219,
      quantity: ValueNotifier(1),
      image: 'assets/images/USB-C Lightning Adapter.png',
    ),
    Cart(
      id: 7,
      productId: '1007',
      productName: 'MagSafe Duo Charger',
      productPrice: 589,
      quantity: ValueNotifier(1),
      image: 'assets/images/MagSafe Duo Charger.png',
    )
  ];

  @override
  Widget build(BuildContext context) {
    void saveData(int index) {
      dbHelper.insert(
        Cart(
          id: index,
          productId: index.toString(),
          productName: products[index].productName,
          productPrice: products[index].productPrice,
          quantity: ValueNotifier(1),
          image: products[index].image,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Added Successfully'),
          duration: Duration(seconds: 1),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Products'),
        actions: [
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: 30, end: 30),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        shrinkWrap: true,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.blueGrey.shade200,
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image(
                    height: 80,
                    width: 80,
                    image: AssetImage(products[index].image.toString()),
                  ),
                  SizedBox(
                    width: 130,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5.0,
                        ),
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.blueGrey.shade800,
                              fontSize: 13.0,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    '${products[index].productName.toString()}\n',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          maxLines: 1,
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.blueGrey.shade800,
                              fontSize: 13.0,
                            ),
                            children: const [
                              TextSpan(
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          maxLines: 1,
                          text: TextSpan(
                            text: r"RM",
                            style: TextStyle(
                              color: Colors.blueGrey.shade800,
                              fontSize: 13.0,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    '${products[index].productPrice.toString()}\n',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade900,
                    ),
                    onPressed: () {
                      saveData(index);
                    },
                    child: const Text('Add to Cart'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
