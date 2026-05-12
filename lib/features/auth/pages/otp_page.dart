import 'package:aerstore/core/routes/route_names.dart';
import 'package:aerstore/core/services/notification_service.dart';
import 'package:aerstore/core/theme/app_colors.dart';
import 'package:aerstore/core/widgets/app_text.dart';
import 'package:aerstore/features/auth/bloc/otp/otp_bloc.dart';
import 'package:aerstore/features/auth/bloc/otp/otp_event.dart';
import 'package:aerstore/features/auth/bloc/otp/otp_state.dart';
import 'package:aerstore/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:aerstore/features/cart/data/datasources/cart_remote_datasourceimpl.dart';
import 'package:aerstore/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:aerstore/features/notification/data/datasource/notification_remote_datasourceimpl.dart';
import 'package:aerstore/features/notification/data/repositories/notification_repo_impl.dart';
import 'package:aerstore/features/profile/data/datasource/wallet_remote_datasource_impl.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OtpPage extends StatelessWidget {
  final String phone;
  final String name;
  final String? redirectRoute;
  final Map<String, dynamic>? redirectArgs;
  const OtpPage({
    super.key,
    this.phone = "",
    this.name = "",
    this.redirectRoute,
    this.redirectArgs,
  });

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final walletRemoteDataSource = WalletRemoteDatasourceImpl(supabase);
    final cartrepository = CartRepositoryImpl(
      CartRemoteDatasourceimpl(supabase),
      CartLocalDatasource(),
    );
    final notificationService = NotificationService(
      NotificationRepoImpl(NotificationRemoteDatasourceimpl()),
    );
    return BlocProvider(
      create:
          (context) => OtpBloc(
            name: name,
            phone: phone,
            walletRemoteDataSource: walletRemoteDataSource,
            cartRepository: cartrepository,
            notificationService: notificationService,
          ),
      child: _OtpView(
        phone: phone,
        name: name,
        redirectRoute: redirectRoute,
        redirectArgs: redirectArgs,
      ),
    );
  }
}

class _OtpView extends StatelessWidget {
  final String phone;
  final String name;
  final String? redirectRoute;
  final Map<String, dynamic>? redirectArgs;
  const _OtpView({
    required this.phone,
    required this.name,
    this.redirectRoute,
    this.redirectArgs,
  });

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
            if (redirectRoute != null) {
              context.goNamed(redirectRoute!, extra: redirectArgs);
            } else {
              context.goNamed(RouteNames.mainShell);
            }
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

                /// 👇 LOADING OVERLAY
                BlocBuilder<OtpBloc, OtpState>(
                  buildWhen: (p, c) => p.status != c.status,
                  builder: (context, state) {
                    if (state.status == OtpStatus.verifying) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryBlack,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OtpInput extends StatefulWidget {
  const _OtpInput();

  @override
  State<_OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<_OtpInput> {
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtpBloc, OtpState>(
      buildWhen:
          (previous, current) =>
              previous.otpCode != current.otpCode ||
              previous.status != current.status,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: PinCodeTextField(
            focusNode: _focusNode,
            enabled: state.status != OtpStatus.verifying,
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
            onCompleted: (value) {
              context.read<OtpBloc>().add(OtpVerify());
            },
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
        final minutes = state.timerSeconds ~/ 60;
        final seconds = state.timerSeconds % 60;
        return Column(
          children: [
            AppTexts.medium(
              "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}",
              fontSize: 14,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 16),
                TextButton(
                  onPressed:
                      state.timerSeconds == 0
                          ? () => context.read<OtpBloc>().add(ResendOtp())
                          : null,

                  child: AppTexts.semiBold(
                    'Resend Code',
                    fontSize: 12,
                    color:
                        state.timerSeconds == 0
                            ? AppColors.primaryBlack
                            : Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
