import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/data/repositories/auth_repository.dart';
import 'package:ad_e_commerce/features/auth/bloc/login/login_bloc.dart';
import 'package:ad_e_commerce/features/auth/bloc/login/login_event.dart';
import 'package:ad_e_commerce/features/auth/bloc/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PhoneLoginPage extends StatelessWidget {
  const PhoneLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authrepository = AuthRepository(Supabase.instance.client);
    return BlocProvider(
      create: (context) => LoginBloc(authRepository: authrepository),
      child: const _PhoneLoginForm(),
    );
  }
}

class _PhoneLoginForm extends StatefulWidget {
  const _PhoneLoginForm();

  @override
  State<_PhoneLoginForm> createState() => _PhoneLoginFormState();
}

class _PhoneLoginFormState extends State<_PhoneLoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _submitted = false; // ✅ ivide
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(180),
        child: AppBar(),
      ),
      backgroundColor: Colors.white,
      body: BlocListener<LoginBloc, LoginState>(
        listenWhen: (previous, current) {
          return previous.status != current.status;
        },
        listener: (context, state) {
          if (state.status == LoginStatus.failure) {
            if (state.errorMessage == "EMAIL_NOT_VERIFIED") {
              SnackBar(
                content: Text(
                  'Email verify cheythittilla. Inbox check cheyth verify cheyyuka',
                ),
              );
            }
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Authentication Failure'),
                  backgroundColor: Colors.red,
                ),
              );
          } else if (state.status == LoginStatus.success) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Login Success'),
                  backgroundColor: Colors.green,
                ),
              );
            // Navigate to Home
            Navigator.pushNamed(
              context,
              RouteNames.otp,
              arguments: {"phone": state.phone, "name": ""},
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 60),
                      AppTexts.semiBold('Login', fontSize: 52),
                      const SizedBox(height: 8),
                      AppTexts.medium('Good to see you back!', fontSize: 16),
                      const SizedBox(height: 48),
                      _UsernameInput(submitted: _submitted),
                      const SizedBox(height: 16),

                      const SizedBox(height: 24),
                      _LoginButton(
                        formKey: _formKey,
                        onSubmitAttempt: () {
                          setState(() {
                            _submitted = true;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              RouteNames.onboardingstartpage,
                            );
                          },
                          child: AppTexts.medium("Cancel", color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  final bool submitted;
  const _UsernameInput({required this.submitted});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: (context, state) {
        return TextFormField(
          autovalidateMode:
              submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
          key: const Key('loginForm_phoneInput_textField'),
          onChanged:
              (phone) =>
                  context.read<LoginBloc>().add(LoginPhoneChanged(phone)),
          decoration: InputDecoration(
            hintText: 'Phone Number',
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: const Color(0xFFF6F6F6),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(59.12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(59.12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(59.12),
              borderSide: const BorderSide(color: Color(0xFF0052FF), width: 1),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your username';
            }
            return null;
          },
        );
      },
    );
  }
}

class _LoginButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final VoidCallback onSubmitAttempt;
  const _LoginButton({required this.formKey, required this.onSubmitAttempt});

  @override
  State<_LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<_LoginButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.status == LoginStatus.loading
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
              width: double.infinity,
              child: FilledButton(
                key: const Key('loginForm_continue_raisedButton'),
                onPressed: () {
                  final phone = state.phone;
                  widget.onSubmitAttempt();
                  if (widget.formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(LoginPhoneSubmitted(phone));
                  }
                },
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF0052FF),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: AppTexts.semiBold(
                  'Next',
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            );
      },
    );
  }
}

Future<void> sendOtp(String phone) async {
  print("Calling sendOtp with: $phone");

  try {
    final response = await Supabase.instance.client.functions.invoke(
      "send-otp",
      body: {"phone": phone},
    );

    print("Status: ${response.status}");
    print("Data: ${response.data}");
  } catch (e) {
    print("Exception otp : $e");
  }
}
