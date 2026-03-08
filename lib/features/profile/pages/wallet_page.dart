import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/features/profile/bloc/wallet/wallet_bloc.dart';
import 'package:ad_e_commerce/features/profile/bloc/wallet/wallet_event.dart';
import 'package:ad_e_commerce/features/profile/bloc/wallet/wallet_state.dart';
import 'package:ad_e_commerce/features/profile/data/datasource/wallet_remote_datasource_impl.dart';
import 'package:ad_e_commerce/features/profile/data/repositories/wallet_repo_impl.dart';
import 'package:ad_e_commerce/features/profile/widgets/wallet/transaction_history_list.dart';
import 'package:ad_e_commerce/features/profile/widgets/wallet/wallet_credit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    final supabaseClient = Supabase.instance.client;

    final walletrepo = WalletRepoImpl(
      WalletRemoteDatasourceImpl(supabaseClient),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  WalletBloc(walletrepo)
                    ..add(FetchWallet(supabaseClient.auth.currentUser!.id)),
        ),
      ],
      child: WalletPageUi(),
    );
  }
}

class WalletPageUi extends StatelessWidget {
  const WalletPageUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      appBar: AppBar(
        title: const Text(
          "Wallet",
          style: TextStyle(
            color: AppColors.pureBlack,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.veryLightGrey,
              ),
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.pureBlack,
                size: 20,
              ),
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const WalletCreditCard(),
              const SizedBox(height: 32),
              BlocBuilder<WalletBloc, WalletState>(
                builder: (context, state) {
                  if (state.status == WalletStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.transactions.isEmpty) {
                    return const Center(child: Text("No transactions"));
                  }
                  if (state.error != null) {
                    return Center(child: Text(state.error.toString()));
                  }
                  return TransactionHistoryList(
                    transaction: state.transactions,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
