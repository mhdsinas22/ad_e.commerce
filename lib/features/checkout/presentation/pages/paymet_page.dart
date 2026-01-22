import 'package:ad_e_commerce/features/checkout/presentation/widgets/checkout_button.dart';
import 'package:ad_e_commerce/features/checkout/presentation/widgets/header_section.dart';
import 'package:ad_e_commerce/features/checkout/presentation/widgets/payment_method_section.dart';
import 'package:ad_e_commerce/features/checkout/presentation/widgets/price_details_section.dart';
import 'package:ad_e_commerce/features/checkout/presentation/widgets/product_summary_section.dart';
import 'package:flutter/material.dart';

class PaymetPage extends StatelessWidget {
  const PaymetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const HeaderSection(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const PaymentMethodSection(),
                    const ProductSummarySection(),
                    const PriceDetailsSection(),
                  ],
                ),
              ),
            ),
            CheckoutButton(
              text: 'Proceed to Checkout',
              onTap: () {
                print("Checkout Initiated");
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
