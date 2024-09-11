import 'package:quantify/features/shop_data/domain/entities/Shop.dart';

abstract class ShopRepository {
  Future<ShopEntity> getShopData();
  Future<bool> addShopData(ShopEntity shop);
  Future<bool> updateShopData(ShopEntity shop);
}
