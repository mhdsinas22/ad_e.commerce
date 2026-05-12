import 'package:aerstore/features/orders/domain/enities/order_logistics.dart';

class OrderLogisticsModel extends OrderLogistics {
  OrderLogisticsModel({
    super.id,
    required super.orderId,
    required super.courierPartner,
    required super.pickupLocation,
    required super.trackingNumber,
    required super.pickupDate,
  });

  factory OrderLogisticsModel.fromJson(Map<String, dynamic> json) {
    return OrderLogisticsModel(
      id: json["id"],
      orderId: json["order_id"],
      courierPartner: json["courier_partner"],
      pickupLocation: json["pickup_location"],
      trackingNumber: json["tracking_number"],
      pickupDate: DateTime.parse(json["pickup_date"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "order_id": orderId,
      "courier_partner": courierPartner,
      "pickup_location": pickupLocation,
      "tracking_number": trackingNumber,
      "pickup_date": pickupDate.toIso8601String(),
    };
  }
}
