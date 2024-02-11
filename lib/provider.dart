import 'package:flutter/material.dart';

class ImageHistory extends ChangeNotifier {
  List<String> history = [];

  void addImage(String imageUrl) {
    history.add(imageUrl);
    notifyListeners();
  }
}

class Cart extends ChangeNotifier {
  List<CartImage> images = [];

  void addImage(CartImage item) {
    images.add(item);
    notifyListeners();
  }
}

class CartImage {
  final String imageUrl;
  final int amount;

  CartImage({required this.imageUrl, required this.amount});
}