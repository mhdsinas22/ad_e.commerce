import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/data/repositories/auth_repository.dart';
import 'package:ad_e_commerce/data/repositories/user_repository.dart';
import 'package:ad_e_commerce/features/auth/bloc/user_details/user_details_bloc.dart';
import 'package:ad_e_commerce/features/auth/bloc/user_details/user_details_event.dart';
import 'package:ad_e_commerce/features/auth/bloc/user_details/user_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserDetailsPage extends StatelessWidget {
  final String phone;
  const UserDetailsPage({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository(Supabase.instance.client);
    final authRepository = AuthRepository(Supabase.instance.client);
    return BlocProvider(
      create:
          (context) => UserDetailsBloc(
            phone: phone,
            userRepositoryy: userRepository,
            authRepository: authRepository,
          ),
      child: _UserDetailsView(phone: phone),
    );
  }
}

class _UserDetailsView extends StatefulWidget {
  final String phone;
  const _UserDetailsView({required this.phone});

  @override
  State<_UserDetailsView> createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<_UserDetailsView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocListener<UserDetailsBloc, UserDetailsState>(
        listener: (context, state) {
          if (state.status == UserDetailsStatus.failure) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.error ?? "Falid to save user detials"),
                    backgroundColor: Colors.red,
                  ),
                );
            });
          } else if (state.status == UserDetailsStatus.success) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Profile Saved Successfully"),
                    backgroundColor: Colors.green,
                  ),
                );
              Navigator.pushReplacementNamed(context, RouteNames.home);
            });

            // Navigate to Home or Dashboard
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _NameInput(),
                  const SizedBox(height: 16),
                  const _EmailInput(),
                  const SizedBox(height: 16),
                  _Phonenumber(phone: widget.phone),
                  const SizedBox(height: 32),
                  const _PasswordInput(),
                  const SizedBox(height: 32),
                  const _SaveButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailsBloc, UserDetailsState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextFormField(
          key: const Key('userDetailsForm_nameInput_textField'),
          onChanged:
              (name) =>
                  context.read<UserDetailsBloc>().add(UsernameChanged(name)),
          decoration: const InputDecoration(
            labelText: 'Username',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailsBloc, UserDetailsState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          key: const Key('userDetailsForm_emailInput_textField'),
          onChanged:
              (email) =>
                  context.read<UserDetailsBloc>().add(EmailChanged(email)),
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailsBloc, UserDetailsState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          key: const Key('userDetailsForm_passwordInput_textField'),
          onChanged:
              (password) => context.read<UserDetailsBloc>().add(
                PasswordChanged(password),
              ),

          decoration: const InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.password_sharp),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your Password';
            }
            // if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
            //   return 'Please enter a valid email';
            // }
            return null;
          },
        );
      },
    );
  }
}

class _Phonenumber extends StatelessWidget {
  final String phone;
  const _Phonenumber({required this.phone});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: false,
      key: const Key('userDetailsForm_phoneInput_textField'),
      initialValue: phone,
      readOnly: true,
      decoration: const InputDecoration(
        labelText: 'PhoneNumber',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.phone),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your Password';
        }
        // if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
        //   return 'Please enter a valid email';
        // }
        return null;
      },
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailsBloc, UserDetailsState>(
      builder: (context, state) {
        return state.status == UserDetailsStatus.loading
            ? const Center(child: CircularProgressIndicator())
            : FilledButton(
              key: const Key('userDetailsForm_save_raisedButton'),
              onPressed: () {
                // We need to access form state to validate, but here we challenge the separation.
                // Usually the button is part of the form widget or we pass the key.
                // For this structure, we can just trigger the event and handle validation in Bloc or pass the key down.
                // The prompt asks for clean UI/Logic separation.
                // I'll assume the parent Form handles validation via a button callback if I moved button up, or I can find ancestor Form.
                // But simpler: I will access the form via `Form.of(context)` if I am inside Form.
                // Wait, `_SaveButton` is inside `Form`.
                if (Form.of(context).validate()) {
                  context.read<UserDetailsBloc>().add(SubmitUserDetails());
                }
              },
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Save Details'),
            );
      },
    );
  }
}
