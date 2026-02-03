import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_bloc.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartSummaryWidget extends StatelessWidget {
  const CartSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final subTotal = state.subTotal;
        final voucher = state.voucherAmount;
        final delivery = state.deliveryFee;
        final total = state.totalAmount;
        final isCartEmpty = state.cartitems.isEmpty;

        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSummaryRow(
                "Sub-total",
                _formatMoney(subTotal),
                isBold: false,
              ),
              const SizedBox(height: 8),
              // Show voucher as negative value if applied
              _buildSummaryRow(
                "Voucher",
                voucher > 0 ? "-${_formatMoney(voucher)}" : "RM 0",
                isBold: false,
              ),
              const SizedBox(height: 8),
              _buildSummaryRow(
                "Delivery Fee",
                _formatMoney(delivery),
                isBold: false,
              ),
              const SizedBox(height: 16),
              const Divider(color: AppColors.lightGrey, thickness: 1),
              const SizedBox(height: 16),
              _buildSummaryRow("Total", _formatMoney(total), isBold: true),
              const SizedBox(height: 24),

              // Checkout Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed:
                      isCartEmpty
                          ? null
                          : () {
                            Appnavigotor.pushnamed(
                              context,
                              RouteNames.checkout,
                              {"isMyaddressScreen": false},
                            );
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    disabledBackgroundColor: AppColors.primaryBlue.withOpacity(
                      0.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: AppTexts.semiBold(
                    "Checkout ${_formatMoney(total)}",
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryRow(String label, String value, {required bool isBold}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppTexts.regular(
          label,
          fontSize: isBold ? 16 : 14,
          color: isBold ? Colors.black : AppColors.grayColor,
        ),
        isBold
            ? AppTexts.bold(value, fontSize: 16)
            : AppTexts.semiBold(value, fontSize: 14),
      ],
    );
  }

  String _formatMoney(double amount) {
    // Basic formatting: RM 1,000. No decimal places if usually integer-like,
    // but typically safe to show 2 decimals or 0 if user context implies integer amounts mostly.
    // Given the example "RM 2,600", "RM 20", I will strip decimals if .00
    // And add commas.

    String priceString = amount.toStringAsFixed(2);
    // Remove .00 if exists
    if (priceString.endsWith(".00")) {
      priceString = priceString.substring(0, priceString.length - 3);
    }

    // Add commas
    final RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc(Match match) => '${match[1]},';
    final String result = priceString.replaceAllMapped(reg, mathFunc);

    return "RM $result";
  }
}
