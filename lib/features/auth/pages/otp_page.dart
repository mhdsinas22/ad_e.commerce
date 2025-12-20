import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/features/auth/bloc/otp/otp_bloc.dart';
import 'package:ad_e_commerce/features/auth/bloc/otp/otp_event.dart';
import 'package:ad_e_commerce/features/auth/bloc/otp/otp_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'user_details_page.dart';

class OtpPage extends StatelessWidget {
  final String phone;
  const OtpPage({super.key, this.phone = ""});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpBloc(phone: phone),
      child: _OtpView(phone: phone),
    );
  }
}

class _OtpView extends StatelessWidget {
  final String phone;
  const _OtpView({required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<OtpBloc, OtpState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == OtpStatus.failed) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Verification Failed'),
                  backgroundColor: Colors.red,
                ),
              );
          } else if (state.status == OtpStatus.verified) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('OTP Verified Successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => UserDetailsPage(phone: phone)),
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 100),
                Center(child: AppTexts.regular("Enter your OTP", fontSize: 19)),
                const SizedBox(height: 20),
                const _OtpInput(),
                const _TimerAndResend(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OtpInput extends StatelessWidget {
  const _OtpInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtpBloc, OtpState>(
      buildWhen: (previous, current) => previous.otpCode != current.otpCode,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: PinCodeTextField(
            appContext: context,
            length: 6,
            key: const Key('otpForm_otpInput_textField'),
            onChanged:
                (code) => context.read<OtpBloc>().add(OtpCodeChanged(code)),
            keyboardType: TextInputType.number,
            enableActiveFill: true,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(12),
              fieldHeight: 50,
              fieldWidth: 45,
              inactiveColor: Colors.transparent,
              inactiveFillColor: Colors.grey.shade200,

              selectedColor: Colors.blue,
              selectedFillColor: Colors.grey.shade200,

              activeColor: Colors.grey.shade200,
              activeFillColor: Colors.grey.shade200,
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(6),
              FilteringTextInputFormatter.digitsOnly,
            ],
            onCompleted:
                (value) => context.read<OtpBloc>().add(const OtpVerify()),
          ),
        );
      },
    );
  }
}

class _TimerAndResend extends StatelessWidget {
  const _TimerAndResend();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtpBloc, OtpState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 16),
            TextButton(
              onPressed: () => context.read<OtpBloc>().add(ResendOtp()),

              child: AppTexts.semiBold(
                'Resend Code',
                fontSize: 12,
                color: AppColors.primaryBlue,
              ),
            ),
          ],
        );
      },
    );
  }
}
