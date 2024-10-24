import 'package:quantify/features/shop_data/domain/entities/Shop.dart';
import 'package:quantify/features/shop_data/domain/entities/login_params.dart';

abstract class ShopEvent {}

class GetShopDataById extends ShopEvent {}

class AddShop extends ShopEvent {
  final ShopEntity shop;
  AddShop({required this.shop});
}

class LoginShop extends ShopEvent {
  final LoginParams loginParams;
  LoginShop({required this.loginParams});
}

class UpdateShop extends ShopEvent {
  final ShopEntity shop;
  UpdateShop({required this.shop});
}

class GetShopDataByEmail extends ShopEvent {
  final String email;
  GetShopDataByEmail({required this.email});
}

class LogoutFromShop extends ShopEvent {}
