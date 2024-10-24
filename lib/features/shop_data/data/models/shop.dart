import 'package:quantify/features/shop_data/domain/entities/Shop.dart';

class ShopModel extends ShopEntity {
  ShopModel({
    required super.id,
    required super.shopName,
    required super.phoneNumber,
    super.address,
    required super.startHour,
    required super.endHour,
    required super.email,
    required super.password,
  });

  factory ShopModel.fromJson(Map<String, dynamic> data) {
    return ShopModel(
      id: data['id'],
      shopName: data['name'],
      address: data['address'] ?? '',
      phoneNumber: data['phone'],
      startHour: data['start'],
      endHour: data['end'],
      email: data['email'],
      password: data['password'],
    );
  }

  factory ShopModel.fromEntity(ShopEntity entity) {
    return ShopModel(
      id: entity.id,
      shopName: entity.shopName,
      phoneNumber: entity.phoneNumber,
      address: entity.address,
      startHour: entity.startHour,
      endHour: entity.endHour,
      email: entity.email,
      password: entity.password,
    );
  }
}
