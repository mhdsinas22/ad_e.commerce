import 'package:ad_e_commerce/core/utils/app_logger.dart';
import 'package:ad_e_commerce/features/profile/bloc/wallet/wallet_event.dart';
import 'package:ad_e_commerce/features/profile/bloc/wallet/wallet_state.dart';
import 'package:ad_e_commerce/features/profile/domain/repositories/wallet_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepo walletRepo;
  WalletBloc(this.walletRepo) : super(WalletState()) {
    on<FetchWallet>(_onFetchWallet);
  }
  Future<void> _onFetchWallet(
    FetchWallet event,
    Emitter<WalletState> emit,
  ) async {
    emit(state.copyWith(status: WalletStatus.loading));
    try {
      final wallet = await walletRepo.getWallet(event.userId);
      final transactions = await walletRepo.getTransactions(wallet.id!);
      emit(
        state.copyWith(
          status: WalletStatus.success,
          transactions: transactions,
          balance: wallet.balance,
          walletNumber: wallet.walletNumber,
        ),
      );
    } catch (e) {
      AppLogger.error("Wallet Error:-${e.toString()}");
      emit(state.copyWith(status: WalletStatus.failure, error: e.toString()));
    }
  }
}
