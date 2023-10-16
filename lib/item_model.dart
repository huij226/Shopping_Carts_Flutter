import 'package:flutter/material.dart';

class Item {
  late final int? id;
  final String? productId;
  final String? productName;
  final int? productPrice;
  final ValueNotifier<int>? quantity;
  final String? unitTag;
  final String? image;

  Item(
      {required this.id,
      required this.productId,
      required this.productName,
      required this.productPrice,
      required this.quantity,
      required this.unitTag,
      required this.image});

  Item.fromMap(Map<dynamic, dynamic> data)
      : id = data['id'],
        productId = data['productId'],
        productName = data['productName'],
        productPrice = data['productPrice'],
        quantity = ValueNotifier(data['quantity']),
        unitTag = data['unitTag'],
        image = data['image'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity?.value,
      'unitTag': unitTag,
      'image': image,
    };
  }

  Map<String, dynamic> quantityMap() {
    return {
      'productId': productId,
      'quantity': quantity!.value,
    };
  }
}
