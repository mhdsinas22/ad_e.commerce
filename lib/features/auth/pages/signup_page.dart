import 'package:ad_e_commerce/features/auth/bloc/signup/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'otp_page.dart';

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
          if (state.status == SignupStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Signup Failure'),
                  backgroundColor: Colors.red,
                ),
              );
          } else if (state.status == SignupStatus.otpSent) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('OTP Sent Successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const OtpPage()));
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
      buildWhen:
          (previous, current) => previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return TextFormField(
          key: const Key('signupForm_phoneInput_textField'),
          onChanged:
              (phone) =>
                  context.read<SignupBloc>().add(SignupPhoneChanged(phone)),
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            hintText: '1234567890',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.phone),
            prefixText: '+1 ', // Example country code
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your phone number';
            }
            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
              return 'Please enter a valid phone number';
            }
            return null;
          },
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
        return state.status == SignupStatus.loading
            ? const Center(child: CircularProgressIndicator())
            : FilledButton(
              key: const Key('signupForm_continue_raisedButton'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<SignupBloc>().add(
                    SignupSendOtp(state.phoneNumber),
                  );
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
