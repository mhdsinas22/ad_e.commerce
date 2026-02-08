import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/core/widgets/primary_button.dart';
import 'package:ad_e_commerce/features/checkout/bloc/address/address_bloc.dart';
import 'package:ad_e_commerce/features/checkout/bloc/address/address_event.dart';
import 'package:ad_e_commerce/features/checkout/bloc/address/address_state.dart';
import 'package:ad_e_commerce/features/checkout/data/models/address_model.dart';
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
  bool _isEditingAddress = false;
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
    return Scaffold(
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
                    selectedSaveAs: _selectedSaveAs,
                    isEditingAddress: _isEditingAddress,
                    onSaveAsChanged: (value) {
                      setState(() {
                        _selectedSaveAs = value;
                      });
                    },
                    selectedAddressIndex: _selectedAddressIndex,
                    onAddressSelected: (index) {
                      final addresses = state.addresses;
                      final addNewIndex = addresses.length;

                      setState(() {
                        _selectedAddressIndex = index;

                        if (index == addNewIndex) {
                          // Add New
                          _isEditingAddress = true;

                          pincodeController.clear();
                          houseController.clear();
                          localityController.clear();
                          landmarkController.clear();
                          emailController.clear();
                          alternateNumberController.clear();
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
                        _selectedSaveAs = address.saveAs;
                        _selectedAddressIndex = index;
                        _isEditingAddress = true;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<AddressBloc, AddressState>(
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
                                _isFormValid ? () => _saveAddress(state) : null,
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
    );

    context.read<AddressBloc>().add(SubmitAddressEvent(address));

    if (goToPayment) {
      Appnavigotor.pushnamed(context, RouteNames.paymentpage, {
        "selectedAddress": address,
      });
    } else {
      Appnavigotor.pop(context); // back to My Address list
    }
  }

  void _onNextPressed(AddressState state) {
    final addresses = state.addresses;
    final addNewIndex = addresses.length;

    if (_selectedAddressIndex != addNewIndex) {
      Appnavigotor.pushnamed(context, RouteNames.paymentpage, {
        "selectedAddress": addresses[_selectedAddressIndex],
      });
      return;
    }

    _submitNewAddress(state, goToPayment: true);
  }

  void _saveAddress(AddressState state) {
    final addresses = state.addresses;
    final addNewIndex = addresses.length;

    // Existing address selected
    if (_selectedAddressIndex != addNewIndex) {
      final entity = addresses[_selectedAddressIndex];

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
      );

      context.read<AddressBloc>().add(UpdateAddressEvent(updatedAddress));
      Appnavigotor.pop(context);
      return;
    }

    // Add New selected
    _submitNewAddress(state, goToPayment: false);
  }

  void _deleteAddress(AddressState state) {
    final addresses = state.addresses;
    final addNewIndex = addresses.length;

    // ❌ Add New selected → delete allowed alla
    if (_selectedAddressIndex == addNewIndex) {
      return;
    }

    final selectedAddress = addresses[_selectedAddressIndex];

    context.read<AddressBloc>().add(DeleteAddressEvent(selectedAddress.id!));

    Appnavigotor.pop(context); // back to address list
  }
}
