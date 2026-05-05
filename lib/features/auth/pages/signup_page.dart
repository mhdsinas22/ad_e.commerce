import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/app_text_form_field.dart';
import 'package:ad_e_commerce/core/widgets/primary_button.dart';
import 'package:ad_e_commerce/features/auth/bloc/signup/signup_bloc.dart';
import 'package:ad_e_commerce/features/auth/bloc/signup/signup_event.dart';
import 'package:ad_e_commerce/features/auth/bloc/signup/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignupPage extends StatelessWidget {
  final String? redirectRoute;
  final Map<String, dynamic>? redirectArgs;
  const SignupPage({super.key, this.redirectRoute, this.redirectArgs});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(),
      child: _SignupForm(
        redirectRoute: redirectRoute,
        redirectArgs: redirectArgs,
      ),
    );
  }
}

class _SignupForm extends StatefulWidget {
  final String? redirectRoute;
  final Map<String, dynamic>? redirectArgs;
  const _SignupForm({this.redirectRoute, this.redirectArgs});

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
            context.pushNamed(
              RouteNames.otp,
              extra: {
                "phone": state.phone,
                "name": state.name,
                "redirectRoute": widget.redirectRoute,
                "redirectArgs": widget.redirectArgs,
              },
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
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 35,
                            width: 100,
                            child: PrimaryButton(
                              fontsize: 12,
                              borderColor: AppColors.grayColor,
                              borderRadius: 10,
                              fontcolor: AppColors.grayColor,
                              backgroudColor: AppColors.pureWhite,
                              text: "Skip",
                              onPressed: () {
                                context.goNamed(RouteNames.mainShell);
                              },
                              needBorder: true,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 10.0,
                        ),
                        child: AppTexts.bold("Create\nAccount", fontSize: 50),
                      ),
                      const SizedBox(height: 8),
                      const SizedBox(height: 48),

                      const Spacer(flex: 6),
                      BlocBuilder<SignupBloc, SignupState>(
                        builder: (context, state) {
                          return AppTextFormField(
                            onChanged: (value) {
                              context.read<SignupBloc>().add(
                                NameChangedEvent(value),
                              );
                            },
                            padding: EdgeInsets.symmetric(horizontal: 1),
                            hintText: "Enter the Name",
                            width: double.infinity,
                            borderradiusno: 32,
                            height: 50,
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      _PhoneInput(),
                      const SizedBox(height: 20),
                      _SendOtpButton(formKey: _formKey),
                      const SizedBox(height: 30),
                      InkWell(
                        onTap: () {
                          context.pushReplacementNamed(
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
