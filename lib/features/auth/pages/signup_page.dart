import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/features/auth/bloc/signup/signup_bloc.dart';
import 'package:ad_e_commerce/features/auth/bloc/signup/signup_event.dart';
import 'package:ad_e_commerce/features/auth/bloc/signup/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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
                  Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enter your mobile number to continue',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 48),
                  _PhoneInput(),
                  const Spacer(),
                  _SendOtpButton(formKey: _formKey),
                  const SizedBox(height: 24),
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
        return IntlPhoneField(
          key: const Key('signupForm_phoneInput_textField'),
          initialCountryCode: "IN",
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            hintText: '1234567890',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.phone),
            prefixText: '+91 ', // Example country code
          ),
          onChanged: (phone) {
            context.read<SignupBloc>().add(PhoneChangedEvent(phone.number));
          },
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return 'Please enter your phone number';
          //   }
          //   if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
          //     return 'Please enter a valid phone number';
          //   }
          //   return null;
          // },
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
        return FilledButton(
          key: const Key('signupForm_continue_raisedButton'),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              context.read<SignupBloc>().add(SendOtpEvent());
            }
          },
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Send OTP'),
        );
      },
    );
  }
}
