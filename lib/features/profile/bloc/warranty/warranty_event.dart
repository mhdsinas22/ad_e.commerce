import 'package:ad_e_commerce/features/profile/domain/enitites/wallet/warranty.dart';

abstract class WarrantyEvent {}

class LoadWarrantiesEvent extends WarrantyEvent {}

class SelectWarrantyEvent extends WarrantyEvent {
  final Warranty warranty;
  SelectWarrantyEvent(this.warranty);
}
