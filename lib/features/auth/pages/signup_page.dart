import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/primary_button.dart';
import 'package:ad_e_commerce/features/auth/bloc/signup/signup_bloc.dart';
import 'package:ad_e_commerce/features/auth/bloc/signup/signup_event.dart';
import 'package:ad_e_commerce/features/auth/bloc/signup/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(),
      child: const _SignupForm(),
    );
  }
}

class _SignupForm extends StatefulWidget {
  const _SignupForm();

  @override
  State<_SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<_SignupForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is OtpSend) {
            Navigator.pushNamed(
              context,
              RouteNames.otp,
              arguments: state.phone,
            );
          }
          if (state is SignupError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 30),
                  Row(
                    children: [
                      SvgPicture.asset(AssetConstants.createAccountText),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 48),
                  const Spacer(flex: 6),
                  _PhoneInput(),
                  const SizedBox(height: 20),
                  _SendOtpButton(formKey: _formKey),
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        RouteNames.onboardingstartpage,
                      );
                    },
                    child: Center(child: AppTexts.regular("Cancel")),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PhoneInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(32),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: IntlPhoneField(
            disableLengthCheck: true,
            key: const Key('signupForm_phoneInput_textField'),
            initialCountryCode: "IN",
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'Your Number',

              border: InputBorder.none,
              prefixIcon: Icon(Icons.phone),
            ),
            dropdownTextStyle: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),

            showDropdownIcon: false,
            onChanged: (phone) {
              context.read<SignupBloc>().add(PhoneChangedEvent(phone.number));
            },
          ),
        );
      },
    );
  }
}

class _SendOtpButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const _SendOtpButton({required this.formKey});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        if (state is SignupLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return PrimaryButton(
          borderRadius: 16,
          height: 64, // Slightly taller for modern look
          width: double.infinity,
          keyy: "signupForm_continue_raisedButton",
          onPressed: () {
            if (formKey.currentState!.validate()) {
              context.read<SignupBloc>().add(SendOtpEvent());
            }
          },
          text: "Done",
        );
      },
    );
  }
}
