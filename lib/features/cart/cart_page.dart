import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: AppTexts.bold("CART")));
  }
}
