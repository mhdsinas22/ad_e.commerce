import 'package:aerstore/core/theme/app_colors.dart';
import 'package:aerstore/features/auth/bloc/reset_password/reset_password_bloc.dart';
import 'package:aerstore/features/auth/bloc/reset_password/reset_password_event.dart';
import 'package:aerstore/features/auth/bloc/reset_password/reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:aerstore/core/routes/route_names.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSubmitted() {
    if (_formKey.currentState!.validate()) {
      context.read<ResetPasswordBloc>().add(ResetPasswordSubmitted());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => ResetPasswordBloc(supabase: Supabase.instance.client),
      child: Scaffold(
        backgroundColor: AppColors.pureWhite,
        body: BlocListener<ResetPasswordBloc, ResetPasswordState>(
          listener: (context, state) {
            if (state.status == ResetPasswordStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password reset successful! Please login.'),
                  backgroundColor: Colors.green,
                ),
              );
              // Navigate to Home or Login depending on flow.
              // Since AuthStateChange.signedIn handles global redirect,
              // we might just pop or go to home if specific logic is needed.
              // Ideally, Supabase AuthState listener in main.dart will pick this up
              // if setting the password also signs them in (which it usually does).
              // But to be safe and provide good UX:
              context.goNamed(RouteNames.home);
            } else if (state.status == ResetPasswordStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error ?? 'Failed to reset password'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 60), // Top spacing to match design
                    const Text(
                      'Setup New Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: "Manrope",
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Please, setup a new password for\nyour account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontFamily: "Manrope",
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Password Field
                    BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                      buildWhen:
                          (previous, current) =>
                              previous.password != current.password,
                      builder: (context, state) {
                        return TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: "Manrope",
                          ),
                          decoration: InputDecoration(
                            hintText: 'New Password',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontFamily: "Manrope",
                            ),
                            filled: true,
                            fillColor: AppColors.offWhite,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppColors.primaryBlack,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.redAccent,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.redAccent,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 20,
                            ),
                          ),
                          onChanged: (value) {
                            context.read<ResetPasswordBloc>().add(
                              PasswordChanged(value),
                            );
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Confirm Password Field
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: "Manrope",
                      ),
                      decoration: InputDecoration(
                        hintText: 'Repeat Password',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontFamily: "Manrope",
                        ),
                        filled: true,
                        fillColor: AppColors.offWhite,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColors.primaryBlack,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.redAccent),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.redAccent),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 20,
                        ),
                      ),
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) => _onSubmitted(),
                    ),
                    const SizedBox(height: 60),

                    // Save Button
                    BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                      builder: (context, state) {
                        if (state.status == ResetPasswordStatus.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _onSubmitted,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryBlack,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Manrope",
                              ),
                            ),
                            child: const Text('Save'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Cancel Button
                    TextButton(
                      onPressed: () => context.pop(),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Manrope",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
