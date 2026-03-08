import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/utils/helpers.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_bloc.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_event.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartSummaryWidget extends StatelessWidget {
  const CartSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final subTotal = state.subTotal;
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
              GestureDetector(
                onTap: () {
                  _showWalletBottomSheet(context, state);
                },
                child: _buildSummaryRow(
                  "Wallet",
                  state.walletUsed > 0
                      ? "- ${_formatMoney(state.walletUsed)}"
                      : "Add",
                  isBold: false,
                ),
              ),
              const SizedBox(height: 8),
              _buildSummaryRow("Delivery Fee", "Free", isBold: false),
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
                            final user =
                                Supabase.instance.client.auth.currentUser;
                            user == null
                                ? Helpers.showAuthBottomSheet(
                                  context,
                                  redirectRoute: RouteNames.mainShell,
                                  redirectArgs: {"index": 2},
                                )
                                : Appnavigotor.pushnamed(
                                  context,
                                  RouteNames.checkout,
                                  {
                                    "isMyaddressScreen": false,
                                    "isDirectBuy": false,
                                    "directProduct": null,
                                  },
                                );
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlack,
                    disabledBackgroundColor: AppColors.primaryBlack.withOpacity(
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

    return "INR $result";
  }
}

void _showWalletBottomSheet(BuildContext context, CartState state) {
  final TextEditingController controller = TextEditingController(
    text: state.walletUsed > 0 ? state.walletUsed.toString() : "",
  );

  showModalBottomSheet(
    backgroundColor: AppColors.pureWhite,
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) {
      String? errorText;
      double enteredAmount = 0;

      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Title
                AppTexts.bold("Apply Wallet", fontSize: 18),

                const SizedBox(height: 8),

                // 🔹 Available balance
                AppTexts.regular(
                  "Available Balance: INR ${state.walletBalance}",
                  color: Colors.green,
                ),

                const SizedBox(height: 16),

                // 🔹 Input
                TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    enteredAmount = double.tryParse(value) ?? 0;

                    if (enteredAmount > state.walletBalance) {
                      errorText = "Amount exceeds wallet balance";
                    } else if (enteredAmount > state.subTotal) {
                      errorText = "Amount exceeds cart total";
                    } else {
                      errorText = null;
                    }

                    setState(() {});
                  },
                  decoration: InputDecoration(
                    hintText: "Enter wallet amount",
                    errorText: errorText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 🔹 Apply Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed:
                        errorText != null || enteredAmount <= 0
                            ? null
                            : () {
                              context.read<CartBloc>().add(
                                ApplyWalletEvent(enteredAmount),
                              );

                              Navigator.pop(context);
                            },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlack,
                      disabledBackgroundColor: AppColors.primaryBlack
                          .withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: AppTexts.semiBold(
                      "Apply Wallet",
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(height: 8),
              ],
            ),
          );
        },
      );
    },
  );
}
