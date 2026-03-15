import 'package:ad_e_commerce/features/payment/data/datasource/razorpay_datasource.dart';
import 'package:ad_e_commerce/features/payment/domain/repository/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final RazorpayDatasource datasource;
  PaymentRepositoryImpl({required this.datasource});
  @override
  Future<void> pay(int amount) async {
    datasource.openPayment(
      amount: amount,
      onSuccess: (response) {},
      onError: (response) {},
    );
  }
}
