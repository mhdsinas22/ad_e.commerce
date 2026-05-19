import 'package:aerstore/core/constants/app_animations.dart';
import 'package:aerstore/core/routes/route_names.dart';
import 'package:aerstore/core/theme/app_colors.dart';
import 'package:aerstore/core/widgets/app_text.dart';
import 'package:aerstore/core/widgets/primary_button.dart';
import 'package:aerstore/features/cart/bloc/cart_bloc.dart';
import 'package:aerstore/features/cart/bloc/cart_event.dart';
import 'package:aerstore/features/checkout/bloc/address/address_bloc.dart';
import 'package:aerstore/features/checkout/bloc/address/address_event.dart';
import 'package:aerstore/features/checkout/bloc/address/address_state.dart';
import 'package:aerstore/features/checkout/data/models/address_model.dart';
import 'package:aerstore/features/orders/bloc/order_bloc.dart';
import 'package:aerstore/features/orders/bloc/order_event.dart';
import 'package:aerstore/features/orders/bloc/order_state.dart';
import 'package:aerstore/features/orders/data/datasource/order_remote_datasouceimpl.dart';
import 'package:aerstore/features/orders/data/repo/order_repo_impl.dart';
import 'package:aerstore/features/orders/domain/enities/order_item.dart';
import 'package:aerstore/features/orders/domain/enities/orders.dart';
import 'package:aerstore/features/payment/data/datasource/razorpay_datasource_impl.dart';
import 'package:aerstore/features/payment/data/repo/payment_repository_impl.dart';
import 'package:aerstore/features/payment/domain/usecase/make_payment.dart';
import 'package:aerstore/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:aerstore/features/payment/presentation/bloc/payment_event.dart';
import 'package:aerstore/features/payment/presentation/bloc/payment_state.dart';
import 'package:aerstore/features/product/bloc/proudctbloc/product_bloc.dart';
import 'package:aerstore/features/product/bloc/proudctbloc/product_event.dart';
import 'package:aerstore/features/product/domain/entites/product.dart';
import 'package:aerstore/features/profile/data/datasource/wallet_remote_datasource_impl.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/header_section.dart';
import '../widgets/address_section.dart';
import '../widgets/checkout_button.dart';

class CheckoutPage extends StatelessWidget {
  final bool isMyaddressScreen;
  final bool isDirectBuy;
  final Product? directProduct;
  const CheckoutPage({
    super.key,
    this.isMyaddressScreen = false,
    this.isDirectBuy = false,
    this.directProduct,
  });

  @override
  Widget build(BuildContext context) {
    final RazorpayDatasourceImpl razorpayDatasourceImpl =
        RazorpayDatasourceImpl();
    final PaymentRepositoryImpl paymentRepositoryImpl = PaymentRepositoryImpl(
      datasource: razorpayDatasourceImpl,
    );
    final supabase = Supabase.instance.client;
    final orderdatasourceimpl = OrderRemoteDatasouceimpl(supabase: supabase);
    final MakePayment makePayment = MakePayment(paymentRepositoryImpl);
    final walletRemotedatasourceimpl = WalletRemoteDatasourceImpl(supabase);
    final orderRepo = OrderRepoImpl(
      remote: orderdatasourceimpl,
      walletRemoteDataSource: walletRemotedatasourceimpl,
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OrderBloc(orderRepo)),
        BlocProvider(
          create: (context) => PaymentBloc(makePayment: makePayment),
        ),
      ],
      child: CheckoutPageUi(
        isMyaddressScreen: isMyaddressScreen,
        isDirectBuy: isDirectBuy,
        directProduct: directProduct,
        supabase: supabase,
      ),
    );
  }
}

class CheckoutPageUi extends StatefulWidget {
  final SupabaseClient supabase;
  final bool isMyaddressScreen;
  final bool isDirectBuy;
  final Product? directProduct;
  const CheckoutPageUi({
    super.key,
    this.isMyaddressScreen = false,
    this.isDirectBuy = false,
    this.directProduct,
    required this.supabase,
  });

  @override
  State<CheckoutPageUi> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPageUi> {
  bool _shouldTriggerPayment = false;
  final pincodeController = TextEditingController();
  final houseController = TextEditingController();
  final localityController = TextEditingController();
  final landmarkController = TextEditingController();
  final emailController = TextEditingController();
  final alternateNumberController = TextEditingController();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();

  String _selectedSaveAs = "home";
  String? _selectedState;
  String? _selectedDistrict;
  bool _isEditingAddress = false;
  bool get _isFormValid {
    final addresses = context.read<AddressBloc>().state.addresses;
    final selectedAddressIndex =
        context.read<AddressBloc>().state.selectedAddressIndex;
    final addNewIndex = addresses.length;

    // No saved addresses → must validate form
    if (addresses.isEmpty) {
      return _isNewAddressValid();
    }

    // Existing address selected → VALID
    if (selectedAddressIndex != addNewIndex) {
      return true;
    }

    // Add new selected → validate form
    return _isNewAddressValid();
  }

  bool _isNewAddressValid() {
    if (nameController.text.trim().isEmpty) return false;
    if (mobileController.text.trim().length != 10) return false;
    if (_selectedState == null || _selectedDistrict == null) return false;
    if (pincodeController.text.length != 6) return false;
    if (houseController.text.trim().isEmpty) return false;
    if (!emailController.text.contains('@')) return false;
    return true;
  }

  void _onFormChanged() {
    setState(() {});
  }

  int _getPaymentAmountInPaise() {
    double amount = 0;

    if (widget.isDirectBuy && widget.directProduct != null) {
      amount = widget.directProduct!.price;
    } else {
      amount = context.read<CartBloc>().state.totalAmount;
    }

    return (amount * 100).toInt(); // ₹ → paise
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
    nameController.addListener(_onFormChanged);
    mobileController.addListener(_onFormChanged);
  }

  @override
  void dispose() {
    pincodeController.dispose();
    houseController.dispose();
    localityController.dispose();
    landmarkController.dispose();
    emailController.dispose();
    alternateNumberController.dispose();
    nameController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PaymentBloc, PaymentState>(
          listener: (context, state) {
            final addresses = context.read<AddressBloc>().state.addresses;
            final selectedAddressIndex =
                context.read<AddressBloc>().state.selectedAddressIndex;
            final addNewIndex = addresses.length;

            AddressModel? selectedAddress;
            if (selectedAddressIndex != addNewIndex &&
                selectedAddressIndex >= 0 &&
                selectedAddressIndex < addresses.length) {
              selectedAddress = AddressModel.fromEntity(
                addresses[selectedAddressIndex],
              );
            }
            if (state.status == PaymentStatus.success) {
              final cartstate = context.read<CartBloc>().state;
              if (selectedAddress == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please select address")),
                );
                return;
              }
              if (widget.isDirectBuy && widget.directProduct != null) {
                final orderItem = OrderItem(
                  orderId: "",
                  productId: widget.directProduct!.id!,
                  productName: widget.directProduct!.title,
                  productImage:
                      widget.directProduct!.imageUrls.isEmpty
                          ? widget.directProduct!.imageUrls[0]
                          : "",
                  sku: "sku1",
                  price: widget.directProduct!.price,
                  quantity: 1,
                  productStorge: widget.directProduct!.storage,
                  productColor: widget.directProduct!.color, // if available
                  productModelNumber: widget.directProduct!.modelNumber,
                  productrating: widget.directProduct!.rating.toString(),
                  productNoOfRating:
                      widget.directProduct!.noofreviews.toString(),
                );

                context.read<OrderBloc>().add(
                  CreateOrderEvent(
                    orders: Orders(
                      userId: widget.supabase.auth.currentUser!.id,
                      totalAmount: widget.directProduct!.price,
                      status: "placed",
                      paymentMethod: "online",
                      shippingAddress: selectedAddress.toJson(),
                      orderItems: [],
                      walletUsed: 0,
                    ),
                    orderitems: [orderItem],
                  ),
                );
              } else {
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
                      userId: widget.supabase.auth.currentUser!.id,
                      totalAmount: cartstate.totalAmount,
                      status: "placed",
                      paymentMethod: "online",
                      shippingAddress: selectedAddress.toJson(),
                      orderItems: [],
                      walletUsed: cartstate.walletUsed,
                    ),
                    orderitems: orderitems,
                  ),
                );
              }
            }
            // ❌ FAILURE
            if (state.status == PaymentStatus.failed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage ?? "Payment Failed")),
              );
            }
          },
        ),
        BlocListener<OrderBloc, OrderState>(
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
              context.read<ProductBloc>().add(LoadProductsEvent());
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
                              "ThankYou for shopping with Aer",
                              fontSize: 14,
                            ),
                            const SizedBox(height: 10),
                            PrimaryButton(
                              fontsize: 16,
                              width: 100,
                              height: 30,
                              text: "Done",
                              onPressed: () {
                                context.goNamed(RouteNames.mainShell);
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
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              const HeaderSection(),
              Expanded(
                child: BlocBuilder<AddressBloc, AddressState>(
                  builder: (context, state) {
                    return AddressSection(
                      isEdit: widget.isMyaddressScreen,
                      addresses: state.addresses,
                      pincodeController: pincodeController,
                      emailController: emailController,
                      houseController: houseController,
                      alternateNumberController: alternateNumberController,
                      landmarkController: landmarkController,
                      localityController: localityController,
                      nameController: nameController,
                      mobileController: mobileController,
                      selectedSaveAs: _selectedSaveAs,
                      selectedState: _selectedState,
                      selectedDistrict: _selectedDistrict,
                      isEditingAddress: _isEditingAddress,
                      onSaveAsChanged: (value) {
                        setState(() {
                          _selectedSaveAs = value;
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          _selectedState = value;
                          _selectedDistrict = null; // Reset district
                        });
                      },
                      onDistrictChanged: (value) {
                        setState(() {
                          _selectedDistrict = value;
                        });
                      },
                      selectedAddressIndex:
                          state.selectedAddressIndex < 0
                              ? 0
                              : state.selectedAddressIndex,
                      onAddressSelected: (index) {
                        final addresses = state.addresses;
                        final addNewIndex = addresses.length;

                        context.read<AddressBloc>().add(
                          SelectAddressEvent(index),
                        );

                        setState(() {
                          if (index == addNewIndex) {
                            // Add New
                            _isEditingAddress = true;

                            pincodeController.clear();
                            houseController.clear();
                            localityController.clear();
                            landmarkController.clear();
                            emailController.clear();
                            alternateNumberController.clear();
                            nameController.clear();
                            mobileController.clear();
                            _selectedState = null;
                            _selectedDistrict = null;
                            _selectedSaveAs = "home";
                          } else {
                            // Existing address
                            _isEditingAddress = false;
                          }
                        });
                      },
                      onEditAddress: (address, index) {
                        setState(() {
                          pincodeController.text = address.pincode;
                          houseController.text = address.house;
                          localityController.text = address.area;
                          landmarkController.text = address.landmark ?? '';
                          emailController.text = address.email;
                          alternateNumberController.text =
                              address.alternatePhone ?? '';
                          nameController.text = address.name;
                          mobileController.text = address.mobileNumber;
                          _selectedState = address.state;
                          _selectedDistrict = address.district;
                          _selectedSaveAs = address.saveAs;
                          _isEditingAddress = true;
                        });
                        context.read<AddressBloc>().add(
                          SelectAddressEvent(index),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BlocListener<AddressBloc, AddressState>(
          listenWhen:
              (previous, current) => previous.addresses != current.addresses,
          listener: (context, state) {
            if (state.status == AddressStatus.success &&
                _shouldTriggerPayment) {
              _shouldTriggerPayment = false;
              final amountInPaise = _getPaymentAmountInPaise();
              context.read<PaymentBloc>().add(
                StartPayment(amount: amountInPaise),
              );
            }
          },
          child: BlocBuilder<AddressBloc, AddressState>(
            builder: (context, state) {
              return SafeArea(
                child:
                    widget.isMyaddressScreen
                        ? Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Spacer(),
                              PrimaryButton(
                                borderRadius: 10,
                                width: 112,
                                height: 45,
                                backgroudColor: AppColors.purered,
                                onPressed: () => _deleteAddress(state),
                                text: "Delete",
                              ),
                              const SizedBox(width: 12),
                              PrimaryButton(
                                borderRadius: 10,
                                width: 112,
                                height: 45,
                                text: "Save",
                                onPressed:
                                    _isFormValid
                                        ? () => _saveAddress(state)
                                        : null,
                              ),
                              const Spacer(),
                            ],
                          ),
                        )
                        : CheckoutButton(
                          text: 'Next',
                          isEnabled: _isFormValid,
                          onTap: () => _onNextPressed(state),
                        ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _submitNewAddress(AddressState state, {required bool goToPayment}) {
    final userid = Supabase.instance.client.auth.currentUser!.id;

    final address = AddressModel(
      userid: userid,
      pincode: pincodeController.text.trim(),
      house: houseController.text.trim(),
      area: localityController.text.trim(),
      landmark: landmarkController.text.trim(),
      email: emailController.text.trim(),
      alternatePhone: alternateNumberController.text.trim(),
      saveAs: _selectedSaveAs.toLowerCase(),
      name: nameController.text.trim(),
      mobileNumber: mobileController.text.trim(),
      state: _selectedState!,
      district: _selectedDistrict!,
    );

    context.read<AddressBloc>().add(SubmitAddressEvent(address));

    if (!goToPayment) {
      context.pop(); // back to My Address list
    }
  }

  void _onNextPressed(AddressState state) {
    final addresses = state.addresses;
    final selectedAddressIndex = state.selectedAddressIndex;
    final addNewIndex = addresses.length;

    final cartstate = context.read<CartBloc>().state;
    // ACTUAL AMOUNT CALCULATION (cart Or Direct Buy)
    double amoutToPay = 0;
    if (widget.isDirectBuy && widget.directProduct != null) {
      amoutToPay = widget.directProduct!.price;
    } else {
      amoutToPay = cartstate.totalAmount;
    }

    // ✅ NEW ADDRESS FLOW
    if (selectedAddressIndex == addNewIndex) {
      final shouldPayOnline = amoutToPay > 0;

      _shouldTriggerPayment = shouldPayOnline;

      _submitNewAddress(state, goToPayment: shouldPayOnline);

      return;
    }

    // ✅ SAFETY CHECK
    if (selectedAddressIndex >= addresses.length || selectedAddressIndex < 0) {
      return;
    }

    // ✅ WALLET FULL PAYMENT
    if (amoutToPay <= 0) {
      _createOrderDirect();
      return;
    }

    // ✅ ONLINE PAYMENT
    final amountInPaise = _getPaymentAmountInPaise();

    context.read<PaymentBloc>().add(StartPayment(amount: amountInPaise));
  }

  void _createOrderDirect() {
    final cartstate = context.read<CartBloc>().state;
    final addresses = context.read<AddressBloc>().state.addresses;
    final selectedAddressIndex =
        context.read<AddressBloc>().state.selectedAddressIndex;
    final addNewIndex = addresses.length;

    AddressModel? selectedAddress;

    if (selectedAddressIndex != addNewIndex &&
        selectedAddressIndex >= 0 &&
        selectedAddressIndex < addresses.length) {
      selectedAddress = AddressModel.fromEntity(
        addresses[selectedAddressIndex],
      );
    }

    if (selectedAddress == null) return;

    if (widget.isDirectBuy && widget.directProduct != null) {
      final orderItem = OrderItem(
        orderId: "",
        productId: widget.directProduct!.id!,
        productName: widget.directProduct!.title,
        productImage: widget.directProduct!.imageUrls[0],
        sku: "sku1",
        price: widget.directProduct!.price,
        quantity: 1,
        productStorge: widget.directProduct!.storage,
        productColor: widget.directProduct!.color,
        productModelNumber: widget.directProduct!.modelNumber,
        productrating: widget.directProduct!.rating.toString(),
        productNoOfRating: widget.directProduct!.noofreviews.toString(),
      );

      context.read<OrderBloc>().add(
        CreateOrderEvent(
          orderitems: [
            orderItem,
          ], // ✅ ITEM WILL BE ADDED HERE (No items error varilla)
          orders: Orders(
            userId: Supabase.instance.client.auth.currentUser!.id,
            totalAmount:
                widget
                    .directProduct!
                    .price, // ✅ Backend price safe aayi pass cheyyam
            status: "placed",
            paymentMethod: "wallet", // (Price 0 anengil mathram bypass aavan)
            shippingAddress: selectedAddress.toJson(),
            orderItems: [],
            walletUsed: 0,
          ),
        ),
      );
    } else {
      final orderitems =
          cartstate.cartitems
              .map(
                (e) => OrderItem(
                  orderId: "",
                  productId: e.productId,
                  productName: e.title,
                  productImage: e.imageUrl,
                  sku: "sku1",
                  price: e.price,
                  quantity: e.quantity,
                  productStorge: e.storeage,
                  productColor: e.color,
                  productModelNumber: e.modelNumber,
                  productrating: e.rating,
                  productNoOfRating: e.noOfRating,
                ),
              )
              .toList();

      context.read<OrderBloc>().add(
        CreateOrderEvent(
          orders: Orders(
            userId: Supabase.instance.client.auth.currentUser!.id,
            totalAmount: 0,
            status: "placed",
            paymentMethod: "wallet",
            shippingAddress: selectedAddress.toJson(),
            orderItems: [],
            walletUsed: cartstate.walletUsed,
          ),
          orderitems: orderitems,
        ),
      );
    }
  }

  void _saveAddress(AddressState state) {
    final addresses = state.addresses;
    final selectedAddressIndex = state.selectedAddressIndex;
    final addNewIndex = addresses.length;

    // Existing address selected
    if (selectedAddressIndex != addNewIndex &&
        selectedAddressIndex >= 0 &&
        selectedAddressIndex < addresses.length) {
      final entity = addresses[selectedAddressIndex];

      final updatedAddress = AddressModel.fromEntity(entity).copyWith(
        pincode:
            pincodeController.text.trim().isEmpty
                ? entity.pincode
                : pincodeController.text.trim(),
        house:
            houseController.text.trim().isEmpty
                ? entity.house
                : houseController.text.trim(),
        area:
            localityController.text.trim().isEmpty
                ? entity.area
                : localityController.text.trim(),

        landmark:
            landmarkController.text.trim().isEmpty
                ? entity.landmark
                : landmarkController.text.trim(),

        email:
            emailController.text.trim().isEmpty
                ? entity.email
                : emailController.text.trim(),

        alternatePhone:
            alternateNumberController.text.trim().isEmpty
                ? entity.alternatePhone
                : alternateNumberController.text.trim(),

        saveAs: _selectedSaveAs.toLowerCase(),
        name:
            nameController.text.trim().isEmpty
                ? entity.name
                : nameController.text.trim(),
        mobileNumber:
            mobileController.text.trim().isEmpty
                ? entity.mobileNumber
                : mobileController.text.trim(),
        state: _selectedState ?? entity.state,
        district: _selectedDistrict ?? entity.district,
      );

      context.read<AddressBloc>().add(UpdateAddressEvent(updatedAddress));
      context.pop();
      return;
    }

    // Add New selected
    _submitNewAddress(state, goToPayment: false);
  }

  void _deleteAddress(AddressState state) {
    final addresses = state.addresses;
    final selectedAddressIndex = state.selectedAddressIndex;
    final addNewIndex = addresses.length;

    // ❌ Add New selected → delete allowed alla
    if (selectedAddressIndex == addNewIndex ||
        selectedAddressIndex < 0 ||
        selectedAddressIndex >= addresses.length) {
      return;
    }

    final selectedAddress = addresses[selectedAddressIndex];

    context.read<AddressBloc>().add(DeleteAddressEvent(selectedAddress.id!));

    context.pop(); // back to address list
  }
}
