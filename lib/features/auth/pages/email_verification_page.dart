import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/data/repositories/auth_repository.dart';
import 'package:ad_e_commerce/features/auth/bloc/email_verification/email_verification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(Supabase.instance.client),
      child: BlocProvider(
        create:
            (context) => EmailVerificationBloc(
              authRepository: context.read<AuthRepository>(),
            ),
        child: Builder(
          builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<EmailVerificationBloc>().add(
                CheckVerificationStatus(),
              );
            });
            return Scaffold(
              appBar: AppBar(
                title: const Text("Verify Email"),
                actions: [
                  BlocBuilder<EmailVerificationBloc, EmailVerificationState>(
                    builder: (context, state) {
                      return IconButton(
                        icon: const Icon(Icons.logout),
                        onPressed: () {
                          context.read<EmailVerificationBloc>().add(SignOut());
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RouteNames.login,
                            (route) => false,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              body: BlocListener<EmailVerificationBloc, EmailVerificationState>(
                listener: (context, state) {
                  if (state.status == EmailVerificationStatus.success) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteNames.mainShell,
                      (route) => false,
                    );
                  } else if (state.status == EmailVerificationStatus.failure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error ?? "Verification failed"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.mark_email_unread_outlined,
                        size: 80,
                        color: Colors.blueAccent,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Check your email",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "We've sent a verification link to your email address. Please click the link to verify your account.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 48),
                      BlocBuilder<
                        EmailVerificationBloc,
                        EmailVerificationState
                      >(
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed:
                                state.status == EmailVerificationStatus.loading
                                    ? null
                                    : () {
                                      context.read<EmailVerificationBloc>().add(
                                        CheckVerificationStatus(),
                                      );
                                    },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child:
                                state.status == EmailVerificationStatus.loading
                                    ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                    : const Text("I have verified my email"),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
    //   return  BlocProvider(
    //     create:
    //         (context) => EmailVerificationBloc(
    //           authRepository: context.read<AuthRepository>(),
    //         ),
  }
}
