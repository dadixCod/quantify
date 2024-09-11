import 'package:quantify/features/shop_data/domain/entities/Shop.dart';

abstract class ShopEvent {}

class GetShopData extends ShopEvent {}

class AddShop extends ShopEvent {
  final ShopEntity shop;
  AddShop({required this.shop});
}
class UpdateShop extends ShopEvent {
  final ShopEntity shop;
  UpdateShop({required this.shop});
}
