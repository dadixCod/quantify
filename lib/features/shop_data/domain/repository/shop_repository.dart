import 'package:quantify/features/shop_data/domain/entities/Shop.dart';
import 'package:quantify/features/shop_data/domain/entities/login_params.dart';

abstract class ShopRepository {
  Future<ShopEntity> getShopData(int id);
  Future<ShopEntity> getShopDataByEmail(String email);
  Future<bool> addShopData(ShopEntity shop);
  Future<bool> updateShopData(ShopEntity shop);
  Future<bool> loginShop(LoginParams loginParams);
}
