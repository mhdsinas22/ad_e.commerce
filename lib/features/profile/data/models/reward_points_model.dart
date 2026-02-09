import 'package:ad_e_commerce/features/profile/domain/enitites/wallet/reward_points.dart';

class RewardPointsModel extends RewardPoints {
  RewardPointsModel({super.id, required super.userId, required super.points});

  factory RewardPointsModel.fromJson(Map<String, dynamic> json) {
    return RewardPointsModel(
      id: json['id'],
      userId: json['user_id'],
      points: json['points'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'user_id': userId, 'points': points};
  }
}
