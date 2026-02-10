import 'package:ad_e_commerce/core/constants/app_animations.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/primary_button.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_bloc.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_event.dart';
import 'package:ad_e_commerce/features/checkout/data/models/address_model.dart';
import 'package:ad_e_commerce/features/checkout/presentation/widgets/checkout_button.dart';
import 'package:ad_e_commerce/features/checkout/presentation/widgets/header_section.dart';
import 'package:ad_e_commerce/features/checkout/presentation/widgets/payment_method_section.dart';
import 'package:ad_e_commerce/features/checkout/presentation/widgets/price_details_section.dart';
import 'package:ad_e_commerce/features/checkout/presentation/widgets/product_summary_section.dart';
import 'package:ad_e_commerce/features/orders/bloc/order_bloc.dart';
import 'package:ad_e_commerce/features/orders/bloc/order_event.dart';
import 'package:ad_e_commerce/features/orders/bloc/order_state.dart';
import 'package:ad_e_commerce/features/orders/data/datasource/order_remote_datasouceimpl.dart';
import 'package:ad_e_commerce/features/orders/data/repo/order_repo_impl.dart';
import 'package:ad_e_commerce/features/orders/domain/enities/order_item.dart';
import 'package:ad_e_commerce/features/orders/domain/enities/orders.dart';
import 'package:ad_e_commerce/features/profile/data/datasource/wallet_remote_datasource_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class PaymetPage extends StatelessWidget {
  final AddressModel selectedAddress;
  const PaymetPage({super.key, required this.selectedAddress});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final orderdatasourceimpl = OrderRemoteDatasouceimpl(supabase: supabase);
    final walletRemotedatasourceimpl = WalletRemoteDatasourceImpl(supabase);
    final orderRepo = OrderRepoImpl(
      remote: orderdatasourceimpl,
      walletRemoteDataSource: walletRemotedatasourceimpl,
    );
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => OrderBloc(orderRepo))],
      child: PaymentPageUi(
        supabase: supabase,
        selectedAddress: selectedAddress,
      ),
    );
  }
}

class PaymentPageUi extends StatelessWidget {
  final AddressModel selectedAddress;
  final SupabaseClient supabase;
  const PaymentPageUi({
    super.key,
    required this.supabase,
    required this.selectedAddress,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state.status == OrdersStatus.loading) {
          showModalBottomSheet(
            backgroundColor: Colors.white,
            context: context,
            builder: (context) {
              return SizedBox(
                width: double.infinity,
                height: 327,
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Lottie.asset(
                            AppAnimations.deliverytruckloading,
                            width: 200,
                            height: 200,
                          ),
                        ),
                        const SizedBox(height: 5),
                        AppTexts.medium(
                          "Redirecting to payment page",
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        if (state.status == OrdersStatus.success) {
          // Clear Cart
          context.read<CartBloc>().add(ClearCartEvent());
          showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.white,
            context: context,
            builder: (context) {
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          repeat: false,
                          AppAnimations.successAnimation,
                          width: 200,
                          height: 200,
                        ),
                        const SizedBox(height: 5),
                        AppTexts.medium(
                          "ThankYou for shopping with Airdrop",
                          fontSize: 14,
                        ),
                        const SizedBox(height: 10),
                        PrimaryButton(
                          width: 100,
                          height: 50,
                          text: "Done",
                          onPressed: () {
                            Appnavigotor.pushNamedAndRemoveUntil(
                              context,
                              RouteNames.mainShell,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        if (state.status == OrdersStatus.failure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errormessege)));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
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
                      final cartstate = context.read<CartBloc>().state;

                      if (cartstate.cartitems.isEmpty) return;
                      final orderitems =
                          cartstate.cartitems.map((element) {
                            return OrderItem(
                              orderId: "",
                              productId: element.productId,
                              productName: element.title,
                              productImage: element.imageUrl,
                              sku: "sku1",
                              price: element.price,
                              quantity: element.quantity,
                              productStorge: element.storeage,
                              productColor: element.color,
                              productModelNumber: element.modelNumber,
                              productrating: element.rating,
                              productNoOfRating: element.noOfRating,
                            );
                          }).toList();
                      context.read<OrderBloc>().add(
                        CreateOrderEvent(
                          orders: Orders(
                            userId: supabase.auth.currentUser!.id,
                            totalAmount: cartstate.totalAmount,
                            status: "placed",
                            paymentMethod: "cod",
                            shippingAddress: selectedAddress.toJson(),
                            orderItems: [],
                            walletUsed: cartstate.walletUsed,
                          ),
                          orderitems: orderitems,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
