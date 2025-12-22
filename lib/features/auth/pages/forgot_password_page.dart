import 'package:ad_e_commerce/core/widgets/circular_arrow_button.dart';
import 'package:ad_e_commerce/data/repositories/auth_repository.dart';
import 'package:ad_e_commerce/features/auth/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:ad_e_commerce/features/auth/bloc/forgot_password/forgot_password_event.dart';
import 'package:ad_e_commerce/features/auth/bloc/forgot_password/forgot_password_state.dart';
import 'package:ad_e_commerce/features/auth/pages/password_recovery_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => ForgotPasswordBloc(
            authRepository: AuthRepository(Supabase.instance.client),
          ),
      child: const ForgotPasswordView(),
    );
  }
}

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool _isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state.status == ForgotPasswordStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Password reset mail sent. Please check your inbox.',
                ),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state.status == ForgotPasswordStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error ?? 'An error occurred'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Spacer(flex: 3),
                  const Text(
                    'Enter your Mail ID',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Enter your registered mail id for\nconfirmation link',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF666666),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'sh******@gmail.com',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                    builder: (context, state) {
                      return TextFormField(
                        controller: _emailController,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Mil ID',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 15,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF9F9F9),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 24,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.send,
                        onChanged: (value) {
                          context.read<ForgotPasswordBloc>().add(
                            ForgotPasswordEmailChanged(value),
                          );
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          if (!_isEmailValid(value)) {
                            return 'Email must be in valid format';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          if (_formKey.currentState!.validate()) {
                            context.read<ForgotPasswordBloc>().add(
                              ForgotPasswordSubmitted(),
                            );
                          }
                        },
                      );
                    },
                  ),
                  const Spacer(flex: 4),
                  Column(
                    children: [
                      CircularArrowButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<ForgotPasswordBloc>().add(
                              ForgotPasswordSubmitted(),
                            );
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return PasswordRecoveryPage();
                                },
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey[600],
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
