import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/app_text_form_field.dart';
import 'package:ad_e_commerce/core/widgets/primary_button.dart';
import 'package:ad_e_commerce/data/repositories/auth_repository.dart';
import 'package:ad_e_commerce/data/repositories/user_repository.dart';
import 'package:ad_e_commerce/features/auth/bloc/user_details/user_details_bloc.dart';
import 'package:ad_e_commerce/features/auth/bloc/user_details/user_details_event.dart';
import 'package:ad_e_commerce/features/auth/bloc/user_details/user_details_state.dart';
import 'package:ad_e_commerce/features/auth/widgets/phone_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
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
              Navigator.pushReplacementNamed(
                context,
                RouteNames.emailVerification,
              );
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
                  Row(
                    children: [
                      SvgPicture.asset(AssetConstants.complelteProfileText),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(children: [SvgPicture.asset(AssetConstants.uploadPhoto)]),
                  const SizedBox(height: 16),
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
        return AppTextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
          hintText: "Username",
          keyvalue: "userDetailsForm_nameInput_textField",
          onChanged:
              (name) =>
                  context.read<UserDetailsBloc>().add(UsernameChanged(name)),
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
        return AppTextFormField(
          hintText: "Email",
          keyvalue: "userDetailsForm_emailInput_textField",
          onChanged:
              (email) =>
                  context.read<UserDetailsBloc>().add(EmailChanged(email)),
          keyboardType: TextInputType.emailAddress,
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
        return AppTextFormField(
          hintText: "Password",
          keyvalue: 'userDetailsForm_passwordInput_textField',
          onChanged:
              (password) => context.read<UserDetailsBloc>().add(
                PasswordChanged(password),
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
    return AppPhoneInputField(
      keyvalue: "userDetailsForm_phoneInput_textField",
      onChanged: (phoneNumber) {},
      hintText: "",
      enabled: false,

      initialValue: phone,
      readOnly: true,
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
            : Column(
              children: [
                PrimaryButton(
                  text: "Done",
                  onPressed: () {
                    context.read<UserDetailsBloc>().add(SubmitUserDetails());
                  },
                ),
                SizedBox(height: 10),
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
              ],
            );
      },
    );
  }
}
