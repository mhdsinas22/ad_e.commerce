import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
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
  const CheckoutPage({super.key});

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

  @override
  void initState() {
    super.initState();
    context.read<AddressBloc>().add(FetchAddressEvent());
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
                        );
                      },
                    ),
                  ),
                  BlocBuilder<AddressBloc, AddressState>(
                    builder: (context, state) {
                      final userid =
                          Supabase.instance.client.auth.currentUser!.id;
                      return CheckoutButton(
                        text: 'Next',
                        onTap: () {
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
                          pincodeController.clear();
                          houseController.clear();
                          localityController.clear();
                          landmarkController.clear();
                          emailController.clear();
                          alternateNumberController.clear();
                          Appnavigotor.pushnamed(
                            context,
                            RouteNames.paymentpage,
                            [],
                          );
                        },
                      );
                    },
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
