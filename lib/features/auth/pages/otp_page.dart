import 'package:ad_e_commerce/features/auth/bloc/otp/otp_bloc.dart';
import 'package:ad_e_commerce/features/auth/bloc/otp/otp_event.dart';
import 'package:ad_e_commerce/features/auth/bloc/otp/otp_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_details_page.dart';

class OtpPage extends StatelessWidget {
  final String phone;
  const OtpPage({super.key, this.phone = ""});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpBloc(phone: phone),
      child: const _OtpView(),
    );
  }
}

class _OtpView extends StatelessWidget {
  const _OtpView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocListener<OtpBloc, OtpState>(
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
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const UserDetailsPage()));
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Enter Code',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'We have sent a 6-digit code to your phone',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                const _OtpInput(),
                const SizedBox(height: 24),
                const _TimerAndResend(),
                const Spacer(),
                const _VerifyButton(),
                const SizedBox(height: 24),
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
        return TextFormField(
          key: const Key('otpForm_otpInput_textField'),
          onChanged:
              (code) => context.read<OtpBloc>().add(OtpCodeChanged(code)),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(6),
            FilteringTextInputFormatter.digitsOnly,
          ],
          style: const TextStyle(fontSize: 24, letterSpacing: 8),
          decoration: const InputDecoration(
            hintText: '000000',
            border: OutlineInputBorder(),
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
            const Icon(Icons.timer_outlined, size: 16, color: Colors.grey),
            const SizedBox(width: 4),
            Text(
              '00:${state.timerSeconds.toString().padLeft(2, '0')}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(width: 16),
            TextButton(
              onPressed: () => context.read<OtpBloc>().add(ResendOtp()),
              child: const Text('Resend Code'),
            ),
          ],
        );
      },
    );
  }
}

class _VerifyButton extends StatelessWidget {
  const _VerifyButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtpBloc, OtpState>(
      builder: (context, state) {
        return state.status == OtpStatus.verifying
            ? const Center(child: CircularProgressIndicator())
            : FilledButton(
              key: const Key('otpForm_verify_raisedButton'),
              onPressed: () => context.read<OtpBloc>().add(const OtpVerify()),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Verify'),
            );
      },
    );
  }
}
