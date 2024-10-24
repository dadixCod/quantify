import 'package:quantify/features/shop_data/data/models/shop.dart';
import 'package:quantify/features/shop_data/data/sources/shop_sources.dart';
import 'package:quantify/features/shop_data/domain/entities/Shop.dart';
import 'package:quantify/features/shop_data/domain/entities/login_params.dart';
import 'package:quantify/features/shop_data/domain/repository/shop_repository.dart';

class ShopRepositoryImpl extends ShopRepository {
  final ShopSources datasources;
  ShopRepositoryImpl(this.datasources);

  @override
  Future<ShopModel> getShopData(int id) async {
    try {
      return await datasources.getShopData(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> addShopData(ShopEntity shop) async {
    try {
      final shopModel = ShopModel.fromEntity(shop);
      return await datasources.insertShopData(shopModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> updateShopData(ShopEntity shop) async {
    try {
      final shopModel = ShopModel.fromEntity(shop);
      return await datasources.updateShopData(shopModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ShopEntity> getShopDataByEmail(String email) async {
    return await datasources.getShopDataByEmail(email);
  }

  @override
  Future<bool> loginShop(LoginParams loginParams) async {
    return await datasources.loginShop(loginParams);
  }
}
