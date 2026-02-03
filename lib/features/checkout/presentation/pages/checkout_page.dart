import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/features/checkout/bloc/address/address_bloc.dart';
import 'package:ad_e_commerce/features/checkout/bloc/address/address_event.dart';
import 'package:ad_e_commerce/features/checkout/bloc/address/address_state.dart';
import 'package:ad_e_commerce/features/checkout/data/models/address_model.dart';
import 'package:ad_e_commerce/features/orders/bloc/order_bloc.dart';
import 'package:ad_e_commerce/features/orders/bloc/order_event.dart';
import 'package:ad_e_commerce/features/orders/bloc/order_state.dart';
import 'package:ad_e_commerce/features/orders/data/datasource/order_remote_datasouceimpl.dart';
import 'package:ad_e_commerce/features/orders/data/repo/order_repo_impl.dart';
import 'package:ad_e_commerce/features/orders/domain/enities/order_item.dart';
import 'package:ad_e_commerce/features/orders/domain/enities/orders.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/header_section.dart';
import '../widgets/address_section.dart';
import '../widgets/checkout_button.dart';

class CheckoutPage extends StatefulWidget {
  final bool isMyaddressScreen;
  const CheckoutPage({super.key, this.isMyaddressScreen = false});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final pincodeController = TextEditingController();
  final houseController = TextEditingController();
  final localityController = TextEditingController();
  final landmarkController = TextEditingController();
  final emailController = TextEditingController();
  final alternateNumberController = TextEditingController();
  String _selectedSaveAs = "home";
  int _selectedAddressIndex =
      0; // Default to 'Add New' (index 2 based on previous logic)

  bool get _isFormValid {
    final addresses = context.read<AddressBloc>().state.addresses;
    final addNewIndex = addresses.length;

    // No saved addresses → must validate form
    if (addresses.isEmpty) {
      return _isNewAddressValid();
    }

    // Existing address selected → VALID
    if (_selectedAddressIndex != addNewIndex) {
      return true;
    }

    // Add new selected → validate form
    return _isNewAddressValid();
  }

  bool _isNewAddressValid() {
    if (pincodeController.text.length != 6) return false;
    if (houseController.text.trim().isEmpty) return false;
    if (!emailController.text.contains('@')) return false;
    return true;
  }

  void _onFormChanged() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    context.read<AddressBloc>().add(FetchAddressEvent());

    // Add listeners for validation
    pincodeController.addListener(_onFormChanged);
    houseController.addListener(_onFormChanged);
    localityController.addListener(_onFormChanged);
    landmarkController.addListener(_onFormChanged);
    emailController.addListener(_onFormChanged);
    alternateNumberController.addListener(_onFormChanged);
  }

  @override
  void dispose() {
    pincodeController.dispose();
    houseController.dispose();
    localityController.dispose();
    landmarkController.dispose();
    emailController.dispose();
    alternateNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final orderdatasourceimpl = OrderRemoteDatasouceimpl(supabase: supabase);
    final orderRepo = OrderRepoImpl(remote: orderdatasourceimpl);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const HeaderSection(),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: BlocBuilder<AddressBloc, AddressState>(
                      builder: (context, state) {
                        if (state.addresses.isEmpty) {
                          print("empty");
                        }
                        return AddressSection(
                          addresses: state.addresses,
                          pincodeController: pincodeController,
                          emailController: emailController,
                          houseController: houseController,
                          alternateNumberController: alternateNumberController,
                          landmarkController: landmarkController,
                          localityController: localityController,
                          selectedSaveAs: _selectedSaveAs,
                          onSaveAsChanged: (value) {
                            setState(() {
                              _selectedSaveAs = value;
                            });
                          },
                          selectedAddressIndex: _selectedAddressIndex,
                          onAddressSelected: (index) {
                            setState(() {
                              _selectedAddressIndex = index;
                            });
                          },
                        );
                      },
                    ),
                  ),
                  BlocBuilder<AddressBloc, AddressState>(
                    builder: (context, state) {
                      return CheckoutButton(
                        text: widget.isMyaddressScreen ? "ADD" : 'Next',
                        isEnabled: _isFormValid,
                        onTap: () {
                          final addresses =
                              context.read<AddressBloc>().state.addresses;
                          final addNewIndex = addresses.length;

                          // 🟢 Existing address selected
                          if (_selectedAddressIndex != addNewIndex) {
                            if (!widget.isMyaddressScreen) {
                              Appnavigotor.pushnamed(
                                context,
                                RouteNames.paymentpage,
                                [],
                              );
                            } else {
                              Appnavigotor.pop(context);
                            }

                            return;
                          }

                          // 🟡 Add new selected → submit address
                          final userid =
                              Supabase.instance.client.auth.currentUser!.id;

                          final address = AddressModel(
                            userid: userid,
                            pincode: pincodeController.text.trim(),
                            house: houseController.text.trim(),
                            area: localityController.text.trim(),
                            landmark: landmarkController.text.trim(),
                            email: emailController.text.trim(),
                            alternatePhone:
                                alternateNumberController.text.trim(),
                            saveAs: _selectedSaveAs.toLowerCase(),
                          );

                          context.read<AddressBloc>().add(
                            SubmitAddressEvent(address),
                          );
                          if (widget.isMyaddressScreen) {
                            Appnavigotor.pop(context);
                          } else {
                            Appnavigotor.pushnamed(
                              context,
                              RouteNames.paymentpage,
                              [],
                            );
                          }
                        },
                      );
                    },
                  ),

                  BlocProvider(
                    create: (context) => OrderBloc(orderRepo),
                    child: BlocBuilder<OrderBloc, OrderState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            final userId = supabase.auth.currentUser!.id;

                            context.read<OrderBloc>().add(
                              CreateOrderEvent(
                                orders: Orders(
                                  userId: userId,
                                  totalAmount: 500,
                                  status: "placed",
                                  paymentMethod: "cod",
                                  shippingAddress: {"address": "test"},
                                ),
                                orderitems: [
                                  OrderItem(
                                    orderId: "",
                                    productId:
                                        "01562d49-75e2-4b92-9201-707b12bc67c6",
                                    productName: "Test Product",
                                    productImage: "",
                                    sku: "sku1",
                                    price: 500,
                                    quantity: 1,
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Text("ORDER"),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
